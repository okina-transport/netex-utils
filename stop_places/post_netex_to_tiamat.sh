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

UploadNetexFile(){
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
### TOPO Places EPCI
#UploadNetexFile "topo" "naq_topo_epci.xml" "importType=INITIAL&skipOutput=false"
#
### TOPO PLaces municipalities
#UploadNetexFile "municipalities" "municipalities.xml" "importType=INITIAL&skipOutput=true"

#####################################
## COMMUNAUTE AGGLO
#
## Tulle
#UploadNetexFile "TUT" "_TUT_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Bordeaux Métropole
UploadNetexFile "BME_bus" "_BME_shared_data_bus.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
UploadNetexFile "BME_tram" "_BME_shared_data_tram.xml" "importType=INITIAL&forceStopType=ONSTREET_TRAM&skipOutput=false"

## Grand Poitiers
UploadNetexFile "VIT" "_VIT_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Perigueux Agglo
UploadNetexFile "PER" "_PER_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Grand Dax/Couralin
UploadNetexFile "COU" "_COU_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Royan
UploadNetexFile "ROY" "_ROY_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## MACS/Yego
UploadNetexFile "YEG" "_YEG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Brive
UploadNetexFile "BRI" "_BRI_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Limoges
UploadNetexFile "LIM" "_LIM_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## La Rochelle
UploadNetexFile "YEL" "_YEL_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"
UploadNetexFile "RTC" "_RTC_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## Rochefort
UploadNetexFile "ROC" "_ROC_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Niort
UploadNetexFile "NIO" "_NIO_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

## Val de Garonne - Marmande
UploadNetexFile "VDG" "_VDG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

#
#
#
#
######################################
### FROM SIMs
##
##Angoulème - STGA
UploadNetexFile "ANG" "_ANG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

##TAC Châtellerault
UploadNetexFile "CHL" "_CHL_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

##Cognac
UploadNetexFile "COG" "_COG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=false"

##Aéroport La Rochelle
UploadNetexFile "APR" "_APR_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

##BAC Royan
UploadNetexFile "BAC" "_BAC_shared_data.xml" "importType=MERGE&forceStopType=FERRY_STOP&skipOutput=false"

##Aix/Fouras
UploadNetexFile "FAI" "_FAI_shared_data.xml" "importType=INITIAL&forceStopType=FERRY_STOP&skipOutput=false"


######################################
### DEPARTEMENTS

## Charente-maritime
UploadNetexFile "CMA" "_CMA_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## Lot-et-Garonne
UploadNetexFile "LGA" "_LGA_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## Transport 64
UploadNetexFile "PAT" "_PAT_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## Landes/XLR
UploadNetexFile "LAN" "_LAN_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## Transgironde
UploadNetexFile "GIR" "_GIR_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## CG23 Creuse
UploadNetexFile "CRE" "_CRE_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"

## Vienne Interurbain
UploadNetexFile "VIE" "_VIE_shared_data_interurbain.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=false"



#####################################
## SNCF

###SNCF / Intercités
UploadNetexFile "SNC_inter" "_SNC_shared_data_intercites.xml" "importType=INITIAL&forceStopType=RAIL_STATION&skipOutput=false"

##SNCF / TER
UploadNetexFile "SNC_ter" "_SNC_shared_data_ter.xml" "importType=INITIAL&forceStopType=RAIL_STATION&skipOutput=false"



