//
//  wrapper.m
//  gpu-programming
//
//  Created by Dmitri Wamback on 2025-04-25.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

#include "compute.h"

class AdditionImpl {
public:
    id<MTLDevice> device;
    id<MTLCommandQueue> commandQueue;
    id<MTLComputePipelineState> pipeline;
    
    AdditionImpl();
    void Add(float* a, float* b, float* result, int count);
};

AdditionImpl::AdditionImpl() {
    
    device = MTLCreateSystemDefaultDevice();
    commandQueue = [device newCommandQueue];
    
    NSString *path = @"/Users/dmitriwamback/Documents/Projects/gpu-programming/gpu-programming/compute.metallib";
    NSData *data = [NSData dataWithContentsOfFile:path];
    dispatch_data_t dispatchData = dispatch_data_create(data.bytes, data.length, NULL, DISPATCH_DATA_DESTRUCTOR_DEFAULT);
    
    NSError *error = nil;
    id<MTLLibrary> library = [device newLibraryWithData:dispatchData error:&error];
    id<MTLFunction> function = [library newFunctionWithName:@"add"];
    pipeline = [device newComputePipelineStateWithFunction:function error:&error];
    
};

void AdditionImpl::Add(float *a, float *b, float *result, int count) {
    id<MTLBuffer> bufferA = [device newBufferWithBytes:a length:sizeof(float) * count options:MTLResourceStorageModeShared];
    id<MTLBuffer> bufferB = [device newBufferWithBytes:b length:sizeof(float) * count options:MTLResourceStorageModeShared];
    id<MTLBuffer> bufferResult = [device newBufferWithLength:sizeof(float) * count options:MTLResourceStorageModeShared];

    id<MTLCommandBuffer> commandBuffer = [commandQueue commandBuffer];
    id<MTLComputeCommandEncoder> encoder = [commandBuffer computeCommandEncoder];

    [encoder setComputePipelineState:pipeline];
    [encoder setBuffer:bufferA offset:0 atIndex:0];
    [encoder setBuffer:bufferB offset:0 atIndex:1];
    [encoder setBuffer:bufferResult offset:0 atIndex:2];

    MTLSize gridSize = MTLSizeMake(count, 1, 1);
    NSUInteger threadGroupSize = pipeline.maxTotalThreadsPerThreadgroup;
    if (threadGroupSize > count) threadGroupSize = count;
    MTLSize threadgroupSize = MTLSizeMake(threadGroupSize, 1, 1);

    [encoder dispatchThreads:gridSize threadsPerThreadgroup:threadgroupSize];
    [encoder endEncoding];
    [commandBuffer commit];
    [commandBuffer waitUntilCompleted];

    memcpy(result, bufferResult.contents, sizeof(float) * count);
}


Addition::Addition() {
    impl = new AdditionImpl();
}

Addition::~Addition() {
    delete impl;
}

void Addition::Add(float* a, float* b, float* result, int count) {
    impl->Add(a, b, result, count);
}
