FROM localhost:5000/img-wamr
ENV PATH=${LLVM_14_INSTALL}/bin:$PATH

WORKDIR /wasm-micro-runtime
RUN git checkout 1cafa37

WORKDIR /wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_BUILD_TYPE=Debug -DWAMR_BUILD_INTERP=1 -DWAMR_BUILD_REF_TYPES=1 -DWASM_ENABLE_SIMD=1 -DWASM_ENABLE_BULK_MEMORY=1 -DWAMR_BUILD_AOT=0 -DWAMR_BUILD_FAST_INTERP=0 -DWAMR_BUILD_LIBC_WASI=0 -DWAMR_BUILD_LIBC_BUILTIN=1 ..
RUN make -j

COPY ./ /bugs/2390

RUN mkdir -p /testcases
RUN mkdir -p /repro
COPY --from=reprodir /crash_analyzer.sh /repro
COPY --from=reprodir /dedup/* /repro
COPY --from=reprodir /crashes.json /repro
WORKDIR /repro

CMD ["bash", "-c", "./crash_analyzer.sh; echo '[info] Finished running crash_analyzer.sh'; exec tail -f /dev/null"]