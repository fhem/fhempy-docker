FROM python:3.9.14

WORKDIR /usr/src/app

RUN apt update && apt install dbus python-dbus-dev rustc -y
RUN apt install libffi-dev libglib2.0-dev -y
RUN pip install --no-cache-dir fhempy

CMD [ "fhempy" ]
