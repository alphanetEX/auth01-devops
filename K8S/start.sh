#!/bin/bash 

#vistual DNS simulation 
cat <<EOM >> /etc/host
127.0.0.1       mongo1
127.0.0.1       mongo2
127.0.0.1       mongo3
EOM

docker compose up -d


docker exec -it mongo1 mongosh --port 30001 --eval '
rs.initiate(
  {
    _id : 'my-replica-set',
    members: [
      { _id : 0, host : "mongo1:30001" },
      { _id : 1, host : "mongo2:30002" },
      { _id : 2, host : "mongo3:30003" }
    ]
  }
)'

