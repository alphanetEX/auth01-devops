#!/bin/bash
Pdirectory=/data
#check if volume exist actual wired tiger
fill="/data/db/WiredTiger"
boolean=false;
dns=$(cat /etc/hostname)

port=$(curl -XGET --unix-socket /var/run/docker.sock http://localhost/containers/$(hostname)/json | jq '.NetworkSettings.Ports' | awk '/HostPort/{print $2}' | grep -o '[0-9]\+' | sed -n '1p');

#idctn=$(curl -XGET --unix-socket /var/run/docker.sock http://localhost/containers/$(hostname)/json | jq '.Id');
#ctn_name=$(curl -XGET --unix-socket /var/run/docker.sock http://localhost/containers/json| jq '.')

echo "$dns"

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
  bindIp : mongoc_0,localhost
  port: 27011
security:
  authorization: enabled
  keyFile: /data/pki/auth01-keyfile
replication:
  replSetName: auth01-beta
  #oplogSizeMb: 2048MB
EOF

#sed -i -e "10s/.*/  bindIp : $dns,localhost/" /data/node.conf

sed -i -e "11s/.*/  port: $port/" /data/node.conf


if [[ -f $fill ]]; then
echo ""
boolean=true
fi
mongod -f $Pdirectory/node.conf
sleep 8s

if [[ $boolean = true ]]; then
  echo ""
else



sleep 4s

mongo admin --host localhost:27011 --eval '
  db.createUser({
    user: "alphanetEX",
    pwd: "vtirhashco",
    roles: [
      {role: "root", db: "admin"}
    ]
  });'

mongo admin --port 27011 --eval 'rs.initiate()'


sleep 15s

#convert has function block
mongo --host "auth01-beta/$dns:$port" -u "alphanetEX" -p "vtirhashco" --authenticationDatabase "admin" --eval "rs.add('auth01-devops-db-wrk-1:27013');"

sleep 15s
mongo --host "auth01-beta/$dns:$port" -u "alphanetEX" -p "vtirhashco" --authenticationDatabase "admin" --eval "rs.add('auth01-devops-db-wrk-2:27012');"

fi

sleep 15s

mongo --host "auth01-beta/$dns:$port" -u "alphanetEX" -p "vtirhashco" \
--authenticationDatabase "admin"