#! /bin/bash

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '64.23.193.51,' --private-key ~/Desktop/ssh/keys ansible/apache-install.yml
