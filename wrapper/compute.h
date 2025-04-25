//
//  compute.h
//  gpu-programming
//
//  Created by Dmitri Wamback on 2025-04-25.
//

#ifndef compute_h
#define compute_h

class AdditionImpl;

class Addition {
public:
    Addition();
    ~Addition();
    void Add(float* a, float* b, float* result, int count);
private:
    AdditionImpl* impl;
};

#endif /* compute_h */
