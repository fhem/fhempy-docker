# syntax=docker/dockerfile:1

# base
FROM python:3.9.14 as base
RUN apt update && \
    apt install dbus python-dbus-dev rustc build-essential libssl-dev libffi-dev python3-dev cargo jq -y --no-install-recommends  \
    && rm -rf /var/lib/apt/lists/*

ARG FHEMPY_V=unset
ADD https://raw.githubusercontent.com/fhempy/fhempy/v${FHEMPY_V}/requirements.txt /

RUN mkdir -p /pip

#RUN --mount=type=bind,target/root/.cache/pip,source=./cache/pip,rw
COPY *./cache/pip /root/.cache/pip
COPY *./cache/wheels /root/.cache/wheels

# Build dependencys as wheels
RUN pip wheel --wheel-dir /wheels --find-links file:///root/.cache/wheels -r requirements.txt

# Install fhempy and gather dynamic loaded dependecys
RUN pip install fhempy==${FHEMPY_V} --no-cache --find-links file:///wheels
RUN find / -type f -name manifest.json -exec  jq -e '.requirements[]' {} + |xargs -L1 -I{} pip wheel --wheel-dir /wheels --find-links file:///root/.cache/wheels {}

# Just a stage to export our pip and wheel cache
FROM scratch AS export-stage
COPY --from=base /wheels ./wheels
COPY --from=base /root/.cache/pip ./pip

FROM python:3.9.14-slim as runtime

WORKDIR /usr/src/app

COPY requirements.txt .
COPY --from=base /wheels /wheels

ENV PIP_FIND_LINKS="file:///wheels"
RUN pip install --no-cache -r requirements.txt

# RUN rm -r /wheels

RUN apt update && \
    apt install curl -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
