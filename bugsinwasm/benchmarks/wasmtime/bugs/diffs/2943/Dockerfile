FROM img-wasmtime
RUN mkdir /identity && echo "wasmtime" > /identity/runtime.txt && echo "2943" > /identity/bugnum.txt

# setup runtime
# RUN cd /test-rt/wasmtime && git checkout 77fb6a2 && git submodule update --init --recursive && cd /oracle-rt/wasmtime && git checkout 4ce8232 && git submodule update --init --recursive
RUN cd /test-rt/wasmtime && git checkout 77fb6a2 && git submodule update --init --recursive

# build/clean runtime
WORKDIR /test-rt/wasmtime
RUN rustup override set 1.53.0
RUN RUSTFLAGS="-C panic=abort" cargo build
RUN cp /test-rt/wasmtime/target/debug/wasmtime /test-rt/test_wasmtime
WORKDIR /oracle-rt/wasmtime
RUN rustup override set 1.86.0
RUN RUSTFLAGS="-C panic=abort" cargo build
RUN cp /oracle-rt/wasmtime/target/debug/wasmtime /oracle-rt/oracle_wasmtime
RUN rm -rf /test-rt/wasmtime /oracle-rt/wasmtime
RUN rustup self uninstall -y

# copy buggy testcase
COPY ./*.wasm /bugs/2943/

# setup workspace
COPY ./repro/* /repro/
WORKDIR /repro

# run fuzz cases
RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]