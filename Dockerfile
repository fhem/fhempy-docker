FROM python:3.9.14

WORKDIR /usr/src/app

RUN apt update && apt install dbus python-dbus-dev rustc -y
RUN apt install libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libglib2.0-dev libdbus-1-dev bluez libbluetooth-dev
RUN pip install --no-cache-dir fhempy

CMD [ "fhempy" ]
