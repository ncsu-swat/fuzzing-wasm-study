FROM img-wasmer
RUN mkdir /identity
RUN echo "wasmer" > /identity/runtime.txt
RUN echo "4142" > /identity/bugnum.txt

WORKDIR /test-rt/wasmer
RUN git checkout e0d53fd
RUN git submodule update --init --recursive
WORKDIR /oracle-rt/wasmtime
RUN git checkout 4ce8232
RUN git submodule update --init --recursive

# test-rt
WORKDIR /test-rt/wasmer
ENV PATH=${LLVM_14_INSTALL}/bin:$PATH
RUN ulimit -n 8192
RUN rustup override set 1.86.0
RUN RUSTFLAGS="-C panic=abort" make build-wasmer-debug
# oracle-rt
WORKDIR /oracle-rt/wasmtime
RUN rustup override set 1.84.0
RUN RUSTFLAGS="-C panic=abort" cargo build

COPY ./*.wasm /bugs/4142/

COPY ./repro/* /repro/
WORKDIR /repro

RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]