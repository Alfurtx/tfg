#
# TAREAS:
# - Crear multiples carpetas con cada una de los componentes: codigo fuente, toolchain, logs
# - Compartir volumen con carpeta en mac con los logs y resultados de la simulacion
#

FROM debian:latest

# El programa utilizará tantos hilos como NUM_JOBS indique, por defecto su valor es 1. Es recomendado no utilizar mas de 2/3 del numero de cores virtuales en la maquina que se esté utilizando
ENV NUM_JOBS=6

WORKDIR /cva6-test
RUN mkdir toolchain

RUN apt-get update -y

RUN apt-get install git cmake help2man device-tree-compiler python3 python3-pip -y
RUN apt-get update -y

# Traer el codigo de cva6
RUN git clone https://github.com/openhwgroup/cva6.git
WORKDIR /cva6-test/cva6
RUN git submodule update --init --recursive

# Instalar los prerequisitos para la toolchain de GCC (https://github.com/openhwgroup/cva6/blob/master/util/toolchain-builder/README.md#prerequisites)
RUN apt-get install autoconf automake autotools-dev curl git libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool bc zlib1g-dev -y
RUN apt-get update -y

# Instalar la toolchain de GCC (https://github.com/openhwgroup/cva6/blob/master/util/toolchain-builder/README.md#getting-started)
ENV INSTALL_DIR=/cva6-test/toolchain
RUN bash ./util/toolchain-builder/get-toolchain.sh
RUN bash ./util/toolchain-builder/build-toolchain.sh ${INSTALL_DIR}

ENV RISCV=${INSTALL_DIR}

RUN pip3 install -r verif/sim/dv/requirements.txt --break-system-packages

ENV DV_SIMULATORS=veri-testharness,spike
RUN bash ./verif/regress/smoke-tests.sh

RUN apt-get update -y
