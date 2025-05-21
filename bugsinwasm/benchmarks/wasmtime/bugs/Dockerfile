# Start from a lightweight Ubuntu base image
FROM ubuntu:22.04
RUN ulimit -n 16384

# Set non-interactive mode for apt-get to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install essential dependencies
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
    libprotobuf-dev \
    protobuf-compiler \
    nano \
    jq \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main" \
      >> /etc/apt/sources.list.d/llvm.list \
    && echo "deb-src http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main" \
      >> /etc/apt/sources.list.d/llvm.list \
    && apt-get update && apt-get install -y llvm-14 llvm-14-dev clang-14 lldb-14 lld-14 libmlir-14-dev \
    && rm -rf /var/lib/apt/lists/*

# # Install llvm-14
# ENV LLVM_COMMON_FLAGS="-G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_PROJECTS=clang;compiler-rt;lld;lldb;polly;mlir -DLLDB_ENABLE_PYTHON=ON -DPYTHON_EXECUTABLE=$(which python3) -DLLVM_TARGETS_TO_BUILD=X86"

# # ---------- LLVM 14 ----------
# ENV LLVM_14_SRC=/llvm-project-14
# ENV LLVM_14_BUILD=/llvm-project-14/build
# ENV LLVM_14_INSTALL=/opt/llvm-14

# RUN git clone --depth=1 --branch llvmorg-14.0.0 https://github.com/llvm/llvm-project.git $LLVM_14_SRC && \
#     mkdir -p $LLVM_14_BUILD && cd $LLVM_14_BUILD && \
#     cmake $LLVM_COMMON_FLAGS -DCMAKE_INSTALL_PREFIX=$LLVM_14_INSTALL ../llvm && \
#     ninja && ninja install && rm -rf $LLVM_14_SRC $LLVM_14_BUILD

# Install Rust (required for building Wasmtime)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust's cargo to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Set the working directory
WORKDIR /test-rt/wasmtime
# Clone the Wasmtime repository
RUN git clone https://github.com/bytecodealliance/wasmtime.git .

# Set the working directory
WORKDIR /oracle-rt/wasmtime
# Clone the Wasmtime repository
RUN git clone https://github.com/bytecodealliance/wasmtime.git .

# Add to PATH
ENV PATH="/usr/lib/llvm-14/bin:/test-rt:/oracle-rt:$PATH"