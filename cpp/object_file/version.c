
#include "version.h"

int gVersionMajor = 1;
int gVersionMinor = 1;
int gVersionPatch = 2;

int GetVersion(int* major, int* minor, int* patch) {
  if (!major || !minor || !patch) {
    return ERROR_CODE_ARG_ILLEGAL;
  } else {
    *major = gVersionMajor;
    *minor = gVersionMinor;
    *patch = gVersionPatch;
    return ERROR_CODE_OK;
  }
}