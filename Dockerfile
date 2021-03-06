FROM alpine:3.5

LABEL maintainer="jbn@falsifiable.com"

WORKDIR /app

RUN apk add --update alpine-sdk autoconf automake build-base clang cmake \
    libtool make m4 zlib-dev git && \
    rm -rf /var/cache/apk/* && \
    git clone https://github.com/jmcnamara/libxlsxwriter.git && \
    cd libxlsxwriter && make && make install && \
    cd .. && rm -rf libxlsxwriter && \
    git clone https://github.com/rgamble/libcsv && \
    cd libcsv && ./configure && make && make install && \
    cd .. && rm -rf libcsv && \
    git clone https://github.com/WizardMac/ReadStat.git && \
    cd ReadStat && ./autogen.sh && ./configure && make && make install && \
    cd .. && rm -rf ReadStat && \
    apk del autoconf automake build-base clang cmake make m4 git 

WORKDIR /data

ENTRYPOINT ["/usr/local/bin/readstat"]
