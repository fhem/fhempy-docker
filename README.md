# fhempy-docker
Docker Container with [fhempy](https://github.com/fhempy/fhempy) which can be connected to [FHEM](https://fhem.de/)

# Image with Perl core modules installed

* Debian 11 buster
* Python 3.9.14
* fhempy 3.9.14



# How to use with docker-compose

Running fhempy in a docker environment is done by starting the container and connect it within the same network as your fhem container: 
Example is assuming, that your FHEM network is named `net` and already defined as in [fhem-docker](https://github.com/fhem/fhem-docker/blob/dev/docker-compose.yml)

```
  fhempy:
    networks:
      - net
    image: ghcr.io/fhem/fhempy-docker:main
 ```

To start your container right away:
    
    docker run -d --name fhempy ghcr.io/fhem/fhempy-docker:main
