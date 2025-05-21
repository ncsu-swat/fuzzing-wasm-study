# Use the official Ubuntu 22.04 image as the base image
FROM ubuntu:22.04
RUN ulimit -n 8192

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

# Install llvm-12 and llvm-14
ENV LLVM_COMMON_FLAGS="-G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_ENABLE_PROJECTS=clang;compiler-rt;lld;lldb;polly;mlir -DLLDB_ENABLE_PYTHON=ON -DPYTHON_EXECUTABLE=$(which python3) -DLLVM_TARGETS_TO_BUILD=X86"

# ---------- LLVM 12 ----------
# ENV LLVM_12_SRC=/llvm-project-12
# ENV LLVM_12_BUILD=/llvm-project-12/build
ENV LLVM_12_INSTALL=/usr/lib/llvm-12

# RUN git clone --depth=1 --branch llvmorg-12.0.0 https://github.com/llvm/llvm-project.git $LLVM_12_SRC && \
#     mkdir -p $LLVM_12_BUILD && cd $LLVM_12_BUILD && \
#     cmake $LLVM_COMMON_FLAGS -DCMAKE_INSTALL_PREFIX=$LLVM_12_INSTALL ../llvm && \
#     ninja -j 120 && ninja install && rm -rf $LLVM_12_SRC $LLVM_12_BUILD
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository universe \
    && apt-get update \
    && apt-get install -y \
          clang-12 llvm-12 llvm-12-dev \
          clang-tools-12 lldb-12 lld-12 \
    && rm -rf /var/lib/apt/lists/*

# ---------- LLVM 14 ----------
# ENV LLVM_14_SRC=/llvm-project-14
# ENV LLVM_14_BUILD=/llvm-project-14/build
ENV LLVM_14_INSTALL=/usr/lib/llvm-14

# RUN git clone --depth=1 --branch llvmorg-14.0.0 https://github.com/llvm/llvm-project.git $LLVM_14_SRC && \
#     mkdir -p $LLVM_14_BUILD && cd $LLVM_14_BUILD && \
#     cmake $LLVM_COMMON_FLAGS -DCMAKE_INSTALL_PREFIX=$LLVM_14_INSTALL ../llvm && \
#     ninja -j 120 && ninja install && rm -rf $LLVM_14_SRC $LLVM_14_BUILD
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy main" \
      >  /etc/apt/sources.list.d/llvm.list \
    && echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main" \
      >> /etc/apt/sources.list.d/llvm.list \
    && apt-get update \
    && apt-get install -y -t llvm-toolchain-jammy-14 llvm-14 llvm-14-dev clang-14 lldb-14 lld-14 libclang-common-14-dev libmlir-14-dev \
    && apt-get update \
    && apt download libpolly-14-dev && dpkg --force-all -i libpolly-14-dev* \
    && rm -rf /var/lib/apt/lists/*

# Read BUGSINWASM_HOME arg
ARG BUGSINWASM_HOME

# Set the working directory of the test runtime version
WORKDIR /test-rt/wasm-micro-runtime
# Clone the WAMR repository
RUN git clone --recursive https://github.com/bytecodealliance/wasm-micro-runtime.git . && ln -s /test-rt/wasm-micro-runtime/wamr-compiler/build/wamrc /test-rt/test_wamrc && ln -s /test-rt/wasm-micro-runtime/product-mini/platforms/linux/build/iwasm /test-rt/test_iwasm

# Set the working directory of the oracle (latest) runtime version
WORKDIR /oracle-rt/wasm-micro-runtime
# Clone the WAMR repository
RUN git clone --recursive https://github.com/bytecodealliance/wasm-micro-runtime.git . && ln -s /oracle-rt/wasm-micro-runtime/wamr-compiler/build/wamrc /oracle-rt/oracle_wamrc && ln -s /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux/build/iwasm /oracle-rt/oracle_iwasm

# Add to PATH
ENV PATH="/test-rt:/oracle-rt:$PATH"