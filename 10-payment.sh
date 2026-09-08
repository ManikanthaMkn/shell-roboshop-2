#!/bin/bash

source ./0-common.sh
app_name=payment

app_setup
python_setup

systemd_setup
print_time