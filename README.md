# fhempy-docker
Docker Containers with [fhempy](https://github.com/fhempy/fhempy) which can be connected to [FHEM](https://fhem.de/)

# Every fhempy module comes as a seperate image.
If you want two modules, you have to start two containers.


* Debian buster
* Python 3.12.2
* fhempy 0.1.734


# How to use with docker-compose

Running fhempy in a docker environment is done by starting the container and connect it within the same network as your fhem container: 
Example is assuming, that your FHEM network is named `net` and already defined as in [fhem-docker](https://github.com/fhem/fhem-docker/blob/dev/docker-compose.yml)

```
  fhempy:
    networks:
      - net
    image: ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.4
 ```

To start your container right away:
    
    docker run -d --name fhempy ghcr.io/fhem/fhempy-docker-<modulename>:v1.4.4

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
| aktionsfinder | ghcr.io/fhem/fhempy-docker_aktionsfinder:1.4.4 |
| alphaess | ghcr.io/fhem/fhempy-docker_alphaess:1.4.4 |
| arp_presence | ghcr.io/fhem/fhempy-docker_arp_presence:1.4.4 |
| ble_monitor | ghcr.io/fhem/fhempy-docker_ble_monitor:1.4.4 |
| ble_presence | ghcr.io/fhem/fhempy-docker_ble_presence:1.4.4 |
| ble_reset | ghcr.io/fhem/fhempy-docker_ble_reset:1.4.4 |
| blue_connect | ghcr.io/fhem/fhempy-docker_blue_connect:1.4.4 |
| bt_presence | ghcr.io/fhem/fhempy-docker_bt_presence:1.4.4 |
| ddnssde | ghcr.io/fhem/fhempy-docker_ddnssde:1.4.4 |
| discover_ble | ghcr.io/fhem/fhempy-docker_discover_ble:1.4.4 |
| discover_mdns | ghcr.io/fhem/fhempy-docker_discover_mdns:1.4.4 |
| discover_upnp | ghcr.io/fhem/fhempy-docker_discover_upnp:1.4.4 |
| dlna_dmr | ghcr.io/fhem/fhempy-docker_dlna_dmr:1.4.4 |
| energie_gv_at | ghcr.io/fhem/fhempy-docker_energie_gv_at:1.4.4 |
| eq3bt | ghcr.io/fhem/fhempy-docker_eq3bt:1.4.4 |
| erelax_vaillant | ghcr.io/fhem/fhempy-docker_erelax_vaillant:1.4.4 |
| esphome | ghcr.io/fhem/fhempy-docker_esphome:1.4.4 |
| fhem_forum | ghcr.io/fhem/fhempy-docker_fhem_forum:1.4.4 |
| fusionsolar | ghcr.io/fhem/fhempy-docker_fusionsolar:1.4.4 |
| geizhals | ghcr.io/fhem/fhempy-docker_geizhals:1.4.4 |
| gfprobt | ghcr.io/fhem/fhempy-docker_gfprobt:1.4.4 |
| github_backup | ghcr.io/fhem/fhempy-docker_github_backup:1.4.4 |
| github_restore | ghcr.io/fhem/fhempy-docker_github_restore:1.4.4 |
| goodwe | ghcr.io/fhem/fhempy-docker_goodwe:1.4.4 |
| google_weather | ghcr.io/fhem/fhempy-docker_google_weather:1.4.4 |
| googlecast | ghcr.io/fhem/fhempy-docker_googlecast:1.4.4 |
| gree_climate | ghcr.io/fhem/fhempy-docker_gree_climate:1.4.4 |
| helloworld | ghcr.io/fhem/fhempy-docker_helloworld:1.4.4 |
| homekit | ghcr.io/fhem/fhempy-docker_homekit:1.4.4 |
| huawei_modbus | ghcr.io/fhem/fhempy-docker_huawei_modbus:1.4.4 |
| ikos | ghcr.io/fhem/fhempy-docker_ikos:1.4.4 |
| kia_hyundai | ghcr.io/fhem/fhempy-docker_kia_hyundai:1.4.4 |
| meross | ghcr.io/fhem/fhempy-docker_meross:1.4.4 |
| miflora | ghcr.io/fhem/fhempy-docker_miflora:1.4.4 |
| miio | ghcr.io/fhem/fhempy-docker_miio:1.4.4 |
| miscale | ghcr.io/fhem/fhempy-docker_miscale:1.4.4 |
| mitemp2 | ghcr.io/fhem/fhempy-docker_mitemp2:1.4.4 |
| mitemp | ghcr.io/fhem/fhempy-docker_mitemp:1.4.4 |
| mqtt_ha_discovery | ghcr.io/fhem/fhempy-docker_mqtt_ha_discovery:1.4.4 |
| nefit | ghcr.io/fhem/fhempy-docker_nefit:1.4.4 |
| nespresso_ble | ghcr.io/fhem/fhempy-docker_nespresso_ble:1.4.4 |
| piclock | ghcr.io/fhem/fhempy-docker_piclock:1.4.4 |
| prusalink | ghcr.io/fhem/fhempy-docker_prusalink:1.4.4 |
| pyit600 | ghcr.io/fhem/fhempy-docker_pyit600:1.4.4 |
| rct_power | ghcr.io/fhem/fhempy-docker_rct_power:1.4.4 |
| ring | ghcr.io/fhem/fhempy-docker_ring:1.4.4 |
| seatconnect | ghcr.io/fhem/fhempy-docker_seatconnect:1.4.4 |
| skodaconnect | ghcr.io/fhem/fhempy-docker_skodaconnect:1.4.4 |
| spotify | ghcr.io/fhem/fhempy-docker_spotify:1.4.4 |
| tibber | ghcr.io/fhem/fhempy-docker_tibber:1.4.4 |
| tuya_cloud | ghcr.io/fhem/fhempy-docker_tuya_cloud:1.4.4 |
| tuya | ghcr.io/fhem/fhempy-docker_tuya:1.4.4 |
| tuya_smartlife | ghcr.io/fhem/fhempy-docker_tuya_smartlife:1.4.4 |
| volvo | ghcr.io/fhem/fhempy-docker_volvo:1.4.4 |
| volvo_software_update | ghcr.io/fhem/fhempy-docker_volvo_software_update:1.4.4 |
| warema | ghcr.io/fhem/fhempy-docker_warema:1.4.4 |
| wienerlinien | ghcr.io/fhem/fhempy-docker_wienerlinien:1.4.4 |
| wienernetze_smartmeter | ghcr.io/fhem/fhempy-docker_wienernetze_smartmeter:1.4.4 |
| xiaomi_gateway3_device | ghcr.io/fhem/fhempy-docker_xiaomi_gateway3_device:1.4.4 |
| xiaomi_gateway3 | ghcr.io/fhem/fhempy-docker_xiaomi_gateway3:1.4.4 |
| xiaomi_tokens | ghcr.io/fhem/fhempy-docker_xiaomi_tokens:1.4.4 |
| zappi | ghcr.io/fhem/fhempy-docker_zappi:1.4.4 |
| zigbee2mqtt | ghcr.io/fhem/fhempy-docker_zigbee2mqtt:1.4.4 |
