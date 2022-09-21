FROM python:3.9.14

WORKDIR /usr/src/app

RUN apt update && apt install dbus python-dbus-dev rustc -y
RUN pip install --no-cache-dir fhempy==0.1.473

CMD [ "fhempy" ]
