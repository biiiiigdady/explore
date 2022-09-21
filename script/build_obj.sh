#!/bin/sh

cmake -S src/object_file -B build/object_file -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build/object_file
cmake --install build/object_file