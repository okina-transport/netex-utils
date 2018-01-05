#!/usr/bin/env bash

url_tiamat='https://entur.okina.fr/services/stop_places/netex?';
url_file_hosted_server='http://naq-dev01.sysnove.net:4567/netex-data';

username="$1";
password="$2";
username_file_hosted_server="$3";
password_file_hosted_server="$4";

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

UploadNeptuneFile(){
    CreateTempFolder;
    GetToken;
    echo && echo "--------------- Send Neptune File: $1 ---------------" ;
    echo "--- Download: $1 ---";
    curl -O -u "${username_file_hosted_server}:${password_file_hosted_server}" "${url_file_hosted_server}/$1";
    echo "--- Upload Neptune File to Tiamat: $1 ---" ;
    curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@"$1" ${url_tiamat}"$2";
    echo "--------------- Sent Neptune File successfully: $1 --" && echo;
    DeleteTempFolder;
}


####################################
# TOPO Places EPCI
UploadNeptuneFile "naq_topo_epci.xml" "importType=INITIAL&skipOutput=true"

####################################
# COMMUNAUTE AGGLO

##Grand Poitiers
UploadNeptuneFile "_VIT_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200069854"
#
##Perigueux Agglo
UploadNeptuneFile "_PER_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200040392"
#
##Landes/Couralin
UploadNeptuneFile "_COU_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:244000675"
#
##Landes/Yego
UploadNeptuneFile "_YEG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Bordeaux Métropole Tram
UploadNeptuneFile "_CUB_shared_data_tram" "importType=INITIAL&forceStopType=ONSTREET_TRAM&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:243300316"
##
##Bordeaux Métropole Bus
UploadNeptuneFile "_BME_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:243300316"
#
##TAC Châtellerault
UploadNeptuneFile "_CHL_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:248600413"
#
##Cognac
UploadNeptuneFile "_COG_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200070514"
#
##Brive
UploadNeptuneFile "_BRI_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200043172"
#
##Niort
UploadNeptuneFile "_NIO_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200041317"
##
##Tulle
UploadNeptuneFile "_TUT_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:241927201"
#
##La Rochelle
UploadNeptuneFile "_YEL_shared_data.xml" "importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true"
UploadNeptuneFile "_RTC_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
#
#####################################
#
##Aéroport LR
UploadNeptuneFile "_APR_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Aix/Fouras
UploadNeptuneFile "_FAI_shared_data.xml" "importType=INITIAL&forceStopType=FERRY_STOP&skipOutput=true"
#
##BAC Royan
UploadNeptuneFile "_BAC_shared_data.xml" "importType=MERGE&forceStopType=FERRY_STOP&skipOutput=true"
#
#
#####################################
## DEPARTEMENTS
#
##Transgironde
UploadNeptuneFile "_GIR_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##CG23 Creuse
UploadNeptuneFile "_CRE_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Vienne
UploadNeptuneFile "_VIE_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Vienne Interurbain
UploadNeptuneFile "_VIE_shared_data_interurbain.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Landes/XLR
UploadNeptuneFile "_LAN_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Limousin
UploadNeptuneFile "_LAN_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Charente-maritime
UploadNeptuneFile "_CHA_shared_data.xml" "importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
#####################################
#
##SNCF / Intercités
UploadNeptuneFile "_SNC_shared_data_intercites.xml" "importType=MERGE&forceStopType=RAIL_STATION&skipOutput=true"
#
##SNCF / TER
UploadNeptuneFile "_SNC_shared_data_ter.xml" "importType=MERGE&forceStopType=RAIL_STATION&skipOutput=true"
#