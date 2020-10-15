# Use an official Ubuntu rolling as a base image
FROM ubuntu:rolling

# Copy DDEN Scripts
WORKDIR /usr

# Installation script
COPY install.sh /usr/bin
RUN chmod +x /usr/bin/install.sh

# DDEN Environment create script
COPY create.tmpl /usr/src
RUN chmod +x /usr/src/create.tmpl

# DDEN Environment unistall script
COPY uninstall.tmpl /usr/src
RUN chmod +x /usr/src/uninstall.tmpl
