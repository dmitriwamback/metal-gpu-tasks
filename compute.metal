//
//  compute.metal
//  gpu-programming
//
//  Created by Dmitri Wamback on 2025-04-25.
//

#include <metal_stdlib>
using namespace metal;

kernel void add(device const float* A [[buffer(0)]],
                device const float* B [[buffer(1)]],
                device const float4* vecs [[buffer(2)]],
                device const int* arraySize [[buffer(3)]],
                device float4* result [[buffer(4)]],
                uint id [[thread_position_in_grid]]) {
    
    result[id] = vecs[id].xyzw * (B[id] + sin(A[id]));
}
