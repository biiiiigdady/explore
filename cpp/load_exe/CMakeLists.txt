
cmake_minimum_required(VERSION 3.10)

# set tools-chains
set(tools /home/wei02.wang/tools/llvm/14.0.0/clang+llvm-14.0.0-x86_64-linux-gnu-ubuntu-18.04)
set(CMAKE_FIND_ROOT_PATH  ${tools})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_C_COMPILER ${tools}/bin/clang)
set(CMAKE_CXX_COMPILER ${tools}/bin/clang++)

project(ObjectFile)

set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/out)
file(GLOB_RECURSE ELF_CXX_SOURCE_FILE "${CMAKE_SOURCE_DIR}/elf.cpp")
# message(STATUS ${OBJ_C_SOURCE_FILE})
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
add_executable(elf ${ELF_CXX_SOURCE_FILE})
target_compile_features(elf PUBLIC cxx_std_11)
target_include_directories(elf PUBLIC ${PROJECT_SOURCE_DIR})
install(TARGETS elf RUNTIME DESTINATION bin)


message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
add_executable(elfd ${ELF_CXX_SOURCE_FILE})
target_include_directories(elfd PUBLIC ${PROJECT_SOURCE_DIR})
target_compile_options(elfd PUBLIC "-g")
install(TARGETS elfd RUNTIME DESTINATION bin)