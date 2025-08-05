#!/bin/bash

# Bring down the containers
podman compose down -t 0

# Kill the Zellij Session
zellij delete-session --force recipe-1
