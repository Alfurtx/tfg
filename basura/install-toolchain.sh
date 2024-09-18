#!/bin/sh

# Instalar la toolchain de GCC (https://github.com/openhwgroup/cva6/blob/master/util/toolchain-builder/README.md#getting-started)

if [ -e ${DIR_CVA}/util/toolchain-builder/get-toolchain.sh ]
then
	source ${DIR_CVA}/util/toolchain-builder/get-toolchain.sh
else
	echo "${DIR_CVA}/util/toolchain-builder/get-toolchain.sh not found"
fi

if [ -e ${DIR_CVA}/util/toolchain-builder/build-toolchain.sh]
then
	source ${DIR_CVA}/util/toolchain-builder/build-toolchain.sh $INSTALL_DIR
else
	echo "${DIR_CVA}/util/toolchain-builder/build-toolchain.sh not found"
fi
