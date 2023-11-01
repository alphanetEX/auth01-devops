#!/bin/bash
Pdirectory=/data
dns=$(cat /etc/hostname)
port=$(curl -XGET --unix-socket /var/run/docker.sock http://localhost/containers/$(hostname)/json | jq '.NetworkSettings.Ports' | awk '/HostPort/{print $2}' | grep -o '[0-9]\+' | sed -n '1p');

echo "the port $port";
echo "dns: $dns"

cat <<EOF >> /data/node.conf
storage:
  dbPath: "/data/db/"
systemLog:
  path: "/data/db/mongod.log"
  destination: "file"
  logAppend: true
processManagement:
  fork : true
net:
  bindIp : [],localhost
  port: 27012
security:
  keyFile: /data/pki/auth01-keyfile
replication:
  replSetName: auth01-beta
  #oplogSizeMb: 2048MB
EOF


sed -i -e "10s/.*/  bindIp : $dns,localhost/" /data/node.conf
sed -i -e "11s/.*/  port : $port/g" /data/node.conf

#cat /data/node.conf


mongod -f $Pdirectory/node.conf

echo "$dns:$port"

#mongo --host  "$dns:$port"
mongo --host "$dns:$port"
sleep 4s

#mongo --port $portx