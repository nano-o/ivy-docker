FROM debian:bullseye

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y apt-utils

# Install and configure locale `en_US.UTF-8`
RUN apt-get update && apt-get install -y locales && \
    sed -i -e "s/# $en_US.*/en_US.UTF-8 UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y git python3 python3-pip g++ cmake python3-ply python3-tk tix pkg-config libssl-dev python3-setuptools libreadline-dev sudo python3-pyparsing aptitude
RUN pip install z3-solver ipdb

# create a user:
RUN useradd -ms /bin/bash user && echo 'user:user' | chpasswd && adduser user sudo
RUN echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY --chown=user:user setup.sh /home/user/
RUN chmod +x /home/user/setup.sh

USER user
WORKDIR /home/user/
