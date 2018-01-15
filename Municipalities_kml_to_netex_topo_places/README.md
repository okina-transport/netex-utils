# KML to Netex topo places XSL transformation

XSL Transformation to Netex Topographical places

Kml contains Municipalities for Nouvelle-Aquitaine area

Tested with saxon 9.7 

    java -cp ~/path/to/saxon/saxon9he.jar net.sf.saxon.Transform -s:path/to/kml/file.kml  -xsl:path/to/transofrmation/file.xsl -o:/path/to/output/netex/file.xml;

Download saxon here : https://sourceforge.net/projects/saxon/files/Saxon-HE/9.7/

For 5 municipalities containing MultiGeometry shapes, the minor shape have been stripped out for now to succeed in XSD transformation. Should fix that.
Stripped file is limite-commune-NAQ-apres-nettoyage.kml.