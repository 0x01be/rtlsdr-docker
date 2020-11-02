FROM 0x01be/grc:build as grc

FROM alpine

RUN apk add --no-cache --virtual rtlsdr-build-dependencies \
    git \
    build-base \
    cmake

COPY --from=grc /opt/gnuradio/ /opt/gnuradio/

ENV REVISION master
RUN git clone --depth 1 --branch ${REVISION} git://git.osmocom.org/rtl-sdr /rtl-sdr

WORKDIR /rtl-sdr/build

ENV CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH}:/opt/gnuradio/

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/rtlsdr \
    ..
RUN make install

