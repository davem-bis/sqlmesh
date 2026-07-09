#!/bin/bash

# This script is intended to be run by an Ubuntu dev container

# Install OS-level dependencies
ALL_DEPENDENCIES="libpq-dev netcat-traditional unixodbc-dev default-jdk msodbcsql18"

sudo apt-get clean && sudo apt-get -y update && sudo ACCEPT_EULA='Y' apt-get -y install $ALL_DEPENDENCIES

# Install Python dependencies
make install-dev