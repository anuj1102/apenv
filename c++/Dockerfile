FROM ubuntu:18.04
LABEL name=ape_ccls_container
RUN apt update && apt install -y \
        git \
        build-essential \
        clang \
        cmake \
        llvm-7 \
        clang-7 \
        libclang-7-dev
RUN git clone --depth=1 --recursive https://github.com/MaskRay/ccls
RUN cd ccls && \
    cmake -H. -BRelease && \
    cmake --build Release

