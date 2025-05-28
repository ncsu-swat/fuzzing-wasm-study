FROM img-wamr
ENV PATH=${LLVM_14_INSTALL}/bin:$PATH
RUN mkdir /identity
RUN echo "wamr" > /identity/runtime.txt
RUN echo "2921" > /identity/bugnum.txt

WORKDIR /test-rt/wasm-micro-runtime
RUN git checkout 40b430f
WORKDIR /oracle-rt/wasm-micro-runtime
RUN git checkout c7b2db1

RUN printf 'find_package(CURL REQUIRED)\n' > /tmp/curl-toolchain.cmake
# test-rt
WORKDIR /test-rt/wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /test-rt/wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/tmp/curl-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DWASM_ENABLE_AOT=1 -DWAMR_BUILD_JIT=1 -DWAMR_BUILD_FAST_JIT=0 -DWAMR_BUILD_REF_TYPES=1 -DWASM_ENABLE_BULK_MEMORY=1 -DWAMR_BUILD_LIBC_WASI=0 -DWAMR_BUILD_LIBC_BUILTIN=1 -DWAMR_BUILD_SIMD=1 -DLLVM_DIR=/opt/llvm-14 ..
RUN make -j
# oracle-rt
WORKDIR /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/tmp/curl-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DWASM_ENABLE_AOT=1 -DWAMR_BUILD_JIT=1 -DWAMR_BUILD_FAST_JIT=0 -DWAMR_BUILD_REF_TYPES=1 -DWASM_ENABLE_BULK_MEMORY=1 -DWAMR_BUILD_LIBC_WASI=0 -DWAMR_BUILD_LIBC_BUILTIN=1 -DWAMR_BUILD_SIMD=1 -DLLVM_DIR=/opt/llvm-14 ..
RUN make -j

COPY ./*.wasm /bugs/2921/

COPY ./repro/* /repro/
WORKDIR /repro

RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]