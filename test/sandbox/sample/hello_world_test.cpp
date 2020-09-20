#include "sandbox/sample/hello_world.hpp"

#include <gtest/gtest.h>

#include <iostream>
#include <sstream>

TEST(HelloWorldTest, Hoge) {
    // ref: https://stackoverflow.com/a/4043813
    std::stringstream buffer;
    std::streambuf* sbuf = std::cout.rdbuf();
    std::cout.rdbuf(buffer.rdbuf());
    { sandbox::sample::HelloWorld(); }
    std::cout.rdbuf(sbuf);

    EXPECT_STREQ("Hello, world!\n", buffer.str().c_str());
}
