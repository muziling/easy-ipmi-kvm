FROM ubuntu:14.04

LABEL maintainer="Evgeny Evseev <evgeny@evseevs.ru>"
LABEL description="Version of solarkennedy/ipmi-kvm-docker x32 Java to work with supermicro's iKVM > 3.55"

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install xvfb x11vnc wget\
    supervisor fluxbox firefox:i386 libatomic1:i386 icedtea-7-plugin:i386 fonts-noto-cjk && echo Asia/Shanghai > /etc/timezone
RUN cd /usr/lib && wget https://ftp.mozilla.org/pub/firefox/releases/52.9.0esr/linux-i686/zh-CN/firefox-52.9.0esr.tar.bz2 && tar --extract --overwrite  --bzip2 --file=firefox-52.9.0esr.tar.bz2 && rm -f firefox-52.9.0esr.tar.bz2

RUN echo '{"policies": {"DisableAppUpdate": true}}' > /usr/lib/firefox/distribution/policies.json
RUN apt-get clean

RUN sed -e '/^jdk.jar.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security
RUN sed -e '/^jdk.jar.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-i386/jre/lib/security/java.security
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /root/
RUN mkdir -p /root/images
ADD novnc /root/novnc/

ENV DISPLAY :0
ENV RES 1260x700x24

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
