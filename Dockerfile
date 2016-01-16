FROM ubuntu:trusty
MAINTAINER Pharserror <sunboxnet@gmail.com>
ENV REFRESHED_AT 2016-01-15

# Setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV BITBUCKET_USER=buttfart
ENV BITBUCKET_PASS=password
ENV BITBUCKET_PROJECT=grapheneinit

USER root

# Setup User
RUN useradd --home /home/worker -M worker -K UID_MIN=10000 -K GID_MIN=10000 -s /bin/bash
RUN mkdir /home/worker
RUN chown worker:worker /home/worker
RUN adduser worker sudo
RUN echo 'worker ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER worker

# Update 
RUN sudo apt-get update
RUN sudo apt-get install -y python python-pip libpython-all-dev curl gnupg build-essential libssl-dev libyaml-dev libreadline-dev openssl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev apt-transport-https ca-certificates openssh-client

# Install graphene
RUN sudo pip install graphene

# now we add the script and make it executable
COPY ./init.sh /
COPY ./init.py /
RUN sudo chown worker:worker /init.sh
RUN sudo chown worker:worker /init.py
RUN sudo chmod +x /init.sh
RUN sudo chmod +x /init.py
ENTRYPOINT ["/init.sh"]

EXPOSE 80
