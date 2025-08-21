#!/bin/bash

# Function to ask for confirmation
confirm() {
    # read user's response
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Check if shallow copy is requested
SHALLOW_COPY=false
if [ "$1" == "--shallow" ]; then
    SHALLOW_COPY=true
fi

# Validate the repositories before cloning
echo "Validating repositories..."

# Validate .repos.dev
if ! vcs validate --input .repos.dev; then
    echo "Validation of .repos.dev failed."
    exit 1
fi

# Validate .repos.src
if ! vcs validate --input .repos.src; then
    echo "Validation of .repos.src failed."
    exit 1
fi

# Check if 'dev' or 'src' directories exist
if [ -d "dev" ] || [ -d "src" ]; then
    echo "One or both of the directories 'dev' and 'src' already exist."
    echo "Do you really want to delete them?"

    if confirm "Confirm deletion (y/n): "; then
        # Delete the directories if they exist
        [ -d "dev" ] && rm -rf dev && echo "'dev' deleted."
        [ -d "src" ] && rm -rf src && echo "'src' deleted."
    else
        echo "Deletion cancelled."
        exit 1
    fi
fi

# Create directories
mkdir dev src

# Import repositories
if [ "$SHALLOW_COPY" = true ]; then
    echo "Performing shallow copy..."
    vcs import --input .repos.src --shallow --skip-existing src/
    vcs import --input .repos.dev --shallow --skip-existing dev/
else
    echo "Performing full clone..."
    vcs import --input .repos.src src/
    vcs import --input .repos.dev dev/
fi

# Check if validation was successful
if [ $? -ne 0 ]; then
    echo "Repository cloning failed."
    exit 1
fi