#!/bin/bash

# Bring down the containers
podman compose down -t 0

# Destroy Old Headscale data (but not the config!)
rm -rf headscale/{lib,run}/*

# Kill the Zellij Session
zellij delete-session --force recipe-3
