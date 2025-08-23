FROM python:3.12

WORKDIR /

RUN apt-get update && apt-get install -y curl build-essential && rm -rf /var/lib/apt/lists/*

# Install Rust, cargo binstall, and wasm-tools crate
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
RUN cargo binstall wasm-tools -y

RUN pip install func_timeout

# Create the wapplique and wabt directories
RUN mkdir -p /wapplique && mkdir -p /wabt
RUN mkdir -p /wapplique/case && mkdir /wapplique/ingred

# Copy specific files into the container at /wapplique
COPY *.py \
mutator.cpp mutator_CU.cpp mutator_REU.cpp \
/wapplique
COPY include/ /wapplique/include/

# # Copy wabt directory contents into the container at /wabt
# COPY wabt/ /wabt/
# ENV PATH="/wabt/:${PATH}"

WORKDIR /wapplique
RUN g++ -std=c++17 mutator.cpp -o mutator -I ./include
RUN g++ -std=c++17 mutator_CU.cpp -o mutator_CU -I ./include
RUN g++ -std=c++17 mutator_REU.cpp -o mutator_REU -I ./include

# Start a Bash shell by default
# CMD [""]
