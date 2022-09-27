#!/bin/bash

STATE=0
WEBPORT=15733
PROTO=HTTP
FHEMPY_STATE=$( curl \
                  --silent \
                  --insecure \
                  --output /dev/null \
                  --write-out "%{http_code}" \
                  --user-agent 'fhempy-docker/1.0 Health Check' \
                  "${PROTO}://{$HOSTNAME}:${WEBPORT}/healthcheck" )
if [ $? -ne 0 ] ||
   [ -z "${FHEMPY_STATE}" ] ||
   [ "${FHEMPY_STATE}" == "000" ] ||
   [ "${FHEMPY_STATE:0:1}" == "5" ]; then
  RETURN="${HOSTNAME}:(${WEBPORT}): FAILED"
  STATE=1
else
  RETURN="${HOSTNAME}:(${WEBPORT}): OK"
fi

echo -n ${RETURN}
exit ${STATE}