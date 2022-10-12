#include <cstdio>
#include <thread>

int main() {
  auto td_count = std::thread::hardware_concurrency();
  printf("Concurrency thread number: %d\n", td_count);
  return 0;
}