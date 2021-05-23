FROM node:13.5 AS node
FROM ruby:2.5.0

ENV TZ Asia/Tokyo
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libmcrypt-dev imagemagick

# Node.js
COPY --from=node /usr/local/bin/node /usr/local/bin/

# yarn
COPY --from=node /opt/yarn-v1.21.1 /opt/yarn-v1.21.1/
RUN ln -s /opt/yarn-v1.21.1/bin/yarn /usr/local/bin/yarn && ln -s /opt/yarn-v1.21.1/bin/yarnpkg /usr/local/bin/yarnpkg

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
#RUN yarn install
COPY . /myapp
