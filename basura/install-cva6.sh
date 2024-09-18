#!/bin/sh

if ! command -v git &> /dev/null
then
    echo "git could not be found"
    exit 1
fi

git clone https://github.com/openhwgroup/cva6.git .
git submodule update --init --recursive
