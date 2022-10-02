# base
FROM python:3.9.14 as base
RUN apt update && \
    apt install dbus python-dbus-dev rustc build-essential libssl-dev libffi-dev python3-dev cargo -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ARG FHEMPY_V=unset
ADD  https://raw.githubusercontent.com/fhempy/fhempy/v${FHEMPY_V}/requirements.txt /
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt


FROM python:3.9.14-slim as runtime

WORKDIR /usr/src/app

COPY --from=base /wheels /wheels
COPY requirements.txt .
RUN pip install --no-cache /wheels/*
RUN pip install --no-cache -r requirements

COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]





