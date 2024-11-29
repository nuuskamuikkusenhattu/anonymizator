#!/bin/bash

SOURCE_FILE="source.txt"
DEST_FILE="dest.file"

if [[ ! -f $SOURCE_FILE ]]; then
    echo "source file does not exist"
    exit 1
fi

cp "$SOURCE_FILE" "$DEST_FILE"

for param in "$@"; do
    # Validate parameter format to be old_word=new_word
    if [[ $param =~ ^([^=]+)=([^=]+)$ ]]; then
        OLD=${BASH_REMATCH[1]}
        NEW=${BASH_REMATCH[2]}

        sed -i -E "s/\b$OLD\b/$NEW/g" "$DEST_FILE"
    else
        echo "Invalid parameter format: $param. Expected format is 'old=new'."
    fi
done
