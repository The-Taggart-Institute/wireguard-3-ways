#!/bin/bash

# Bring down the containers
podman compose down -t 0

# Kill the Zellij Session
zellij kill-session recipe-1
