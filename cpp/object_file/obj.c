
#include <stdio.h>

#include "version.h"

int gVendor = 0x00000011;
int gArchitecture = 0x00000022;
int gPlatform = 0x00000033;

char* gVendorStr = "explore future.";

void PrintVersion() {
  int major = 0, minor = 0, patch = 0;
  int r = GetVersion(&major, &minor, &patch);
  if (r == ERROR_CODE_OK)
    printf("Version: %d.%d.%d\n", major, minor, patch);
  else
    printf("Get version error!");
}

void PrintPovider() {
  printf("Vendor: %d\n", gVendor);
  printf("Architecture: %d\n", gArchitecture);
  printf("Platform: %d\n", gPlatform);
}

int main() {
  PrintVersion();
  PrintPovider();
  static int static_init_var = 0x0000000a;
  static int static_uninit_var;
  printf("var: %d,%d", static_init_var, static_uninit_var);
  return 0;
}
