FROM ubuntu:latest
MAINTAINER Boggart <github.com/Boggart>
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y software-properties-common supervisor
RUN add-apt-repository -y ppa:guacamole/stable
RUN apt-get update
RUN apt-get install -y guacamole-tomcat libguac-client-ssh0 libguac-client-rdp0

ADD ./config/guacamole.properties /etc/guacamole/
ADD ./config/user-mapping.xml /etc/guacamole/
ADD ./supervisor/supervisor.conf /etc/supervisor/supervisor.conf
ADD ./supervisor/guacamole.sv.conf /etc/supervisor/conf.d/

EXPOSE 8080 

# Activate guacd service and start tomcat under supervisor so the Docker container is persisted
CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf"]
