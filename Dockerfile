FROM haproxy:1.6.5-alpine

RUN apk add --no-cache wget ca-certificates bash python py-pip

RUN mkdir /app
WORKDIR /app

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.7.3/docker-gen-alpine-linux-amd64-0.7.3.tar.gz
RUN tar xvzf docker-gen-alpine-linux-amd64-0.7.3.tar.gz -C /bin

RUN pip install python-etcd

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD echo $ETCD_CACERT > /app/cacert.pem && docker-gen -interval 10 -watch -notify "python /tmp/register.py" etcd.tmpl /tmp/register.py
