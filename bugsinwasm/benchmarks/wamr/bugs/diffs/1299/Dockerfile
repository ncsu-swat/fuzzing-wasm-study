FROM img-wamr
ENV PATH=${LLVM_12_INSTALL}/bin:$PATH
RUN mkdir /identity
RUN echo "wamr" > /identity/runtime.txt
RUN echo "1299" > /identity/bugnum.txt

WORKDIR /test-rt/wasm-micro-runtime
RUN git checkout d856af6
WORKDIR /oracle-rt/wasm-micro-runtime
RUN git checkout c7b2db1

RUN printf 'find_package(CURL REQUIRED)\n' > /tmp/curl-toolchain.cmake
# test-rt
WORKDIR /test-rt/wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /test-rt/wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/tmp/curl-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS="-g -gdwarf-4 -O0 -fno-pie" -DCMAKE_EXE_LINKER_FLAGS="-no-pie" ..
RUN make -j
# oracle-rt
WORKDIR /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux
RUN mkdir build
WORKDIR /oracle-rt/wasm-micro-runtime/product-mini/platforms/linux/build
RUN cmake -DCMAKE_TOOLCHAIN_FILE=/tmp/curl-toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS="-g -gdwarf-4 -O0 -fno-pie" -DCMAKE_EXE_LINKER_FLAGS="-no-pie" ..
RUN make -j

COPY ./*.wasm /bugs/1299/

COPY ./repro/* /repro/
WORKDIR /repro

RUN chmod +x ./diff_analyzer.sh
CMD ["bash", "-c", "./diff_analyzer.sh; echo '[info] Finished running diff_analyzer.sh'; exec tail -f /dev/null"]