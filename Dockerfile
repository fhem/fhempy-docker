FROM python:3.9.14

WORKDIR /usr/src/app
COPY src/health-check.sh /health-check.sh

RUN apt update && apt install dbus python-dbus-dev rustc -y
RUN pip install --no-cache-dir fhempy

HEALTHCHECK --interval=50s --timeout=15s --start-period=10s --retries=3 CMD /health-check.sh

CMD [ "fhempy" ]
