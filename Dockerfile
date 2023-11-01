FROM  alphanet/mongodev

SHELL ["/bin/bash", "-c"]

COPY . /usr/src/

WORKDIR /usr/src/

RUN ./d02-locations.sh 

