#!/bin/bash

cd "$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"/.. || return

IMAGE="${1:-$( docker images | grep '^fhempydocker/*' | grep -v "<none>" | awk '{print $3}' | uniq )}"

echo -e "\n\n"
docker images 
echo -e "\n\n"
rm -rf ./failed_variants
RETURNCODE=0

for ID in $IMAGE; do
  echo "Booting up container for variant $ID ..."
  #CONTAINER=$( docker run -d -ti --health-interval=60s --health-timeout=10s --health-start-period=150s --health-retries=5 "$ID" )
  CONTAINER=$( docker run -d -ti "$ID" )
  docker container ls  | grep 'fhempy'

  echo -ne "Waiting for container ..."
  sleep 3
  bootstate="created"
  until [ "$bootstate" != "created" ]; do
    bootstate=$( docker inspect --format="{{json .State}}" "$CONTAINER" 2>/dev/null | jq -r .Status )
    echo -n " ."
    sleep 3
  done
  if [ -z "$bootstate" ]; then
    RETURNCODE=$(( RETURNCODE+3 ))
    status="undefined-error"
  elif [ "$bootstate" != "running" ]; then
    RETURNCODE=$(( RETURNCODE+2 ))
    status=$bootstate
  fi

  if [ -z "$status" ]; then
    echo -ne "\nWaiting for health status report ..."
    healthstate="starting"
    until [ "$healthstate" != "starting" ]; do
      healthstate=$( docker inspect --format="{{json .State}}" "$CONTAINER" 2>/dev/null | jq -r .Health.Status )
      echo -n " ."
      echo $healthstate
      sleep 3
      docker logs "$CONTAINER" --since "3s"
    done
    if [ -n "$healthstate" ] && [ "$healthstate" == "healthy" ]; then
      status="OK"
    elif [ -n "$healthstate" ] && [ "$healthstate" != "null" ]; then
      status=$healthstate
    else
      echo " not defined"
      status="OK"
    fi
  fi

  if [ "$status" != "OK" ]; then
    echo -e "\nImage $ID did come up with unexpected state $status. Integration test FAILED!\n\n"
    docker logs "$CONTAINER"
    docker container rm --force --volumes  "$CONTAINER" 2>&1>/dev/null
    docker rmi "$ID" >/dev/null
    echo "$ID $status" >> ./failed_variants
    (( RETURNCODE++ ))
  else
    echo -e "\nImage $ID integration test PASSED.\n\n"
    docker container rm --force --volumes "$CONTAINER"  2>&1>/dev/null
  fi
done

exit $RETURNCODE
