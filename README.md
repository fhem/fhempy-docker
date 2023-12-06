# fhempy-docker
Docker Containers with [fhempy](https://github.com/fhempy/fhempy) which can be connected to [FHEM](https://fhem.de/)

# Every image comes as a seperate image.
If you want two modules, you have to start two containers.


* Debian 11 buster
* Python 3.9.18
* fhempy 0.1.681


# How to use with docker-compose

Running fhempy in a docker environment is done by starting the container and connect it within the same network as your fhem container: 
Example is assuming, that your FHEM network is named `net` and already defined as in [fhem-docker](https://github.com/fhem/fhem-docker/blob/dev/docker-compose.yml)

```
  fhempy:
    networks:
      - net
    image: ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.0-beta.1
 ```

To start your container right away:
    
    docker run -d --name fhempy ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.0-beta.1


# Supported Modules and their image

| Module | Image name  |
|------|-------|
| googlecast | ghcr.io/fhem/fhempy-docker_googlecast:1.4.0-beta.1 |
| fhem_forum | ghcr.io/fhem/fhempy-docker_fhem_forum:1.4.0-beta.1 |
| tuya | ghcr.io/fhem/fhempy-docker_tuya:1.4.0-beta.1 |
| bt_presence | ghcr.io/fhem/fhempy-docker_bt_presence:1.4.0-beta.1 |
| geizhals | ghcr.io/fhem/fhempy-docker_geizhals:1.4.0-beta.1 |
