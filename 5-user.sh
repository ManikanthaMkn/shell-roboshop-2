#!/bin/bash

source ./0-common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup

print_time