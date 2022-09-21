#include <cstdio>
#include <string>

#include "hello.hpp"
#include "time/hello_time.hpp"

int main(int argc, char** argv) {
  std::string name = "world";
  if (argc > 1) {
    name = argv[1];
  }
  printf("%s\n", hello::greet(name).c_str());
  hello::print_locale_time();
  return 0;
}