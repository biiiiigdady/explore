#!/bin/sh

cmake -S cpp/concurrency -B build/concurrency -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build/concurrency
cmake --install build/concurrency