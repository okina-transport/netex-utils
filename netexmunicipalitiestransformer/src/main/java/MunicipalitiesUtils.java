import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class MunicipalitiesUtils {

    public static final String SAMPLE_XLSX_FILE_PATH = "/home/gfora/dev/workspaces/netex-utils/epcicom2017.xls";

    public static void main(String[] args) throws IOException, InvalidFormatException, JDOMException {


        Map<String, String> sirenMap = buildSirenMap();
        Map<String, String> excelMap = buildExcelMap();


        File municipalities = new File("/home/gfora/dev/workspaces/netex-utils/Municipalities_kml_to_netex_topo_places/municipalities.xml");

        FileInputStream fisMuni = new FileInputStream(municipalities);
        SAXBuilder sbm = new SAXBuilder();
        Document documentMunicipalities = sbm.build(fisMuni);


        documentMunicipalities.getRootElement().getChild("dataObjects").getChild("SiteFrame").getChild("topographicPlaces")
                .getChildren("TopographicPlace").forEach(topoPlace -> {
            String inseeCommune = topoPlace.getChild("keyList").getChild("KeyValue").getChild("Value").getValue();
            String epciSiren = excelMap.get(inseeCommune);
            String topoPlaceId = sirenMap.get(epciSiren);

            if(topoPlaceId != null){
                Element parentTopographicPlaceRef = new Element("ParentTopographicPlaceRef");
                Attribute version = new Attribute("version", "1");
                Attribute ref = new Attribute("ref", topoPlaceId);
                parentTopographicPlaceRef.setAttribute(version);
                parentTopographicPlaceRef.setAttribute(ref);
                topoPlace.addContent(parentTopographicPlaceRef);
            }
        });


        FileWriter writer = new FileWriter("/home/gfora/dev/workspaces/netex-utils/Municipalities_kml_to_netex_topo_places/municipalities_ecpi.xml");
        XMLOutputter outputter = new XMLOutputter();
        outputter.setFormat(Format.getPrettyFormat());
        outputter.output(documentMunicipalities, writer);
        outputter.output(documentMunicipalities, System.out);

    }

    private static Map<String, String> buildExcelMap() throws IOException, InvalidFormatException {

        Map<String, String> map = new HashMap<String, String>();
        Workbook workbook = WorkbookFactory.create(new File(SAMPLE_XLSX_FILE_PATH));
        Sheet sheet = workbook.getSheetAt(0);
        DataFormatter dataFormatter = new DataFormatter();
        Iterator<Row> rowIterator = sheet.rowIterator();

        rowIterator.next();

        while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            DataFormatter formatter = new DataFormatter();
            String cellSirenEpci = formatter.formatCellValue(row.getCell(1));
            String cellInsee = row.getCell(9).getStringCellValue();
            map.put(cellInsee, cellSirenEpci);
        }
        return map;
    }

    private static Map<String, String> buildSirenMap() throws IOException, JDOMException {
        File epci = new File("/home/gfora/dev/workspaces/netex-utils/EPCI_kml_to_netex_topo_places/naq_topo_epci.xml");
        FileInputStream fisEPCI = new FileInputStream(epci);
        SAXBuilder sbe = new SAXBuilder();
        Document documentECPI = sbe.build(fisEPCI);
        Map<String, String> sirenEpcisIds = new HashMap();
        Element elementValueEpci = documentECPI.getRootElement();
        List<Element> epciTopoPlaces = elementValueEpci.getChild("dataObjects").getChild("SiteFrame").getChild("topographicPlaces")
                .getChildren("TopographicPlace");
        for (Element epciTopoPlace : epciTopoPlaces) {
            String topoId = epciTopoPlace.getAttribute("id").getValue();
            String SIREN = epciTopoPlace.getChild("keyList").getChild("KeyValue").getChild("Value").getValue();
            sirenEpcisIds.put(SIREN, topoId);
        }
        return sirenEpcisIds;
    }
}
