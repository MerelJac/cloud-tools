#! /bin/bash

terraform apply \
  -var "do_token=$(cat ~/Desktop/dopat.txt)" \
  -auto-approve