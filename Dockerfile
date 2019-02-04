FROM maven:3-jdk-8-alpine as builder
WORKDIR /usr/src
RUN apk add --no-cache git \
    && git clone https://github.com/sonatype-nexus-community/nexus-repository-composer.git
WORKDIR nexus-repository-composer
RUN mvn package

FROM sonatype/nexus3:3.15.2
COPY --from=builder /usr/src/nexus-repository-composer/target/nexus-repository-composer-0.0.2.jar /opt/sonatype/nexus/deploy/