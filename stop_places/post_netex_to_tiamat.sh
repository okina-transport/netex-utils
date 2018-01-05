#!/usr/bin/env bash

# ----------
# README
#
# ARGUMENTS TO START PROGRAM:
#   USERNAME PASSWORD integ
# or
#   USERNAME PASSWORD local
# ----------

#GET TOKEN
RESULT=`curl --data "grant_type=password&client_id=Tiamat&username=$1&password=$2" https://auth.okina.fr/auth/realms/rutebanken/protocol/openid-connect/token`;
TOKEN=`echo ${RESULT} | sed 's/.*access_token":"//g' | sed 's/".*//g'`;
echo "TOKEN : " ${TOKEN};

path_folder='./';

case "$3" in
"integ") echo "--- INTEG UPLOAD ---" ; url_tiamat='http://localhost:8585/';;
"local") echo "--- LOCAL UPLOAD ---" ; url_tiamat='https://entur.okina.fr/';;
"") echo "--- NO PLATFORM PARAM ---";;
esac

# TOPO Places EPCI
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"naq_topo_epci.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL"

####################################
# COMMUNAUTE AGGLO

##Grand Poitiers
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_VIT_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200069854"
#
##Perigueux Agglo
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_PER_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200040392"
#
##Landes/Couralin
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_COU_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:244000675"
#
##Landes/Yego
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_YEG_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Bordeaux Métropole Tram
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_CUB_shared_data_tram.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_TRAM&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:243300316"
##
##Bordeaux Métropole Bus
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_BME_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:243300316"
#
##TAC Châtellerault
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_CHL_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:248600413"
#
##Cognac
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_COG_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200070514"
#
##Brive
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_BRI_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200043172"
#
##Niort
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_NIO_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true&targetTopographicPlaces=OKI:TopographicPlace:200041317"
#
##La Rochelle
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_YEL_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=ONSTREET_BUS&skipOutput=true"
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_RTC_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
#
#####################################
#
##Aéroport LR
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_APR_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Aix/Fouras
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_FAI_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=INITIAL&forceStopType=FERRY_STOP&skipOutput=true"
#
##BAC Royan
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_BAC_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=FERRY_STOP&skipOutput=true"
#
#
#####################################
## DEPARTEMENTS
#
##Transgironde
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_GIR_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##CG23 Creuse
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_CRE_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Vienne
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_VIE_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Vienne Interurbain
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_VIE_shared_data_interurbain.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Landes/XLR
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_LAN_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Limousin
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_LIM_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
##Charente-maritime
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_CHA_shared_data.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=ONSTREET_BUS&skipOutput=true"
#
#####################################
#
##SNCF / Intercités
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_SNC_shared_data_intercites.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=RAIL_STATION&skipOutput=true"
#
##SNCF / TER
#curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@${path_folder}"_SNC_shared_data_ter.xml"  "${url_tiamat}services/stop_places/netex?importType=MERGE&forceStopType=RAIL_STATION&skipOutput=true"
#