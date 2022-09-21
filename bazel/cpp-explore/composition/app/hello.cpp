#include "hello.hpp"
#include <string>

namespace hello {
std::string greet(const std::string& name){
    return "hello " + name;
}
}