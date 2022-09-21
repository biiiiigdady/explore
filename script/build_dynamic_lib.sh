#!/bin/sh

cmake -S src/dynamic_lib -B build/dynamic_lib -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build/dynamic_lib
cmake --install build/dynamic_lib

# run
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wei02.wang/explore/cs-explore/build/dynamic_lib/out/lib