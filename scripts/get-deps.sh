#!/bin/bash

searchPath=${1:-./}  # Use default if nothing is set

JSON='{ "include":[] }'
readarray -t MODS < <(find "$searchPath" -type f -name manifest.json -exec sh -c 'dirname {}' \;  | sed 's|^./||')
[ -z ${GITHUB_RUN_ID+x} ] && printf '%s\n' "${MODS[@]}"
for i in "${MODS[@]}"
do
    REQS=$(jq -cr 'select(.requirements != []).requirements' ./"$i"/manifest.json)
    if [[ -z $REQS ]]; then
        REQS="[]"
    fi
    ADD_PKGS=""

    # skip problematic modules until solution found
    if [[ "$i" =~ "object_detection" ]]; then 
        continue 
    fi
    # skip spotify_connect_player because playwright dependency isn't supported on armhf
    if [[ "$i" =~ "spotify_connect_player" ]]; then 
        continue 
    fi

    if [[ "$i" =~ ^(eq3bt|gfprobt|ble_reset|blue_connect|object_detection)$ ]]; then 
        ADD_PKGS="cmake ninja-build"
    elif [[ "$i" =~ ^(seatconnect|skodaconnect|miio|xiaomi_gateway3|xiaomi_gateway3_device|pyit600|esphome|tuya|homekit)$ ]]; then 
        ADD_PKGS="rustc cargo"
    fi
    JSON=$(echo "$JSON" | jq -c --argjson REQUIREMENTS $REQS --arg PACKAGES "$ADD_PKGS" --arg M "$i" '.include += [{"module": $M, "requirements": $REQUIREMENTS, "PKGS" : $PACKAGES} ]')
done
[ -z ${GITHUB_RUN_ID+x} ] && echo $JSON || echo "matrix=$JSON" >> $GITHUB_OUTPUT

exit 0