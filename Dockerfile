#  syntax=docker.io/docker/dockerfile:1.6.0@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021


# Building wheels for later useage
FROM python:3.12.3@sha256:3966b81808d864099f802080d897cef36c01550472ab3955fdd716d1c665acd6 as builder-base

    
RUN <<eot
    apt update 
    apt install python3-dev pkg-config  -y --no-install-recommends 
    # libc6-dev libc6-dev-armel-cross
    rm -rf /var/lib/apt/lists/*   
eot


RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y --profile=minimal \
    && rm -rf /root/.rustup/tmp

#ENV CFLAGS="-mfloat-abi=hard"

ENV PATH="/root/.cargo/bin:${PATH}"

# used for building wheels out of requirements.txt
FROM builder-base as w-builder

ARG TARGETOS 
ARG TARGETARCH
ARG TARGETVARIANT
ARG REQUIREMENTS_FILE=requirements.txt

COPY ${REQUIREMENTS_FILE} ./

ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
#ENV RUSTFLAGS=" -C lto=thin -C embed-bitcode=yes"
ENV CFLAGS="-Os -fno-plt -flto=thin"
ENV LDFLAGS="-Os -flto=thin -Wl,--as-needed"
ENV RUSTFLAGS="-C opt-level=s"
ENV ORJSON_DISABLE_YYJSON="true"

RUN --mount=type=bind,source=./wheelhouse/,target=/oldwheels  <<eot
    export CARGO_BUILD_TARGET="$(rustc -vV | sed -n 's|host: ||p')"
    ARCHDIR=$(find /oldwheels -mindepth 1 -maxdepth 2 -regextype posix-extended -type d -regex  ".*/${TARGETOS}_${TARGETARCH}(_${TARGETVARIANT})?$") 
    pip wheel --no-cache-dir --wheel-dir /wheels --find-links file:////$ARCHDIR/wheels -r ${REQUIREMENTS_FILE}
eot

# && pip wheel --wheel-dir /wheels 
#   pyaml 

FROM scratch AS export-stage
COPY --from=w-builder /wheels ./wheels


# base fhempy will be installed
FROM python:3.12.3@sha256:3966b81808d864099f802080d897cef36c01550472ab3955fdd716d1c665acd6 as base

RUN apt update && \
    apt install dbus python-dbus-dev curl -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* 

COPY requirements.txt ./requirements.txt

ARG TARGETOS 
ARG TARGETARCH
ARG TARGETVARIANT
RUN --mount=type=bind,source=./wheelhouse/,target=/wheels  <<eot
    ARCHDIR=$(find /wheels -mindepth 1 -maxdepth 2 -regextype posix-extended -type d -regex  ".*/${TARGETOS}_${TARGETARCH}(_${TARGETVARIANT})?$") 
    pip install --no-index --find-links file:////$ARCHDIR/wheels --no-cache -r requirements.txt 
eot

# image for fhempy modules (final stage) module will be installed here
FROM base as runtime

WORKDIR /usr/src/apps

#ARG PKGS=python3-dev
#RUN apt update && \
#    apt install $PKGS -y --no-install-recommends  \
#    && rm -rf /var/lib/apt/lists/*

COPY requirements_mod.txt ./requirements.txt

#ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1


# Disable installing from INDEX
ENV PIP_NO_INDEX=1 

RUN --mount=type=bind,source=./wheelhouse/,target=/wheels  <<eot
  ARCHDIR=$(find /wheels -mindepth 1 -maxdepth 2 -regextype posix-extended -type d -regex  ".*/${TARGETOS}_${TARGETARCH}(_${TARGETVARIANT})?$") 
  pip install --find-links file:////$ARCHDIR/wheels --no-cache -r requirements.txt 
eot
  #export RUSTFLAGS=" -C lto=no" 
  #export CARGO_BUILD_TARGET="$(rustc -vV | sed -n 's|host: ||p')"

COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
