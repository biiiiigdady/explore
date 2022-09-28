#include <chrono>
#include <cstdio>
#include <thread>

#include "interface_example.hpp"
namespace example {
namespace interface {
void foo(int flag) {
  printf("InterfaceExample.so: void foo(%d).\n", flag);
  while (true) {
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
  }
}
void bar(int flag) { printf("InterfaceExample.so: void bar(%d).\n", flag); }
}  // namespace interface
}  // namespace example