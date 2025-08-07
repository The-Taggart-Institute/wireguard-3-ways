#!/bin/bash

# Build images
podman compose build home-router
podman compose build lighthouse
podman compose build home-webserver

# Launch the containers
podman compose up -d

# Get configs initialized
for i in $(podman container ls | grep "wg-recipe-2" | cut -d " " -f 1); do
  podman container exec $i /peer/setup.sh
done

# Initialize Zellij
zellij -n zellij_recipe-2.kdl -s recipe-2



