#!/bin/bash

HEADSCALE_IP=10.1.99.11

# Build images
podman compose build home-router
podman compose build headscale
podman compose build ts-client_home

# Launch the containers
podman compose up -d

# Initialize Headscale config
echo "[+] Creating hope user in Headscale"
podman container exec recipe-3_headscale headscale users create hope -d hope
echo "[+] Creating preauthkeys for home/roaming"
home_key=$(podman container exec recipe-3_headscale headscale preauthkeys create -u 1)
roaming_key=$(podman container exec recipe-3_headscale headscale preauthkeys create -u 1)

# Login Tailscale
echo "[+] Standing up Tailscale on clients"
podman container exec recipe-3_ts-client_home tailscale up --login-server http://$HEADSCALE_IP:8080 --auth-key $home_key --advertise-routes=192.168.99.0/24
podman container exec recipe-3_ts-client_roaming tailscale up --login-server http://$HEADSCALE_IP:8080 --auth-key $roaming_key

# Set up tailscaled on our tailscale clients
# for i in $(podman container ls | grep ts-client | cut -d " " -f 1); do
#   podman container exec $i tailscaled -tun=userspace-networking &2>&1>/dev/null
# done

# Initialize Zellij
zellij -n zellij_recipe-3.kdl -s recipe-3



