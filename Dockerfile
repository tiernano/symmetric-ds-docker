FROM openjdk:alpine

WORKDIR /app

ADD https://netcologne.dl.sourceforge.net/project/symmetricds/symmetricds/symmetricds-3.11/symmetric-server-3.11.4.zip /app/symmetric-ds.zip
RUN unzip /app/symmetric-ds.zip
RUN rm -f /app/symmetric-ds.zip
RUN mkdir /opt/
RUN mv symmetric-server* /opt/symmetric-ds

ENV SYM_HOME /opt/symmetric-ds

VOLUME /opt/symmetric-ds/engines
VOLUME /opt/symmetric-ds/tmp
VOLUME /opt/symmetric-ds/conf
VOLUME /opt/symmetric-ds/security

EXPOSE 31415
EXPOSE 31418

CMD /opt/symmetric-ds/bin/sym_service start && tail -F /opt/symmetric-ds/logs/symmetric.log