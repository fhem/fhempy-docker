# fhempy-docker
Docker Container with fhempy

# How to use with docker Compose

```
  fhempy:
    image: ghcr.io/fhem/fhempy-docker:main
    volumes:
      - "/etc/localtime:/etc/localtime:ro"
 ```
