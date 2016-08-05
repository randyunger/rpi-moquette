#i86
#FROM dordoka/rpi-java8

#ARM
FROM hypriot/rpi-alpine-scratch

MAINTAINER Randle Unger <randy.unger@gmail.com>

ENV MOQUETTE_VERSION 0.8

# Get wget
RUN  apk update \
  && apk add wget \
#  && rm -rf /var/lib/apt/lists/*

# Get Moquette
RUN wget --quiet --no-cookies https://bintray.com/artifact/download/andsel/generic/distribution-${MOQUETTE_VERSION}-bundle-tar.tar.gz -O /tmp/moquette.tgz

RUN mkdir /opt/moquette
RUN tar xzvf /tmp/moquette.tgz -C /opt/moquette
RUN rm -r /tmp/moquette.tgz

# Delete old conf file
RUN rm /opt/moquette/config/moquette.conf

ADD moquette.conf /opt/moquette/conf

EXPOSE 1883 8080 8883
#EXPOSE 8080
#EXPOSE 8883

WORKDIR /opt/moquette/bin

ENTRYPOINT ["./moquette.sh"]

