FROM python:3

WORKDIR /usr/src/app

RUN apt update && apt install dbus python-dbus-dev rustc -y
RUN pip install --no-cache-dir fhempy

CMD [ "fhempy" ]
