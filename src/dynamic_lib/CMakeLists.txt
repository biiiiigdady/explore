
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
file(GLOB_RECURSE IE_SHARED_CXX_SOURCE_FILE "${CMAKE_SOURCE_DIR}/interface_example.cpp")
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
add_library(ie SHARED)
target_compile_features(ie PUBLIC cxx_std_11)
target_include_directories(ie PUBLIC ${PROJECT_SOURCE_DIR})
target_sources(ie 
  PRIVATE ${IE_SHARED_CXX_SOURCE_FILE}
  PUBLIC FILE_SET HEADERS BASE_DIRS ${CMAKE_SOURCE_DIR} FILES interface_example.hpp
)
target_compile_features(ie PUBLIC cxx_std_11)
target_compile_options(ie PUBLIC "-fno-builtin" "-fPIC" "--verbose")
target_link_options(ie PUBLIC "--verbose" "-fuse-ld=lld")
install(TARGETS ie 
  RUNTIME DESTINATION lib
  FILE_SET HEADERS
)

add_library(ied SHARED)
target_include_directories(ied PUBLIC ${PROJECT_SOURCE_DIR})
target_compile_options(ied PUBLIC "-g" "-fno-builtin" "-fPIC" "--verbose")
target_compile_features(ied PUBLIC cxx_std_11)
target_link_options(ied PUBLIC "--verbose" "-fuse-ld=lld")
target_sources(ied
  PRIVATE ${IE_SHARED_CXX_SOURCE_FILE}
  PUBLIC FILE_SET HEADERS BASE_DIRS ${CMAKE_SOURCE_DIR} FILES interface_example.hpp
)
install(TARGETS ied 
  RUNTIME DESTINATION lib
  FILE_SET HEADERS
)

# target pa
add_executable(pa)
target_sources(pa 
  PRIVATE pa.cpp
)
target_include_directories(pa 
  PUBLIC ${PROJECT_SOURCE_DIR}
  PUBLIC ${PROJECT_BINARY_DIR}/include
)
target_link_directories(pa PUBLIC ${PROJECT_BINARY_DIR}/lib)
target_link_libraries(pa PUBLIC ie)
target_compile_features(pa PUBLIC cxx_std_11)
target_compile_options(pa PUBLIC "-fno-builtin" "-fPIC" "--verbose")
target_link_options(pa PUBLIC "--verbose" "-fuse-ld=lld")
install(TARGETS pa RUNTIME DESTINATION bin)

# target pb
add_executable(pb)
target_sources(pb 
  PRIVATE pb.cpp
)
target_include_directories(pb 
  PUBLIC ${PROJECT_SOURCE_DIR}
  PUBLIC ${PROJECT_BINARY_DIR}/include
)
target_link_directories(pb PUBLIC ${PROJECT_BINARY_DIR}/lib)
target_link_libraries(pb PUBLIC ie)
# target_compile_options(pb PUBLIC "-g" "-fno-builtin" "-fPIC" "--verbose")
target_compile_options(pb PUBLIC "-fno-builtin" "-fPIC" "--verbose")
target_link_options(pb PUBLIC "--verbose" "-fuse-ld=lld")
target_compile_features(pb PUBLIC cxx_std_11)
install(TARGETS pb RUNTIME DESTINATION bin)
