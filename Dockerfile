FROM debian:jessie
MAINTAINER Jon Brouse @jonbrouse

ENV VERSION 7
ENV UPDATE 79
ENV BUILD 15
ENV JAVA_HOME /usr/lib/jvm/java-${VERSION}-oracle

RUN apt-get update && \ 
    apt-get install ca-certificates curl -y && \
    curl --silent --location --retry 3 --cacert /etc/ssl/certs/GeoTrust_Global_CA.pem \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    http://download.oracle.com/otn-pub/java/jdk/"${VERSION}"u"${UPDATE}"-b"${BUILD}"/jre-"${VERSION}"u"${UPDATE}"-linux-x64.tar.gz \
    | tar xz -C /tmp && \
    mkdir -p /usr/lib/jvm && mv /tmp/jre1.${VERSION}.0_${UPDATE} "${JAVA_HOME}" && \
    apt-get autoclean && \ 
    apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
    update-alternatives --set java "${JAVA_HOME}/bin/java" && \
    update-alternatives --set javaws "${JAVA_HOME}/bin/javaws" && \
    update-alternatives --set javac "${JAVA_HOME}/bin/javac"
