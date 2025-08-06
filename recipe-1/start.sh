#!/bin/bash

# Build images
podman compose build wg-home
podman compose build lighthouse

# Launch the containers
podman compose up -d

# Get configs initialized
for i in $(podman container ls | grep "recipe-1" | cut -d " " -f 1); do
  podman container exec $i /peer/setup.sh
done

# Initialize Zellij
zellij -n zellij_recipe-1.kdl -s recipe-1



