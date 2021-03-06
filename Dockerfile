############################################################
# Dockerfile to build MongoDB container images
# Based on Ubuntu
############################################################
#
#
#
# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Example McAuthor

WORKDIR /root

# Update the repository sources list
RUN apt-get update

ENV \ 
 SCALA_MAJOR_VERSION=2.11 \
 SBT_VERSION=0.13.8 \
 KAFKA_CLIENT_VERSION=0.10.1.0 

RUN \
 apt-get update \
 && apt-get install -y software-properties-common \
 && add-apt-repository ppa:webupd8team/java \
 && apt-get update \
 && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
 && apt-get install -y oracle-java8-installer \
 && apt-get install -y oracle-java8-set-default \
 && apt-get install -y curl \
 && apt-get install -y wget \
 && apt-get install -y vim \
 && apt-get install -y git \
 && apt-get install -y openssh-server \
 && apt-get install -y apache2 \
 && apt-get install -y libssl-dev \
 && apt-get install -y python3.5 \
 && apt-get install -y python3-pip 

RUN \
# Maven for custom builds
 apt-get install -y maven  

RUN \
 pip3 install pandas \
 && pip3 install flask==0.12 \
 && pip3 install Flask-Classy==0.6.10 \
 && pip3 install kafka-python==1.3.2 \
 && pip3 install bokeh==0.12.4

RUN \
# Sbt
 cd ~ \
 && wget https://dl.bintray.com/sbt/native-packages/sbt/${SBT_VERSION}/sbt-${SBT_VERSION}.tgz \
 && tar xvzf sbt-${SBT_VERSION}.tgz \
 && rm sbt-${SBT_VERSION}.tgz \
 && ln -s /root/sbt/bin/sbt /usr/local/bin \
# Sbt Clean - This seems weird, but it triggers the full Sbt install which involves a lot of external downloads
 && sbt clean clean-files 


RUN \
# Apache Kafka 
 cd ~ \
 && wget http://apache.claz.org/kafka/${KAFKA_CLIENT_VERSION}/kafka_${SCALA_MAJOR_VERSION}-${KAFKA_CLIENT_VERSION}.tgz \
 && tar -xvzf kafka_${SCALA_MAJOR_VERSION}-${KAFKA_CLIENT_VERSION}.tgz  \
 && rm kafka_${SCALA_MAJOR_VERSION}-${KAFKA_CLIENT_VERSION}.tgz


 
