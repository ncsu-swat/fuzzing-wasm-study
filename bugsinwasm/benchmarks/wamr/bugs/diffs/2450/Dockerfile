FROM img-wamr
ENV PATH=${LLVM_14_INSTALL}/bin:$PATH
RUN mkdir /identity
RUN echo "wamr" > /identity/runtime.txt
RUN echo "2450" > /identity/bugnum.txt

WORKDIR /test-rt/wasm-micro-runtime
RUN git checkout f69ff70
WORKDIR /oracle-rt/wasm-micro-runtime
RUN git checkout c7b2db1

RUN printf 'find_package(CURL REQUIRED)\n' > /tmp/curl-toolchain.cmake
# test-rt
WORKDIR /test-rt/wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /test-rt/wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/tmp/curl-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug ..
RUN make -j
# oracle-rt
WORKDIR /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/tmp/curl-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug ..
RUN make -j

COPY ./*.wasm /bugs/2450/

COPY ./repro/* /repro/
WORKDIR /repro

RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]