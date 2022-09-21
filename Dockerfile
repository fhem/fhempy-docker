FROM python:3.9.14

WORKDIR /usr/src/app

RUN apt update && \
    apt install dbus python-dbus-dev rustc build-essential libssl-dev libffi-dev python3-dev cargo -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir fhempy==0.1.473

CMD [ "fhempy" ]
