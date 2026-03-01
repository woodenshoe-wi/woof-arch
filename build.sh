#!/bin/bash

# Exit on any error.
set -e

. ./build.conf

original_path=${PATH}
current_dir=${PWD}

mkdir -p cross_compilers/downloads

[ -d build ] && rm -rf build
rm -f findpkgs-*.tar.xz
rm -f petget-*.tar.xz

for one_arch in ${ARCH_LIST}; do
  mkdir -p build/"${one_arch}"

  case ${one_arch} in
    i*86)    cc_tarball=$X86_CC ;;
    x86_64)  cc_tarball=$X86_64_CC ;;
    arm*)    cc_tarball=$ARM_CC ;;
  esac
  target_triplet=${cc_tarball%-cross*}
  cc_dir=${cc_tarball%%.*}

  # Download cross compiler.
  if [ ! -f "cross_compilers/downloads/${cc_tarball}" ]; then
    wget -c -P cross_compilers/downloads "${SITE}/${cc_tarball}"
  fi

  # Extract cross compiler.
  if [ ! -d "cross_compilers/${cc_dir}" ]; then
    tar --directory=cross_compilers -xaf "cross_compilers/downloads/${cc_tarball}"
  fi


  cd build/"${one_arch}"

  export PATH="${current_dir}/cross_compilers/${cc_dir}/bin:${original_path}"
  export CC=${target_triplet}-gcc STRIP=${target_triplet}-strip LDFLAGS=-static
  make --makefile=../../src/Makefile

  # Although woof-arch does have source code for vercmp, the version used in
  # woof builds comes from rootfs-petbuilds.

  tar -cJf "${current_dir}/findpkgs-${one_arch}.tar.xz" findpkgs-dep-helper findpkgs-search-helper

  # These are needed in both support and rootfs-skeleton/usr/local/petget/.
  # If HOSTARCH != TARGETARCH two versions need to be downloaded.
  tar -cJf "${current_dir}/petget-${one_arch}.tar.xz" debdb2pupdb find_cat

  cd "${current_dir}"
done

