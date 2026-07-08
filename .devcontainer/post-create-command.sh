#!/bin/bash

# This script is intended to be run by an Ubuntu dev container
# The goal is to install OS-level dependencies that are required before trying to install Python dependencies

echo "Installing Microsoft package repository"

# ref: https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server
curl -sSL -O https://packages.microsoft.com/config/ubuntu/$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2)/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

$ALL_DEPENDENCIES = "libpq-dev netcat-traditional unixodbc-dev default-jdk msodbcsql18"

sudo apt-get clean && sudo apt-get -y update && sudo ACCEPT_EULA='Y' apt-get -y install $ALL_DEPENDENCIES