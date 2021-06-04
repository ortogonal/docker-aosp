#
# Minimum Docker image to build Android AOSP
#
FROM ubuntu:16.04

MAINTAINER Erik Larsson <karl.erik.larsson@gmail.com>

RUN apt-get update && apt-get install -y software-properties-common

# Keep the dependency list as short as reasonable
RUN apt-get update && \
    apt-get install -y bc bison bsdmainutils build-essential curl \
        flex g++-multilib gcc-multilib git gnupg gperf lib32ncurses5-dev \
        lib32z1-dev libesd0-dev libncurses5-dev \
        libsdl1.2-dev libwxgtk3.0-dev libxml2-utils lzop sudo \
        openjdk-8-jdk kmod \
        pngcrush schedtool xsltproc zip zlib1g-dev graphviz \
        git-core gnupg flex bison gperf build-essential zip \
        curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
        x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip openssl libssl-dev \
        ccache automake lzop python-networkx bzip2 libbz2-dev libbz2-1.0 libghc-bzlib-dev \
        cgpt \
        squashfs-tools pngcrush schedtool dpkg-dev liblz4-tool optipng maven libc6-dev linux-libc-dev g++-5-multilib && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*1

RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.6

# Add a user (this is for the kernel builds whoami)
RUN useradd -ms /bin/bash docker

# All builds will be done by user aosp
COPY gitconfig /root/.gitconfig
COPY ssh_config /root/.ssh/config
COPY xxd /usr/bin/xxd
# Create app directory
RUN mkdir -p /aosp

# Work in the build directory, repo is expected to be init'd here
WORKDIR /aosp
ENV HOME /aosp
