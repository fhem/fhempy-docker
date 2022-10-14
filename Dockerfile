# base
FROM python:3.10.0 as base
RUN apt update && \
    apt install dbus python-dbus-dev rustc build-essential libssl-dev libffi-dev python3-dev cargo -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ARG FHEMPY_V=unset
ADD https://raw.githubusercontent.com/fhempy/fhempy/v${FHEMPY_V}/requirements.txt /

RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt


FROM python:3.10.0-slim as runtime

WORKDIR /usr/src/app

COPY requirements.txt .
COPY --from=base /wheels /wheels
#RUN pip install --no-cache /wheels/*
RUN pip install --no-cache --find-links=/wheels -r requirements.txt
# RUN rm -r /wheels

RUN apt update && \
    apt install curl -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
