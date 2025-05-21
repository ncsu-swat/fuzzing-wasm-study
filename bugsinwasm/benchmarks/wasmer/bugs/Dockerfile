# Use the official Ubuntu 22.04 image as the base image
FROM ubuntu:22.04
RUN ulimit -n 16384

# Set environment variables to non-interactive (to avoid any prompts during apt-get installation)
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for WAMR (WebAssembly Micro Runtime)
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
    libzstd-dev \
    nano \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install llvm-14 and llvm-18
# ENV LLVM_COMMON_FLAGS="-G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_PROJECTS=clang;compiler-rt;lld;lldb;polly;mlir -DLLDB_ENABLE_PYTHON=ON -DPYTHON_EXECUTABLE=$(which python3) -DLLVM_TARGETS_TO_BUILD=X86;WebAssembly -DLLVM_ENABLE_TERMINFO=OFF"

# ---------- LLVM 14 ----------
# ENV LLVM_14_SRC=/llvm-project-14
# ENV LLVM_14_BUILD=/llvm-project-14/build
ENV LLVM_14_INSTALL=/usr/lib/llvm-14
ENV LLVM_SYS_140_PREFIX=${LLVM_14_INSTALL}

# RUN git clone --depth=1 --branch llvmorg-14.0.0 https://github.com/llvm/llvm-project.git $LLVM_14_SRC && \
#     mkdir -p $LLVM_14_BUILD && cd $LLVM_14_BUILD && \
#     cmake $LLVM_COMMON_FLAGS -DCMAKE_INSTALL_PREFIX=$LLVM_14_INSTALL ../llvm && \
#     ninja -j 120 && ninja install && rm -rf $LLVM_14_SRC $LLVM_14_BUILD
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:savoury1/llvm-defaults-18 \
    && apt-get update \
    && apt-get install -y clang-18 lld-18 lldb-18 libpolly-18-dev libmlir-18-dev \
    && rm -rf /var/lib/apt/lists/*

# ---------- LLVM 18 ----------
# ENV LLVM_18_SRC=/llvm-project-18
# ENV LLVM_18_BUILD=/llvm-project-18/build
ENV LLVM_18_INSTALL=/usr/lib/llvm-18
ENV LLVM_SYS_180_PREFIX=${LLVM_18_INSTALL}

# RUN git clone --depth=1 --branch llvmorg-18.1.6 https://github.com/llvm/llvm-project.git $LLVM_18_SRC && \
#     mkdir -p $LLVM_18_BUILD && cd $LLVM_18_BUILD && \
#     cmake $LLVM_COMMON_FLAGS -DCMAKE_INSTALL_PREFIX=$LLVM_18_INSTALL ../llvm && \
#     ninja && ninja install
RUN wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main"; \
      >  /etc/apt/sources.list.d/llvm.list \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main"; \
      >> /etc/apt/sources.list.d/llvm.list \
    && apt-get update \
    && printf 'Package: *\nPin: origin apt.llvm.org\nPin-Priority: 1001\n' \
     > /etc/apt/preferences.d/llvm.pref \
    && apt-get update \
    && apt-get install -y \
       clang-18 lld-18 lldb-18 python3-lldb-18 \
       llvm-18 llvm-18-dev llvm-18-runtime llvm-18-tools llvm-18-linker-tools \
       libclang-cpp18 libclang-common-18-dev \
       libpolly-18-dev libmlir-18-dev \
    && rm -rf /var/lib/apt/lists/*

# Read BUGSINWASM_HOME arg
ARG BUGSINWASM_HOME

# Install Rust (required for building wasmer)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust's cargo to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Set the working directory
WORKDIR /test-rt/wasmer
# Clone the wasmer repository
RUN git clone --recursive https://github.com/wasmerio/wasmer.git . && \
    ln -s /test-rt/wasmer/target/debug/wasmer /test-rt/test_wasmer
ENV PATH=/test-rt:$PATH

# Setup requirements for the oracle WASMTIME runtime
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
# Set the oracle working directory
WORKDIR /oracle-rt/wasmtime
# Clone the oracle WASMTIME repository
RUN git clone --recursive https://github.com/bytecodealliance/wasmtime.git . && \
    ln -s /oracle-rt/wasmtime/target/debug/wasmtime /oracle-rt/oracle_wasmtime
# Set environment variables for oracle WASMEDGE
ENV PATH=/oracle-rt:$PATH
