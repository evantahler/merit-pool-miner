FROM ubuntu:xenial

WORKDIR /root/

RUN apt-get update && apt-get -qy install \
  build-essential \
  libtool \
  automake \
  autotools-dev \
  libcurl4-openssl-dev \
  libboost-dev \
  git-core

RUN git clone https://github.com/meritlabs/merit-miner.git

WORKDIR /root/merit-miner

RUN ./autogen.sh
RUN ./nomacro.pl
RUN ./configure
RUN make

ENTRYPOINT ["./minerd", "-o", "$POOL", "-u", "$ADDRESS"]
CMD "./minerd -o stratum+tcp://pool.merit.me:3333 -u @evan"
