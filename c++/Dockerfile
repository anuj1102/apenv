FROM ubuntu:18.04
LABEL name=ape_ccls_container
RUN apt update && apt install -y \
        git \
        llvm-7 \
        clang-7 \
        libclang-7-dev

RUN git clone https://github.com/anuj1102/apenv.git
