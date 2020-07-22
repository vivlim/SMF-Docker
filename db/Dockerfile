FROM mariadb:10.4
MAINTAINER Vivian Lim <me@vvn.space>

RUN mkdir /in

COPY ./start.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/start.sh

CMD start.sh
