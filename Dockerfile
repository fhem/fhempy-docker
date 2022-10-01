# base
FROM python:3.9.14 as base
RUN apt update && \
    apt install dbus python-dbus-dev rustc build-essential libssl-dev libffi-dev python3-dev cargo -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ARG FHEMPY_V=unset
ADD  https://raw.githubusercontent.com/fhempy/fhempy/${FHEMPY_V}/requirements.txt /
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt


# stage
FROM python:3.9.14-slim

WORKDIR /usr/src/app

COPY --from=base /wheels /wheels
COPY --from=base requirements.txt .
RUN pip install --no-cache /wheels/*

COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh


HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]





