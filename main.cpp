//
//  main.cpp
//  gpu-programming
//
//  Created by Dmitri Wamback on 2025-04-25.
//

#include <iostream>
#include <string>

#include <glm/glm.hpp>
#include <glm/vec3.hpp>

#include "wrapper/compute.h"

int main(int argc, const char * argv[]) {
    
    const int N = 1000;
    std::vector<float> a(N), b(N);
    std::vector<glm::vec4> result(N);
    
    for (int i = 0; i < N; i++) {
        a[i] = rand()%100/10.0f + 1.0f;
        b[i] = rand()%100/10.0f + 1.0f;
    }

    Addition metal;
    metal.Add(a.data(), b.data(), result.data(), N);
    
    for (int i = 0; i < N; i++) {
        std::cout << "vec["+std::to_string(i)+"]: " << result[i].x << " " << result[i].y << " " << result[i].z << std::endl;
    }
    return 0;
}
