//
//  main.cpp
//  gpu-programming
//
//  Created by Dmitri Wamback on 2025-04-25.
//

#include <iostream>
#include "wrapper/compute.h"

int main(int argc, const char * argv[]) {
    const int N = 16;
    std::vector<float> a(N, 1.0f), b(N, 2.0f), result(N);

    Addition metal;
    metal.Add(a.data(), b.data(), result.data(), N);

    std::cout << "Result[0]: " << result[0] << std::endl;
    return 0;
}
