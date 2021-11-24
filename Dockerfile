FROM openjdk:alpine

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="symmetricds Docker" \
        org.label-schema.description="symmetricds docker instance" \
        org.label-schema.url="https://www.tiernanotoole.ie" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/tiernano/symmetric-ds-docker" \
        org.label-schema.vendor="symmetricds" \
        org.label-schema.version=$VERSION \
        org.label-schema.schema-version="1.0"

RUN apk add --no-cache --upgrade curl
RUN mkdir /opt/

RUN curl -L -o /opt/symmetric-ds.zip https://downloads.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.13/symmetric-server-3.13.0.zip \
&& unzip /opt/symmetric-ds.zip \
&& rm -f /opt/symmetric-ds.zip \
&& mv symmetric-server* /opt/symmetric-ds

ENV SYM_HOME /opt/symmetric-ds

VOLUME /opt/symmetric-ds/engines
VOLUME /opt/symmetric-ds/tmp
VOLUME /opt/symmetric-ds/conf
VOLUME /opt/symmetric-ds/security
VOLUME /opt/symmetric-ds/logs

EXPOSE 31415
EXPOSE 31416

CMD /opt/symmetric-ds/bin/sym_service start && tail -F /opt/symmetric-ds/logs/symmetric.log
