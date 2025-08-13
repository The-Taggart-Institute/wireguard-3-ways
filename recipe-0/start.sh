#!/bin/bash

# Build the image
podman compose build wg-peer-1

# Launch the containers
podman compose up -d

# Initialize Zellij
zellij -n zellij_recipe-0.kdl -s recipe-0
