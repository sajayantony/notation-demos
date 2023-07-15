#!/bin/sh

set -e

echo "Forwarding registry to localhost"

socat TCP-LISTEN:5000,fork,reuseaddr TCP:notation-registry:5000 &
