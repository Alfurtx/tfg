#!/bin/sh

# Instalar los prerequisitos para la toolchain de GCC (https://github.com/openhwgroup/cva6/blob/master/util/toolchain-builder/README.md#prerequisites)

if ! command -v apt-get &> /dev/null
then
    echo "apt-get could not be found"
    exit 1
fi

apt-get install autoconf automake autotools-dev curl git libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool bc zlib1g-dev -y
