FROM phusion/baseimage
MAINTAINER Ben <ben@zfben.com>

# Config system

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
RUN echo "Asia/Shanghai" | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Use Aliyun's sources

RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade

# Install common softwares

RUN apt-get install -y git-core curl wget zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev imagemagick p7zip-full

# Install Node.js

RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs npm
RUN nodejs -v
RUN npm -v

# Install Ruby

RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update && apt-get -y install ruby2.3 ruby-switch
RUN ruby-switch --set ruby2.3

RUN gem sources --remove https://rubygems.org/
RUN gem sources -a http://gems.ruby-china.org
RUN gem update --system
RUN gem install bundler
RUN ruby -v
RUN gem -v
RUN bundle -v

# Clean

RUN apt-get autoremove -y && apt-get clean
RUN rm -rf /tmp/*
