FROM debian:latest

# El programa utilizará tantos hilos como NUM_JOBS indique, por defecto su valor es 1. Es recomendado no utilizar mas de 2/3 del numero de cores virtuales en la maquina que se esté utilizando
ENV NUM_JOBS=6

WORKDIR /tfg

RUN apt-get update -y

RUN apt-get install git cmake help2man device-tree-compiler python3 python3-pip -y
RUN apt-get update -y

# Traer el codigo de cva6
RUN git clone https://github.com/openhwgroup/cva6.git
WORKDIR /tfg/cva6
RUN git submodule update --init --recursive
RUN mkdir toolchain

# Instalar los prerequisitos para la toolchain de GCC (https://github.com/openhwgroup/cva6/blob/master/util/toolchain-builder/README.md#prerequisites)
RUN apt-get install autoconf automake autotools-dev curl git libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool bc zlib1g-dev -y
RUN apt-get update -y

# Instalar la toolchain de GCC (https://github.com/openhwgroup/cva6/blob/master/util/toolchain-builder/README.md#getting-started)
ENV INSTALL_DIR=/tfg/cva6/toolchain
RUN bash /tfg/cva6/util/toolchain-builder/get-toolchain.sh
RUN bash /tfg/cva6/util/toolchain-builder/build-toolchain.sh ${INSTALL_DIR}

ENV RISCV=${INSTALL_DIR}

RUN pip3 install -r /tfg/cva6/verif/sim/dv/requirements.txt --break-system-packages

ENV DV_SIMULATORS=veri-testharness,spike
RUN bash /tfg/cva6/verif/regress/smoke-tests.sh

RUN apt-get install vim neovim -y
