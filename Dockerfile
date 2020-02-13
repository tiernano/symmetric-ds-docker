FROM openjdk:alpine

RUN apk add --no-cache --upgrade curl
RUN mkdir /opt/

RUN curl -L -o /opt/symmetric-ds.zip https://downloads.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.11/symmetric-server-3.11.4.zip \
&& unzip /opt/symmetric-ds.zip \
&& rm -f /opt/symmetric-ds.zip \
&& mv symmetric-server* /opt/symmetric-ds

ENV SYM_HOME /opt/symmetric-ds

VOLUME /opt/symmetric-ds/engines
VOLUME /opt/symmetric-ds/tmp
VOLUME /opt/symmetric-ds/conf
VOLUME /opt/symmetric-ds/security

EXPOSE 31415
EXPOSE 31416

CMD /opt/symmetric-ds/bin/sym_service start && tail -F /opt/symmetric-ds/logs/symmetric.log