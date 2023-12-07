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
    image: ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.0-beta.2
 ```

To start your container right away:
    
    docker run -d --name fhempy ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.0-beta.2


# Supported Modules and their image

| Module | Image name  |
|------|-------|
| ikos | ghcr.io/fhem/fhempy-docker_ikos:1.4.0-beta.2 |
| dlna_dmr | ghcr.io/fhem/fhempy-docker_dlna_dmr:1.4.0-beta.2 |
| ble_monitor | ghcr.io/fhem/fhempy-docker_ble_monitor:1.4.0-beta.2 |
| ddnssde | ghcr.io/fhem/fhempy-docker_ddnssde:1.4.0-beta.2 |
| ring | ghcr.io/fhem/fhempy-docker_ring:1.4.0-beta.2 |
| discover_mdns | ghcr.io/fhem/fhempy-docker_discover_mdns:1.4.0-beta.2 |
| erelax_vaillant | ghcr.io/fhem/fhempy-docker_erelax_vaillant:1.4.0-beta.2 |
| nespresso_ble | ghcr.io/fhem/fhempy-docker_nespresso_ble:1.4.0-beta.2 |
| tuya | ghcr.io/fhem/fhempy-docker_tuya:1.4.0-beta.2 |
| blue_connect | ghcr.io/fhem/fhempy-docker_blue_connect:1.4.0-beta.2 |
| zigbee2mqtt | ghcr.io/fhem/fhempy-docker_zigbee2mqtt:1.4.0-beta.2 |
| eq3bt | ghcr.io/fhem/fhempy-docker_eq3bt:1.4.0-beta.2 |
| spotify_connect_player | ghcr.io/fhem/fhempy-docker_spotify_connect_player:1.4.0-beta.2 |
| ble_reset | ghcr.io/fhem/fhempy-docker_ble_reset:1.4.0-beta.2 |
| googlecast | ghcr.io/fhem/fhempy-docker_googlecast:1.4.0-beta.2 |
| geizhals | ghcr.io/fhem/fhempy-docker_geizhals:1.4.0-beta.2 |
| nefit | ghcr.io/fhem/fhempy-docker_nefit:1.4.0-beta.2 |
| huawei_modbus | ghcr.io/fhem/fhempy-docker_huawei_modbus:1.4.0-beta.2 |
| seatconnect | ghcr.io/fhem/fhempy-docker_seatconnect:1.4.0-beta.2 |
| tuya_cloud | ghcr.io/fhem/fhempy-docker_tuya_cloud:1.4.0-beta.2 |
| mitemp | ghcr.io/fhem/fhempy-docker_mitemp:1.4.0-beta.2 |
| homekit | ghcr.io/fhem/fhempy-docker_homekit:1.4.0-beta.2 |
| skodaconnect | ghcr.io/fhem/fhempy-docker_skodaconnect:1.4.0-beta.2 |
| fusionsolar | ghcr.io/fhem/fhempy-docker_fusionsolar:1.4.0-beta.2 |
| volvo_software_update | ghcr.io/fhem/fhempy-docker_volvo_software_update:1.4.0-beta.2 |
| wienernetze_smartmeter | ghcr.io/fhem/fhempy-docker_wienernetze_smartmeter:1.4.0-beta.2 |
| google_weather | ghcr.io/fhem/fhempy-docker_google_weather:1.4.0-beta.2 |
| gfprobt | ghcr.io/fhem/fhempy-docker_gfprobt:1.4.0-beta.2 |
| ble_presence | ghcr.io/fhem/fhempy-docker_ble_presence:1.4.0-beta.2 |
| xiaomi_tokens | ghcr.io/fhem/fhempy-docker_xiaomi_tokens:1.4.0-beta.2 |
| kia_hyundai | ghcr.io/fhem/fhempy-docker_kia_hyundai:1.4.0-beta.2 |
| warema | ghcr.io/fhem/fhempy-docker_warema:1.4.0-beta.2 |
| meross | ghcr.io/fhem/fhempy-docker_meross:1.4.0-beta.2 |
| discover_upnp | ghcr.io/fhem/fhempy-docker_discover_upnp:1.4.0-beta.2 |
| mqtt_ha_discovery | ghcr.io/fhem/fhempy-docker_mqtt_ha_discovery:1.4.0-beta.2 |
| gree_climate | ghcr.io/fhem/fhempy-docker_gree_climate:1.4.0-beta.2 |
| mitemp2 | ghcr.io/fhem/fhempy-docker_mitemp2:1.4.0-beta.2 |
| goodwe | ghcr.io/fhem/fhempy-docker_goodwe:1.4.0-beta.2 |
| miio | ghcr.io/fhem/fhempy-docker_miio:1.4.0-beta.2 |
| discover_ble | ghcr.io/fhem/fhempy-docker_discover_ble:1.4.0-beta.2 |
| spotify | ghcr.io/fhem/fhempy-docker_spotify:1.4.0-beta.2 |
| fhem_forum | ghcr.io/fhem/fhempy-docker_fhem_forum:1.4.0-beta.2 |
| miflora | ghcr.io/fhem/fhempy-docker_miflora:1.4.0-beta.2 |
| miscale | ghcr.io/fhem/fhempy-docker_miscale:1.4.0-beta.2 |
| pyit600 | ghcr.io/fhem/fhempy-docker_pyit600:1.4.0-beta.2 |
| rct_power | ghcr.io/fhem/fhempy-docker_rct_power:1.4.0-beta.2 |
| bt_presence | ghcr.io/fhem/fhempy-docker_bt_presence:1.4.0-beta.2 |
