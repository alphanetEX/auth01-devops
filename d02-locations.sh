#!/bin/bash
Pdirectory=/data
#stable creator multiforlder 
mkrfd(){
 array=("$@") #@ ya es un arraid solo se reasigna 
 mkdir -p -- "$1" && 
 cd -P -- "$1" 
 cant="${#array[*]}"
    counter=1
    while [ $counter -lt $cant ] 
    do
    mkdir -p -- "${array[$counter]}"
    ((counter ++));
    done
    cd .. 
}

#stable creator multiarchive 
archive(){
  receptor=("$@")
  cant="${#receptor[*]}"
  pushd $1 > /dev/null
  counter=1
  while [ $counter -lt $cant ] 
    do
    touch "${receptor[$counter]}"
    ((counter ++));
    done
    popd > /dev/null
}

#mkdir -p $Pdirectory
mkrfd $Pdirectory/ pki
archive $Pdirectory node.conf
pushd / > /dev/null; chown -R $USER:$USER data; popd > /dev/null
openssl rand -base64 741 >  /data/pki/auth01-keyfile 
chmod 600 $Pdirectory/pki/auth01-keyfile
