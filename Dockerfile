# syntax=docker/dockerfile:1

# base fhempy will be installed
FROM python:3.11.4 as base

COPY requirements.txt ./requirements.txt

RUN apt update && \
    apt install dbus python-dbus-dev curl -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* 

RUN pip install --no-cache -r requirements.txt 


# image for fhempy (final stage) modules will be installed here
FROM base as runtime

WORKDIR /usr/src/apps

ARG PKGS=python3-dev
RUN apt update && \
    apt install $PKGS -y --no-install-recommends  \
    && rm -rf /var/lib/apt/lists/*

COPY requirements_mod.txt ./requirements.txt

ARG CARGO_NET_GIT_FETCH_WITH_CLI=true
ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1

RUN export RUSTFLAGS=" -C lto=no" && export CARGO_BUILD_TARGET="$(rustc -vV | sed -n 's|host: ||p')" && pip install --no-cache -r requirements.txt 
# RUSTFLAGS += -C linker=$(DEB_HOST_GNU_TYPE)-gcc
# Disable installing from INDEX
ENV PIP_NO_INDEX=1 


COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
