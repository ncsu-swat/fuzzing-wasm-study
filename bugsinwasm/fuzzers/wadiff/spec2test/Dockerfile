FROM ubuntu:22.04

# set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive

# set timezone
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && echo "Etc/UTC" > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install --fix-missing -y ssh openssh-server build-essential curl python3 python3-pip rsync

# Install rust and cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Add Rust to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Install wasm-tools
RUN cargo install cargo-binstall
RUN cargo binstall wasm-tools

COPY mutator/ /home/wadiff/mutator/
COPY spec2test/ /home/wadiff/spec2test/