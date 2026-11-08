#!/bin/bash
export PATH="$PWD/make-4.2.1:$PATH"
echo "Using: $(make --version | head -n 1)"

export ARCH=arm64
mkdir out

BUILD_CROSS_COMPILE=$(pwd)/toolchain/gcc/bin/aarch64-linux-android-
KERNEL_LLVM_BIN=$(pwd)/toolchain/clang/bin/clang
CLANG_TRIPLE=aarch64-linux-gnu-
KERNEL_MAKE_ENV="DTC_EXT=$(pwd)/tools/dtc CONFIG_BUILD_ARM64_DT_OVERLAY=y"

make -j20 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CONFIG_SECTION_MISMATCH_WARN_ONLY=y vendor/a52sxq_eur_open_defconfig
make -j20 -C $(pwd) O=$(pwd)/out $KERNEL_MAKE_ENV ARCH=arm64 CROSS_COMPILE=$BUILD_CROSS_COMPILE REAL_CC=$KERNEL_LLVM_BIN CLANG_TRIPLE=$CLANG_TRIPLE CONFIG_SECTION_MISMATCH_WARN_ONLY=y  2>&1 | tee build.log
 
cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image
