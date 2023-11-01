# Inicializacion 

<img src='https://img.shields.io/github/last-commit/alphanetEX/auth01-devops' >

Un Proyecto hibrido de despliegue de replicacion en MongoDB 

enviar el contenido a la Cloud Vm via Github 

- Clonar el proyecto a /opt/tp/scripts/
```sh 
    cd /opt
    sudo git clone https://github.com/alphanetEX/auth01-devops.git
    cd auth01-devops/
    docker compose build --no-cache 
    docker compose up -d 
```

- Ejecutar el proyecto sin Escalamiento  

````non-scalabe
    cd k8s/
    chmod 750 start.sh 
    ./start.sh
```

- para acceder a a los contenedores  

```
    #acces with mongosh 
    docker exec -it mongo1 sh -c "mongosh --port 30001"
    #remote acces with DNS 
    mongosh --hosh DNS --port 3001
    #remote acces with mongodb Compass
    
```

