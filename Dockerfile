FROM 0x01be/rtlsdr:build as build

FROM alpine

COPY --from=build /opt/rtlsdr/ /opt/rtlsdr/

