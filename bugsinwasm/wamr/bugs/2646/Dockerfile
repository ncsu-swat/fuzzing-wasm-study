FROM localhost:5000/img-wamr
ENV PATH=${LLVM_14_INSTALL}/bin:$PATH

WORKDIR /wasm-micro-runtime
RUN git checkout f69ff70

WORKDIR /wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_BUILD_TYPE=Debug -DLLVM_DIR=/opt/llvm-14 -DWAMR_BUILD_JIT=1 ..
RUN make -j

COPY ./ /bugs/2646

RUN mkdir -p /testcases
RUN mkdir -p /repro
COPY --from=reprodir /crash_analyzer.sh /repro
COPY --from=reprodir /dedup/* /repro
COPY --from=reprodir /crashes.json /repro
WORKDIR /repro

CMD ["bash", "-c", "./crash_analyzer.sh; echo '[info] Finished running crash_analyzer.sh'; exec tail -f /dev/null"]