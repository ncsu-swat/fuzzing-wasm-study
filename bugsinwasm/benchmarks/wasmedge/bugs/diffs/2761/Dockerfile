FROM img-wasmedge
RUN mkdir /identity
RUN echo "wasmedge" > /identity/runtime.txt
RUN echo "2761" > /identity/bugnum.txt

# setup test runtime
WORKDIR /test-rt/WasmEdge
RUN git checkout e4196d3
# setup oracle runtime
WORKDIR /oracle-rt/wasmtime
RUN git checkout 4ce8232
RUN git submodule update --init --recursive

# build test runtime
WORKDIR /test-rt/WasmEdge
RUN mkdir build
WORKDIR /test-rt/WasmEdge/build
RUN cmake -DCMAKE_BUILD_TYPE=Debug ..
RUN make -j
# build oracle runtime
WORKDIR /oracle-rt/wasmtime
RUN rustup override set 1.84.0
RUN cargo build

COPY ./*.wasm /bugs/2761/

COPY ./repro/* /repro/
WORKDIR /repro

RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]