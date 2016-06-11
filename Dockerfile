FROM phusion/baseimage
MAINTAINER Ben <ben@zfben.com>

RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade && apt-get clean
