# syntax=docker/dockerfile:1

# base
FROM debian:bullseye-slim as base

#RUN --mount=type=bind,target=./wheelhouse,source=wheelhouse,rw
COPY ./wheelhouse/ ./wheelhouse

# Delete wheels for other plattforms, we don't need them
ARG TARGETOS
ARG TARGETVARIANT
ARG TARGETARCH
RUN find ./wheelhouse -mindepth 2 -maxdepth 2 -regextype posix-extended -type d -not -regex  ".*/${TARGETOS}_${TARGETARCH}(_${TARGETVARIANT})?$" -exec rm -rv {} \; \
    && du -a ./wheelhouse

# Just a stage to export our pip and wheel cache if needed
FROM scratch AS export-stage
COPY --from=base ./wheelhouse ./cleanedwheels


# image for fhempy (final stage)
FROM python:3.9.14 as runtime

WORKDIR /usr/src/apps

COPY requirements.txt .
COPY --from=base ./wheelhouse/*/*/wheels /wheels

RUN apt update && \
    apt install dbus python-dbus-dev curl -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* 

# Install fhempy from requirements.txt and use wheels from our prebuild wheels
ENV PIP_FIND_LINKS="file:///wheels"
RUN du -a /wheels && pip install --no-cache -r requirements.txt 

# Disable installing any other wheels from outside our cache
ENV PIP_NO_INDEX=1 

# Optional install those wheels?
#RUN pip install --no-cache beautifulsoup4

COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
