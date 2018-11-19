FROM ubuntu:18.04

RUN apt update
RUN apt install -y git nodejs curl dosfstools mtools gnupg2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update
RUN apt install yarn -y

COPY ./scripts /scripts

CMD sh /scripts/build.sh
