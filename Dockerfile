FROM busybox

MAINTAINER David Fuchs <david@davidfuchs.ca>

RUN ipkg update
RUN ipkg install wget
#RUN apt install wget
#RUN  apt-get update \
  #&& apt-get install -y wget \
  #&& rm -rf /var/lib/apt/lists/*

RUN  wget -q -O - https://www.factorio.com/download-headless/stable \
   | grep -o -m1 "/get-download/.*/headless/linux64" \
   | awk '{print "--no-check-certificate https://www.factorio.com"$1" -O /tmp/factorio.tar.gz"}' \
   | xargs wget \
  && tar -xzf /tmp/factorio.tar.gz -C /opt \
  && rm -rf /tmp/factorio.tar.gz

ADD factorio /opt/factorio/

WORKDIR /opt/factorio
CMD ["./factorio"]