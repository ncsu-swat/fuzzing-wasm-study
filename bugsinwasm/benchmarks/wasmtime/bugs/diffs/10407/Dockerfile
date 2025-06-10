FROM img-wasmtime
RUN mkdir /identity && echo "wasmtime" > /identity/runtime.txt && echo "10407" > /identity/bugnum.txt

WORKDIR /test-rt/wasmtime
RUN git checkout 8eefa23
RUN git submodule update --init --recursive
WORKDIR /oracle-rt/wasmtime
RUN git checkout 4ce8232
RUN git submodule update --init --recursive

# test-rt
WORKDIR /test-rt/wasmtime
RUN rustup override set 1.83.0
RUN RUSTFLAGS="-C panic=abort" cargo build
RUN cp /test-rt/wasmtime/target/debug/wasmtime /test-rt/test_wasmtime
# oracle-rt
WORKDIR /oracle-rt/wasmtime
RUN rustup override set 1.86.0
RUN RUSTFLAGS="-C panic=abort" cargo build
RUN cp /oracle-rt/wasmtime/target/debug/wasmtime /oracle-rt/oracle_wasmtime
# cleanup
RUN rm -rf /test-rt/wasmtime /oracle-rt/wasmtime
RUN rustup self uninstall -y

COPY ./*.wasm /bugs/10407/

COPY ./repro/* /repro/
WORKDIR /repro

RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]