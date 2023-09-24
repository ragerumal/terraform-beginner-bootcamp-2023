#!/usr/bin/env bash

# Define the alias you want to add
new_alias='alias tf="terraform"'

# Check if .bash_profile exists in the user's home directory
if [ -f "$HOME/.bash_profile" ]; then
    # Check if the alias is already in .bash_profile
    if grep -q "alias tf=\"terraform\"" "$HOME/.bash_profile"; then
        echo "The 'tf' alias already exists in .bash_profile."
    else
        # Append the alias to .bash_profile
        echo "Adding 'tf' alias to .bash_profile..."
        echo "$new_alias" >> "$HOME/.bash_profile"
        source "$HOME/.bash_profile"  # Load the updated .bash_profile
        echo "'tf' alias added to .bash_profile."
    fi
else
    echo "Error: .bash_profile does not exist in your home directory."
fi

source ~/.bash_profile