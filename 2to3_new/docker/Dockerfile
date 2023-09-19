ARG FROM_IMAGE
FROM ${FROM_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apt-utils

# Install and configure locale `en_US.UTF-8`
RUN apt-get update && apt-get install -y locales && \
    sed -i -e "s/# $en_US.*/en_US.UTF-8 UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

ARG USERNAME=user
ENV USERNAME=${USERNAME}
ARG USER_UID=1000
ENV USER_UID=${USER_UID}
ARG USER_GID=${USER_UID}
ENV USER_HOME=/home/${USERNAME}

RUN apt-get --yes update \
  && apt-get install --yes sudo

# Create the user and group and add them to sudoers list
RUN groupadd --gid=${USER_GID} ${USERNAME} \
  && useradd --shell=/bin/bash --uid=${USER_UID} --gid=${USER_GID} --create-home ${USERNAME} \
  && echo "${USERNAME}  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get --yes update \
  && apt-get install --no-install-recommends --yes \
  unzip \
  wget \
  aptitude \
  curl \
  git \
  python3 \
  python3-pip \
  software-properties-common \
  gpg-agent \
  gdb \
  build-essential \
  python3-pynvim \
  universal-ctags \
  python3-pylsp \
  tmux \
  clangd \
  ripgrep \
  pkg-config \
  && apt-get clean


USER ${USERNAME}
WORKDIR ${USER_HOME}

ENV PATH="${PATH}:/home/user/.local/bin:/home/user/bin/"
RUN mkdir /home/user/bin/
# Create a bashrc file
RUN echo "export PATH=\"${PATH}\":\${PATH}" >> ${USER_HOME}/.bashrc

# install neovim
RUN wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
RUN tar -xzf nvim-linux64.tar.gz && rm nvim-linux64.tar.gz
RUN cp -r nvim-linux64/* /home/user/ && rm -r nvim-linux64
RUN chmod u+x /home/user/bin/nvim

# configure neovim:
RUN mkdir /home/user/.config/
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ENV USER_UID=1000
COPY --chown=${USER_UID}:${USER_UID} ./nvim/ /home/user/.config/nvim/
RUN nvim -u /home/user/.config/nvim/docker-init.vim --headless +'PlugInstall --sync' +qa
# for some reason this fails in the previous command; so we do it again:
RUN nvim -u /home/user/.config/nvim/docker-init.vim --headless +'TSUpdateSync' +qa

# tmux stuff
ENV TERM="xterm-256color"
COPY --chown=${USER_UID}:${USER_UID} ./.tmux.conf /home/user/.tmux.conf

# install ivy
# TODO do that in another build as it takes a while and we don't want to redo it when we change something else

RUN pip install ipdb

USER root
RUN apt-get --yes update \
  && apt-get install --no-install-recommends --yes \
  g++ cmake python3-ply python3-tk tix libssl-dev python3-setuptools libreadline-dev python3-pyparsing python-is-python3
USER ${USERNAME}

RUN git clone https://github.com/nano-o/ivy.git
WORKDIR /home/user/ivy/
RUN git checkout 2to3new
RUN git submodule update --init
RUN python3 build_submodules.py
# we must have /home/user/ivy/ in PYTHONPATH or we get the notorious 'relative imports' error
# we must have /home/user/ivy/ivy/ in PYTHONPATH to import the z3 module
ENV PYTHONPATH=/home/user/ivy/:/home/user/ivy/ivy/
# RUN pip install pyparsing tarjan
RUN pip install --editable .
WORKDIR ${USER_HOME}
