#!/bin/bash
# Run the locally built Kitty without interfering with system installation

# Get the directory where this script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure the PYTHONPATH includes our build directory
export PYTHONPATH="$DIR:$PYTHONPATH"

# Run the locally built Kitty directly from the kitty directory
"$DIR/kitty/launcher/kitty" "$@"