#! /bin/bash

echo ""
echo "Creating new SSH keyset..."
echo ""

USER_EMAIL="USER INPUT"
read -p "Enter email for new key ownership: " USER_EMAIL

KEY_PASSPHRASE="USER INPUT"
read -p "Enter passphrase for new key security: " KEY_PASSPHRASE

RELATIVE_LOCATION="USER INPUT"
read -p "Enter the relative location for the keys: " RELATIVE_LOCATION

ssh-keygen -t ed25519 -C ${USER_EMAIL} -N ${KEY_PASSPHRASE} -f "$(pwd)/${RELATIVE_LOCATION}"

echo ""
