# fhempy-docker
Docker Container with [fhempy](https://github.com/fhempy/fhempy) which can be connected to [FHEM](https://fhem.de/)

# Image with perl core services installed

* debian bulseye
* python 3.9.14
* fhempy 0.1.473


# How to use with docker Compose

Running fhempy in a docker environment is done by starting the container and vonnect it within the same network as your fhem container: 
Example is assuming, that your fhem newtwork is named net and already defined like in [fhem-docker](https://github.com/fhem/fhem-docker/blob/dev/docker-compose.yml)

```
  fhempy:
    networks:
      - net
    image: ghcr.io/fhem/fhempy-docker:main
 ```

To start your container right away:
    
    docker run -d --name fhempy ghcr.io/fhem/fhempy-docker:main
