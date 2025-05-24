FROM ubuntu:14.04

LABEL maintainer="Evgeny Evseev <evgeny@evseevs.ru>"
LABEL description="Version of solarkennedy/ipmi-kvm-docker x32 Java to work with supermicro's iKVM > 3.55"

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386

RUN apt-get update && apt-get -y install xvfb x11vnc \
    supervisor fluxbox firefox icedtea-7-plugin:i386 firefox-locale-zh-hans fonts-noto-cjk && echo Asia/Shanghai > /etc/timezone

RUN apt-get clean

RUN sed -e '/^jdk.jar.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /root/
RUN mkdir -p /root/images
ADD novnc /root/novnc/

ENV DISPLAY :0
ENV RES 1260x700x24
ENV PWD Astrongpassword_123

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
