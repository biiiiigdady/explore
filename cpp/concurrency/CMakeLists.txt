
cmake_minimum_required(VERSION 3.10)

# set tools-chains
set(tools /home/wei02.wang/tools/llvm/14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04)
set(CMAKE_FIND_ROOT_PATH  ${tools})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_C_COMPILER ${tools}/bin/clang)
set(CMAKE_CXX_COMPILER ${tools}/bin/clang++)

project(concurrency)

set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/out)
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
add_executable(thread-number)
target_sources(thread-number PRIVATE thread_count.cpp)
target_include_directories(thread-number PUBLIC ${PROJECT_SOURCE_DIR})
# target_compile_options(thread-number PUBLIC "-g" "--verbose" "-fno-builtin" "-fPIC")
# target_link_options(thread-number PUBLIC "--verbose" "-fuse-ld=lld")
target_link_options(thread-number PUBLIC "-fuse-ld=lld")
install(TARGETS thread-number RUNTIME DESTINATION bin)
