# Use an official Ubuntu rolling as a base image
FROM ubuntu:rolling

# Set timezono for the tzdata package
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install all needed packages
RUN apt-get update && apt-get install -y \
        tar \ 
        wget \
        vim \
        git \
        subversion \
        make \
        doxygen \
        graphviz \
        unzip \
        cppcheck \
        bear 
