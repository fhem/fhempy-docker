# fhempy-docker
Docker Containers with [fhempy](https://github.com/fhempy/fhempy) which can be connected to [FHEM](https://fhem.de/)

# Every fhempy module comes as a seperate image.
If you want two modules, you have to start two containers.


* Debian buster
* Python 3.12.2
* fhempy 0.1.729


# How to use with docker-compose

Running fhempy in a docker environment is done by starting the container and connect it within the same network as your fhem container: 
Example is assuming, that your FHEM network is named `net` and already defined as in [fhem-docker](https://github.com/fhem/fhem-docker/blob/dev/docker-compose.yml)

```
  fhempy:
    networks:
      - net
    image: ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.3
 ```

To start your container right away:
    
    docker run -d --name fhempy ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.3

# How to use fhempy 

As noted in the upstream repository, fhempy runs not in the same container as fhem.
So you have to follow, the remote peer setup instructions.

Example:
- Container ist named fhempy-googleweather
- FHEM and fhempy are on the same network
- Containernames can bei resolved via DNS

In FHEM a BindingsIO Definition must be defined, pointing to the container:
`define fhempy_peer_IP BindingsIo fhempy-googleweather:15733 fhempy`

# Supported Modules and their image

| Module | Image name  |
|------|-------|
| ble_monitor | ghcr.io/fhem/fhempy-docker_ble_monitor:1.4.3,ghcr.io/fhem/fhempy-docker_ble_monitor:1,ghcr.io/fhem/fhempy-docker_ble_monitor:latest |
| ble_presence | ghcr.io/fhem/fhempy-docker_ble_presence:1.4.3,ghcr.io/fhem/fhempy-docker_ble_presence:1,ghcr.io/fhem/fhempy-docker_ble_presence:latest |
| ble_reset | ghcr.io/fhem/fhempy-docker_ble_reset:1.4.3,ghcr.io/fhem/fhempy-docker_ble_reset:1,ghcr.io/fhem/fhempy-docker_ble_reset:latest |
| blue_connect | ghcr.io/fhem/fhempy-docker_blue_connect:1.4.3,ghcr.io/fhem/fhempy-docker_blue_connect:1,ghcr.io/fhem/fhempy-docker_blue_connect:latest |
| bt_presence | ghcr.io/fhem/fhempy-docker_bt_presence:1.4.3,ghcr.io/fhem/fhempy-docker_bt_presence:1,ghcr.io/fhem/fhempy-docker_bt_presence:latest |
| ddnssde | ghcr.io/fhem/fhempy-docker_ddnssde:1.4.3,ghcr.io/fhem/fhempy-docker_ddnssde:1,ghcr.io/fhem/fhempy-docker_ddnssde:latest |
| discover_ble | ghcr.io/fhem/fhempy-docker_discover_ble:1.4.3,ghcr.io/fhem/fhempy-docker_discover_ble:1,ghcr.io/fhem/fhempy-docker_discover_ble:latest |
| discover_upnp | ghcr.io/fhem/fhempy-docker_discover_upnp:1.4.3,ghcr.io/fhem/fhempy-docker_discover_upnp:1,ghcr.io/fhem/fhempy-docker_discover_upnp:latest |
| dlna_dmr | ghcr.io/fhem/fhempy-docker_dlna_dmr:1.4.3,ghcr.io/fhem/fhempy-docker_dlna_dmr:1,ghcr.io/fhem/fhempy-docker_dlna_dmr:latest |
| eq3bt | ghcr.io/fhem/fhempy-docker_eq3bt:1.4.3,ghcr.io/fhem/fhempy-docker_eq3bt:1,ghcr.io/fhem/fhempy-docker_eq3bt:latest |
| erelax_vaillant | ghcr.io/fhem/fhempy-docker_erelax_vaillant:1.4.3,ghcr.io/fhem/fhempy-docker_erelax_vaillant:1,ghcr.io/fhem/fhempy-docker_erelax_vaillant:latest |
| esphome | ghcr.io/fhem/fhempy-docker_esphome:1.4.3,ghcr.io/fhem/fhempy-docker_esphome:1,ghcr.io/fhem/fhempy-docker_esphome:latest |
| fhem_forum | ghcr.io/fhem/fhempy-docker_fhem_forum:1.4.3,ghcr.io/fhem/fhempy-docker_fhem_forum:1,ghcr.io/fhem/fhempy-docker_fhem_forum:latest |
| geizhals | ghcr.io/fhem/fhempy-docker_geizhals:1.4.3,ghcr.io/fhem/fhempy-docker_geizhals:1,ghcr.io/fhem/fhempy-docker_geizhals:latest |
| gfprobt | ghcr.io/fhem/fhempy-docker_gfprobt:1.4.3,ghcr.io/fhem/fhempy-docker_gfprobt:1,ghcr.io/fhem/fhempy-docker_gfprobt:latest |
| goodwe | ghcr.io/fhem/fhempy-docker_goodwe:1.4.3,ghcr.io/fhem/fhempy-docker_goodwe:1,ghcr.io/fhem/fhempy-docker_goodwe:latest |
| google_weather | ghcr.io/fhem/fhempy-docker_google_weather:1.4.3,ghcr.io/fhem/fhempy-docker_google_weather:1,ghcr.io/fhem/fhempy-docker_google_weather:latest |
| googlecast | ghcr.io/fhem/fhempy-docker_googlecast:1.4.3,ghcr.io/fhem/fhempy-docker_googlecast:1,ghcr.io/fhem/fhempy-docker_googlecast:latest |
| gree_climate | ghcr.io/fhem/fhempy-docker_gree_climate:1.4.3,ghcr.io/fhem/fhempy-docker_gree_climate:1,ghcr.io/fhem/fhempy-docker_gree_climate:latest |
| homekit | ghcr.io/fhem/fhempy-docker_homekit:1.4.3,ghcr.io/fhem/fhempy-docker_homekit:1,ghcr.io/fhem/fhempy-docker_homekit:latest |
| huawei_modbus | ghcr.io/fhem/fhempy-docker_huawei_modbus:1.4.3,ghcr.io/fhem/fhempy-docker_huawei_modbus:1,ghcr.io/fhem/fhempy-docker_huawei_modbus:latest |
| ikos | ghcr.io/fhem/fhempy-docker_ikos:1.4.3,ghcr.io/fhem/fhempy-docker_ikos:1,ghcr.io/fhem/fhempy-docker_ikos:latest |
| kia_hyundai | ghcr.io/fhem/fhempy-docker_kia_hyundai:1.4.3,ghcr.io/fhem/fhempy-docker_kia_hyundai:1,ghcr.io/fhem/fhempy-docker_kia_hyundai:latest |
| meross | ghcr.io/fhem/fhempy-docker_meross:1.4.3,ghcr.io/fhem/fhempy-docker_meross:1,ghcr.io/fhem/fhempy-docker_meross:latest |
| miflora | ghcr.io/fhem/fhempy-docker_miflora:1.4.3,ghcr.io/fhem/fhempy-docker_miflora:1,ghcr.io/fhem/fhempy-docker_miflora:latest |
| miio | ghcr.io/fhem/fhempy-docker_miio:1.4.3,ghcr.io/fhem/fhempy-docker_miio:1,ghcr.io/fhem/fhempy-docker_miio:latest |
| miscale | ghcr.io/fhem/fhempy-docker_miscale:1.4.3,ghcr.io/fhem/fhempy-docker_miscale:1,ghcr.io/fhem/fhempy-docker_miscale:latest |
| mitemp2 | ghcr.io/fhem/fhempy-docker_mitemp2:1.4.3,ghcr.io/fhem/fhempy-docker_mitemp2:1,ghcr.io/fhem/fhempy-docker_mitemp2:latest |
| mitemp | ghcr.io/fhem/fhempy-docker_mitemp:1.4.3,ghcr.io/fhem/fhempy-docker_mitemp:1,ghcr.io/fhem/fhempy-docker_mitemp:latest |
| mqtt_ha_discovery | ghcr.io/fhem/fhempy-docker_mqtt_ha_discovery:1.4.3,ghcr.io/fhem/fhempy-docker_mqtt_ha_discovery:1,ghcr.io/fhem/fhempy-docker_mqtt_ha_discovery:latest |
| nefit | ghcr.io/fhem/fhempy-docker_nefit:1.4.3,ghcr.io/fhem/fhempy-docker_nefit:1,ghcr.io/fhem/fhempy-docker_nefit:latest |
| nespresso_ble | ghcr.io/fhem/fhempy-docker_nespresso_ble:1.4.3,ghcr.io/fhem/fhempy-docker_nespresso_ble:1,ghcr.io/fhem/fhempy-docker_nespresso_ble:latest |
| piclock | ghcr.io/fhem/fhempy-docker_piclock:1.4.3,ghcr.io/fhem/fhempy-docker_piclock:1,ghcr.io/fhem/fhempy-docker_piclock:latest |
| prusalink | ghcr.io/fhem/fhempy-docker_prusalink:1.4.3,ghcr.io/fhem/fhempy-docker_prusalink:1,ghcr.io/fhem/fhempy-docker_prusalink:latest |
| pyit600 | ghcr.io/fhem/fhempy-docker_pyit600:1.4.3,ghcr.io/fhem/fhempy-docker_pyit600:1,ghcr.io/fhem/fhempy-docker_pyit600:latest |
| rct_power | ghcr.io/fhem/fhempy-docker_rct_power:1.4.3,ghcr.io/fhem/fhempy-docker_rct_power:1,ghcr.io/fhem/fhempy-docker_rct_power:latest |
| ring | ghcr.io/fhem/fhempy-docker_ring:1.4.3,ghcr.io/fhem/fhempy-docker_ring:1,ghcr.io/fhem/fhempy-docker_ring:latest |
| seatconnect | ghcr.io/fhem/fhempy-docker_seatconnect:1.4.3,ghcr.io/fhem/fhempy-docker_seatconnect:1,ghcr.io/fhem/fhempy-docker_seatconnect:latest |
| skodaconnect | ghcr.io/fhem/fhempy-docker_skodaconnect:1.4.3,ghcr.io/fhem/fhempy-docker_skodaconnect:1,ghcr.io/fhem/fhempy-docker_skodaconnect:latest |
| spotify | ghcr.io/fhem/fhempy-docker_spotify:1.4.3,ghcr.io/fhem/fhempy-docker_spotify:1,ghcr.io/fhem/fhempy-docker_spotify:latest |
| tibber | ghcr.io/fhem/fhempy-docker_tibber:1.4.3,ghcr.io/fhem/fhempy-docker_tibber:1,ghcr.io/fhem/fhempy-docker_tibber:latest |
| tuya_cloud | ghcr.io/fhem/fhempy-docker_tuya_cloud:1.4.3,ghcr.io/fhem/fhempy-docker_tuya_cloud:1,ghcr.io/fhem/fhempy-docker_tuya_cloud:latest |
| tuya | ghcr.io/fhem/fhempy-docker_tuya:1.4.3,ghcr.io/fhem/fhempy-docker_tuya:1,ghcr.io/fhem/fhempy-docker_tuya:latest |
| tuya_smartlife | ghcr.io/fhem/fhempy-docker_tuya_smartlife:1.4.3,ghcr.io/fhem/fhempy-docker_tuya_smartlife:1,ghcr.io/fhem/fhempy-docker_tuya_smartlife:latest |
| volvo_software_update | ghcr.io/fhem/fhempy-docker_volvo_software_update:1.4.3,ghcr.io/fhem/fhempy-docker_volvo_software_update:1,ghcr.io/fhem/fhempy-docker_volvo_software_update:latest |
| warema | ghcr.io/fhem/fhempy-docker_warema:1.4.3,ghcr.io/fhem/fhempy-docker_warema:1,ghcr.io/fhem/fhempy-docker_warema:latest |
| wienernetze_smartmeter | ghcr.io/fhem/fhempy-docker_wienernetze_smartmeter:1.4.3,ghcr.io/fhem/fhempy-docker_wienernetze_smartmeter:1,ghcr.io/fhem/fhempy-docker_wienernetze_smartmeter:latest |
| xiaomi_gateway3_device | ghcr.io/fhem/fhempy-docker_xiaomi_gateway3_device:1.4.3,ghcr.io/fhem/fhempy-docker_xiaomi_gateway3_device:1,ghcr.io/fhem/fhempy-docker_xiaomi_gateway3_device:latest |
| xiaomi_gateway3 | ghcr.io/fhem/fhempy-docker_xiaomi_gateway3:1.4.3,ghcr.io/fhem/fhempy-docker_xiaomi_gateway3:1,ghcr.io/fhem/fhempy-docker_xiaomi_gateway3:latest |
| xiaomi_tokens | ghcr.io/fhem/fhempy-docker_xiaomi_tokens:1.4.3,ghcr.io/fhem/fhempy-docker_xiaomi_tokens:1,ghcr.io/fhem/fhempy-docker_xiaomi_tokens:latest |
| zappi | ghcr.io/fhem/fhempy-docker_zappi:1.4.3,ghcr.io/fhem/fhempy-docker_zappi:1,ghcr.io/fhem/fhempy-docker_zappi:latest |
| zigbee2mqtt | ghcr.io/fhem/fhempy-docker_zigbee2mqtt:1.4.3,ghcr.io/fhem/fhempy-docker_zigbee2mqtt:1,ghcr.io/fhem/fhempy-docker_zigbee2mqtt:latest |
