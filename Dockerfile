FROM openjdk:8-alpine

ENV SONARQUBE_SCANNER_VERSION "3.1.0.1141"

LABEL maintainer="Willie Loyd Tandingan <n3v3rf411@gmail.com>"

WORKDIR /root
RUN set -x && \
  apk add --no-cache  curl grep sed unzip && \
  curl --insecure -o ./sonarscanner.zip -L https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONARQUBE_SCANNER_VERSION}-linux.zip && \
  unzip sonarscanner.zip && \
  rm sonarscanner.zip && \
  rm sonar-scanner-${SONARQUBE_SCANNER_VERSION}-linux/jre -rf && \
#   ensure Sonar uses the provided Java for musl instead of a borked glibc one
  sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /root/sonar-scanner-${SONARQUBE_SCANNER_VERSION}-linux/bin/sonar-scanner

ENV SONAR_RUNNER_HOME=/root/sonar-scanner-${SONARQUBE_SCANNER_VERSION}-linux
ENV PATH $PATH:/root/sonar-scanner-${SONARQUBE_SCANNER_VERSION}-linux/bin

COPY sonar-runner.properties ./sonar-scanner-${SONARQUBE_SCANNER_VERSION}-linux/conf/sonar-scanner.properties

WORKDIR /root/src
CMD sonar-scanner
