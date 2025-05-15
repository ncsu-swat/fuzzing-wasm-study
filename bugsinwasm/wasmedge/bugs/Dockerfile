# Use the official Ubuntu 20.04 image as the base image
FROM ubuntu:22.04
RUN ulimit -n 8192

# Set environment variables to non-interactive (to avoid any prompts during apt-get installation)
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for WASMEDGE runtime
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg2 \
    software-properties-common \
    ca-certificates \
    lsb-release \
    git \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    python3-dev \
    python3-distutils \
    swig \
    libssl-dev \
    libtool \
    libcurl4 \
    libcurl4-openssl-dev \
    libedit-dev \
    libncurses5-dev \
    libxml2-dev \
    zlib1g-dev \
    libffi-dev \
    libpfm4-dev \
    autoconf \
    pkg-config \
    nano \
    jq \
    && rm -rf /var/lib/apt/lists/*

# # Install llvm-14
# ENV LLVM_COMMON_FLAGS="-G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_PROJECTS=clang;compiler-rt;lld;lldb;polly;mlir -DLLDB_ENABLE_PYTHON=ON -DPYTHON_EXECUTABLE=$(which python3) -DLLVM_TARGETS_TO_BUILD=X86"

# ---------- LLVM 12 ----------
# Bug 617 needs LLVM-12. Check if more bugs might need LLVM-12. If yes, install LLVM-12 in the base docker image. Otherwise,
# install LLVM-12 inside the docker container of 617.

# ---------- LLVM 14 ----------
# ENV LLVM_14_SRC=/llvm-project-14
# ENV LLVM_14_BUILD=/llvm-project-14/build
ENV LLVM_14_INSTALL=/usr/lib/llvm-14

# RUN git clone --depth=1 --branch llvmorg-14.0.0 https://github.com/llvm/llvm-project.git $LLVM_14_SRC && \
#     mkdir -p $LLVM_14_BUILD && cd $LLVM_14_BUILD && \
#     cmake $LLVM_COMMON_FLAGS -DCMAKE_INSTALL_PREFIX=$LLVM_14_INSTALL ../llvm && \
#     ninja && ninja install && rm -rf $LLVM_14_SRC $LLVM_14_BUILD
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" \
      >  /etc/apt/sources.list.d/llvm.list \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main" \
      >> /etc/apt/sources.list.d/llvm.list \
    && apt-get update \
    && apt-get install -y -t llvm-toolchain-jammy-14 llvm-14 llvm-14-dev clang-14 lldb-14 lld-14 liblld-14-dev libclang-common-14-dev libmlir-14-dev \
    && apt-get update \
    && apt download libpolly-14-dev && dpkg --force-all -i libpolly-14-dev* \
    && rm -rf /var/lib/apt/lists/*

# Set llvm path
ENV PATH=${LLVM_14_INSTALL}/bin:$PATH

# Set the test working directory
WORKDIR /test-rt/WasmEdge
# Clone the test WASMEDGE repository
RUN git clone --recursive https://github.com/WasmEdge/WasmEdge.git . && ln -s /test-rt/WasmEdge/build/tools/wasmedge/wasmedge /test-rt/test_wasmedge
# Set environment variables for test WASMEDGE
ENV PATH=/test-rt:$PATH

# Setup requirements for the oracle WASMTIME runtime
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
# Set the oracle working directory
WORKDIR /oracle-rt/wasmtime
# Clone the oracle WASMTIME repository
RUN git clone --recursive https://github.com/bytecodealliance/wasmtime.git . && ln -s /oracle-rt/wasmtime/target/debug/wasmtime /oracle-rt/oracle_wasmtime
# Set environment variables for oracle WASMEDGE
ENV PATH=/oracle-rt:$PATH
