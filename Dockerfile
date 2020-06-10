# FROM mattrayner/lamp:latest-1804
FROM nimmis/apache-php5
RUN apt-get update && apt-get install -y mysql-server git

COPY setup.sql /root/setup.sql
COPY setup.sh /root/setup.sh

RUN git clone https://git.code.sf.net/p/dragongoserver/dgs-main /root/dragongoserver-dgs-main
RUN /bin/bash /root/setup.sh

CMD ["/bin/bash", "/go.sh"]
