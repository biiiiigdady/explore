#include <cstdio>
#include <ctime>
#include <locale>

#include "hello_time.hpp"

namespace hello {
void print_locale_time() {
  std::time_t result = std::time(nullptr);
  printf("%s\n", std::asctime(std::localtime(&result)));
}
}  // namespace hello