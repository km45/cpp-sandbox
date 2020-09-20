#include "sandbox/indicator/trial.hpp"
#include "sandbox/sample/hello_world.hpp"

int main() {
    sandbox::sample::HelloWorld();
    sandbox::indicator::Do();
    return 0;
}
