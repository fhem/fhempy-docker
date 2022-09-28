FROM python:3.9.14
WORKDIR /usr/src/app
COPY src/health-check.sh /health-check.sh
RUN chmod +x /health-check.sh

RUN apt update && \
    apt install dbus python-dbus-dev rustc build-essential libssl-dev libffi-dev python3-dev cargo -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ARG FHEMPY_V=unset
COPY ./requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
