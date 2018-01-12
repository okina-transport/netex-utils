#!/usr/bin/env bash

url_tiamat='https://entur.okina.fr/services/stop_places/netex?';
#url_tiamat='http://localhost:8585/services/stop_places/netex?';
url_file_hosted_server='http://naq-dev01.sysnove.net:4567/netex-data';

username="$1";
password="$2";
username_file_hosted_server="$3";
password_file_hosted_server="$4";

mkdir -p netex_output_from_tiamat;

GetToken(){
    RESULT=`curl --data "grant_type=password&client_id=Tiamat&username="${username}"&password="${password} https://auth.okina.fr/auth/realms/rutebanken/protocol/openid-connect/token`;
    TOKEN=`echo ${RESULT} | sed 's/.*access_token":"//g' | sed 's/".*//g'`;
    echo && echo "TOKEN : " ${TOKEN};
}

DeleteTempFolder(){
    cd ..
    rm -rf downloaded-files;
}

CreateTempFolder(){
    mkdir downloaded-files;
    cd downloaded-files;
}

UploadGTFSFile(){
    CreateTempFolder;
    GetToken;
    echo && echo "--------------- Send GTFS File: $2 ---------------" ;
    echo "--- Download: $2 ---";
    curl -O -u "${username_file_hosted_server}:${password_file_hosted_server}" "${url_file_hosted_server}/$2";
    echo "--- Upload Netex File to Tiamat: $2 ---" ;
    curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@"$2" ${url_tiamat}"$3" > ../netex_output_from_tiamat/$1.xml
    echo "--------------- Sent Netex File successfully: $2 --" && echo;
    DeleteTempFolder;
}


####################################
# TOPO Places EPCI

#UploadGTFSFile "topo" "naq_topo_epci.xml" "importType=INITIAL&skipOutput=false"
#
#####################################
## COMMUNAUTE AGGLO
#
### Tulle
#UploadGTFSFile "TUT" "_TUT_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Bordeaux Métropole
#UploadGTFSFile "BME_bus" "_BME_shared_data_bus.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#UploadGTFSFile "BME_tram" "_BME_shared_data_tram.xml" "importType=INITIAL&forceStopType=ONSTREET_TRAM&skipOutput=false"
#
### Grand Poitiers
#UploadGTFSFile "VIT" "_VIT_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Perigueux Agglo
#UploadGTFSFile "PER" "_PER_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Grand Dax/Couralin
#UploadGTFSFile "COU" "_COU_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Royan
#UploadGTFSFile "ROY" "_ROY_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### MACS/Yego
#UploadGTFSFile "YEG" "_YEG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Brive
#UploadGTFSFile "BRI" "_BRI_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Limoges
#UploadGTFSFile "LIM" "_LIM_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### La Rochelle
#UploadGTFSFile "YEL" "_YEL_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#UploadGTFSFile "RTC" "_RTC_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Rochefort
#UploadGTFSFile "ROC" "_ROC_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Niort
#UploadGTFSFile "CAN" "_CAN_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Val de Garonne - Marmande
#UploadGTFSFile "VDG" "_VDG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

#
#
#
#
######################################
### FROM SIMs
##
###Angoulème - STGA
#UploadGTFSFile "ANG" "_ANG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
###TAC Châtellerault
#UploadGTFSFile "CHL" "_CHL_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
###Cognac
#UploadGTFSFile "COG" "_COG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
#
###Aéroport La Rochelle
#UploadGTFSFile "APR" "_APR_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
###BAC Royan
#UploadGTFSFile "BAC" "_BAC_shared_data.xml" "importType=MERGE&forceStopType=FERRY_STOP&skipOutput=false"
#
###Aix/Fouras
#UploadGTFSFile "FAI" "_FAI_shared_data.xml" "importType=INITIAL&forceStopType=FERRY_STOP&skipOutput=false"
#
#
#######################################
#### DEPARTEMENTS

### Charente-maritime
#UploadGTFSFile "CHA" "_CHA_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Lot-et-Garonne
#UploadGTFSFile "LGA" "_LGA_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Transport 64
#UploadGTFSFile "PAT" "_PAT_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Landes/XLR
#UploadGTFSFile "LAN" "_LAN_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Transgironde
#UploadGTFSFile "GIR" "_GIR_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### CG23 Creuse
#UploadGTFSFile "CRE" "_CRE_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"
#
### Vienne Interurbain
#UploadGTFSFile "VIE" "_VIE_shared_data_interurbain.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"



######################################
### SNCF
#
###SNCF / Intercités
UploadGTFSFile "SNC_inter" "_SNC_shared_data_intercites.xml" "importType=INITIAL&forceStopType=RAIL_STATION&skipOutput=false"

##SNCF / TER
UploadGTFSFile "SNC_ter" "_SNC_shared_data_ter.xml" "importType=INITIAL&forceStopType=RAIL_STATION&skipOutput=false"
#
#

