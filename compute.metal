//
//  compute.metal
//  gpu-programming
//
//  Created by Dmitri Wamback on 2025-04-25.
//

#include <metal_stdlib>
using namespace metal;

kernel void add(device const float* A [[buffer(0)]], device const float* B [[buffer(1)]], device float* result [[buffer(2)]], uint id [[thread_position_in_grid]]) {
    result[id] = A[id] + B[id];
}
