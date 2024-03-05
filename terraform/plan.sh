#! /bin/bash

terraform plan \
  -var "do_token=$(cat ~/Desktop/dopat.txt)" 