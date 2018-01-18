#!/usr/bin/env bash

url_tiamat='https://tiamat-rmr.nouvelle-aquitaine.pro/services/admin/netex/restoring_import?';
url_file_hosted_server='http://naq-dev01.sysnove.net:4567/netex-data';

username="$1";
password="$2";
username_file_hosted_server="$3";
password_file_hosted_server="$4";

mkdir -p netex_output_from_tiamat;

GetToken(){
    RESULT=`curl --data "grant_type=password&client_id=Tiamat&username="${username}"&password="${password} https://auth-rmr.nouvelle-aquitaine.pro/auth/realms/Naq/protocol/openid-connect/token`;
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
    echo && echo "--------------- Send Netex file File: $1 ---------------" ;
    echo "--- Download: $1 ---";
    curl -O -u "${username_file_hosted_server}:${password_file_hosted_server}" "${url_file_hosted_server}/$1.zip";
    unzip $1.zip;
    echo "--- Upload Netex File to Tiamat: $1 ---" ;
    curl -XPOST -H"Content-Type: application/xml" -H"authorization: bearer $TOKEN" -d@"$1.xml" ${url_tiamat}"$2"
    echo "--------------- Sent Netex File successfully: $1 --" && echo;
    DeleteTempFolder;
}

UploadNetexFile "tiamat-export-20180118-101032-567677" ""
