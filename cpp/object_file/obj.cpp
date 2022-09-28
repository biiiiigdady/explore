#include <cstdio>

int gVersionMajor = 0;
int gVersionMinor = 1;
int gVersionPatch = 2;

void PrintVersion() {
  printf("Version: %d.%d.%d\n", gVersionMajor, gVersionMinor, gVersionPatch);
}

int main(int argc, char** argv){
  PrintVersion();
  return 0;
}