# fhempy-docker
Docker Container with fhempy

# How to use with docker Compose

Running fhempy in a docker environment is done by starting the container and Connect ist within the same network as your fhem container: 
`
  fhempy:
    networks:
      - net
    image: ghcr.io/fhem/fhempy-docker:main
 ```
