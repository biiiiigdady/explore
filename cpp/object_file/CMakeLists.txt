
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
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
add_executable(obj)
target_sources(obj PRIVATE version.h version.c obj.c)
target_include_directories(obj PUBLIC ${PROJECT_SOURCE_DIR})
target_compile_options(obj PUBLIC "-g" "--verbose" "-fno-builtin" "-fPIC")
target_link_options(obj PUBLIC "--verbose" "-fuse-ld=lld")
install(TARGETS obj RUNTIME DESTINATION bin)


# message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
# message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
# add_executable(objd)
# target_sources(objd PRIVATE version.h version.c obj.c)
# target_include_directories(objd PUBLIC ${PROJECT_SOURCE_DIR})
# target_compile_options(objd 
#   PUBLIC "-g"
#   PUBLIC "-fno-builtin"
#   PUBLIC "-fPIC"
#   PUBLIC "--verbose"
#   PUBLIC "-fuse-ld=ld.lld"
# )
# install(TARGETS objd RUNTIME DESTINATION bin)