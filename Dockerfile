FROM alpine
MAINTAINER Ben <https://github.com/zfben>

# Update system
RUN apk update && apk upgrade

# Install building tools
RUN apk add ca-certificates libstdc++ tzdata build-base libxml2-dev libxslt-dev libffi-dev curl wget git p7zip bison openssh

# Install Postgresql and Redis
RUN apk add postgresql-dev postgresql redis

# Install Ruby
RUN apk add ruby ruby-dev ruby-irb ruby-rake ruby-io-console ruby-rdoc ruby-bigdecimal
RUN gem sources --remove https://rubygems.org/
RUN gem sources -a https://gems.ruby-china.org
RUN gem update --system
RUN gem install bundler rake

# Install Node.js
RUN apk add nodejs
RUN npm update --sytem
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

# Clean
RUN rm -rf /var/cache/apk/*
