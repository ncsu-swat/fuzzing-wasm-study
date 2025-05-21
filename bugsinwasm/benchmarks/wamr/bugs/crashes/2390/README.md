export CC=/usr/bin/clang-14
export CXX=/usr/bin/clang++-14
cd product-mini/platforms/linux/;rm -rf build
cmake  -DWAMR_BUILD_INTERP=1 -DWAMR_BUILD_REF_TYPES=1 -DWASM_ENABLE_SIMD=1 -DWASM_ENABLE_BULK_MEMORY=1 -DWAMR_BUILD_AOT=0 -DCMAKE_BUILD_TYPE=Release -DWAMR_BUILD_FAST_INTERP=0 -DWAMR_BUILD_LIBC_WASI=0 -DWAMR_BUILD_LIBC_BUILTIN=1 -Bbuild
cd build
make -j40


