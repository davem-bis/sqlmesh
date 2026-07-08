#!/bin/bash

# This script is intended to be run by an Ubuntu dev container
# The goal is to ensure that symlinks are appropriately set in git, and that development dependencies are installed.

# Check current value of core.symlinks
current_value =$(git config --get core.symlinks)

if [ "$current_value" != "true "]; then
    echo "core.symlinks is '$current_value', setting to true."
    git confit core.symlinks true

    # Detect all symlinks tracked in git and refresh them.
    symlinks=$(git ls-files -s | awk '/^120000/ {print $4}')
    if [ -n "$symlinks" ]; then
        count=$(echo "$symlinks" | wc -l)
        echo "Found $count symlink(s). Refreshing now..."
        
        # Pass all paths to git checkout at once
        echo "$symlinks" | xargs git checkout HEAD --
        
        echo "Successfully refreshed all symlinks via Git."
    else
        echo "No symlinks found in this Git repository."
    fi
else
    echo "core.symlinks is '$current_value'."
fi


# Ensure development dependencies are installed
make install-dev