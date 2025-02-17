# Copyright (C) 2024  Mark Baker <mark@vpost.net>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM ubuntu:24.04

ARG DEBIAN_FRONTEND="noninteractive"
ARG GO_VERSION=1.24.0

ENV USER="user"
ARG USER_HOME="/home/$USER"

# Install build base
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    bison \
    build-essential \
    ca-certificates \
    clang \
    cmake \
    curl \
    file \
    flex \
    g++ \
    g++-multilib \
    gawk \
    gcc-multilib \
    gettext \
    git \
    gnupg \
    less \
    libelf-dev \
    libfdt-dev \
    libncurses-dev \
    libssl-dev \
    llvm \
    lsb-release \
    nano \
    ncdu \
    openssh-client \
    python3-setuptools \
    quilt \
    rsync \
    software-properties-common \
    squashfs-tools \
    sudo \
    swig \
    tree \
    tzdata \
    unzip \
    vim \
    wget \
    zip \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget --ca-directory=/etc/ssl/certs/ https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-arm64.tar.gz \
    && rm -f go${GO_VERSION}.linux-arm64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN llvm_host_path="/usr/lib/$(ls /usr/lib/ | grep llvm | sort -r | head -1 | cut -d' ' -f11)" \
    && echo "export LLVM_HOST_PATH=$llvm_host_path" >> /etc/bash.bashrc

RUN useradd -m $USER \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} \
    && chown -R $USER:$USER "$USER_HOME" \
    && chmod g+s "$USER_HOME"

COPY ./assets/quiltrc "$USER_HOME/.quiltrc"
COPY ./assets/gitconfig "$USER_HOME/.gitconfig"
COPY ./assets/setup_pesa1234_repo.sh /tmp/setup_pesa1234_repo.sh

RUN chmod +x "/tmp/setup_pesa1234_repo.sh"

USER user

WORKDIR /home/user/openwrt

CMD ["bash"]
