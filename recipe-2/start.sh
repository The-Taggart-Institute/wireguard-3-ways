#!/bin/bash

# Build images
podman compose build wg-roaming
podman compose build home-router
podman compose build lighthouse
podman compose build home-webserver

# Launch the containers
podman compose up -d

# Get configs initialized
for i in $(podman container ls | grep "wg-recipe-2" | cut -d " " -f 1); do
  podman container exec $i /peer/setup.sh
done

# Recipe 2 Specific setup

# Get the public keys
lighthouse_pubkey=$(podman container exec wg-recipe-2_lighthouse grep "#PublicKey" /etc/wireguard/recipe-2.conf | cut -d " " -f 3)
router_pubkey=$(podman container exec wg-recipe-2_home-router grep "#PublicKey" /etc/wireguard/recipe-2.conf | cut -d " " -f 3)
roaming_pubkey=$(podman container exec wg-recipe-2_roaming grep "#PublicKey" /etc/wireguard/recipe-2.conf | cut -d " " -f 3)

# Assign public keys
podman container exec wg-recipe-2_home-router sed -i "s|<<LIGHTHOUSE_PUBLIC_KEY>>|$lighthouse_pubkey|" /etc/wireguard/recipe-2.conf
podman container exec wg-recipe-2_roaming sed -i "s|<<LIGHTHOUSE_PUBLIC_KEY>>|$lighthouse_pubkey|" /etc/wireguard/recipe-2.conf
podman container exec wg-recipe-2_lighthouse sed -i "s|<<ROUTER_PUBLIC_KEY>>|$router_pubkey|" /etc/wireguard/recipe-2.conf
podman container exec wg-recipe-2_lighthouse sed -i "s|<<ROAMING_PUBLIC_KEY>>|$roaming_pubkey|" /etc/wireguard/recipe-2.conf

# Initialize Zellij
zellij -n zellij_recipe-2.kdl -s recipe-2
