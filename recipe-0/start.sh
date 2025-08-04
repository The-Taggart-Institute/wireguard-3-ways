#!/bin/bash

# Build the image
podman image build -t wg-recipe-0:latest .

# Launch the containers
podman compose up -d

# Initialize Zellij
zellij --layout zellij_recipe-0.kdl
