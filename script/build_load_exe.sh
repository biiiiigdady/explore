#!/bin/sh

cmake -S src/load_exe -B build/load_exe -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build/load_exe
cmake --install build/load_exe