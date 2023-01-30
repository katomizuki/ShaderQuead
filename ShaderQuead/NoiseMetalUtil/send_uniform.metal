//
//  send_uniform.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/30.
//

#include <metal_stdlib>
using namespace metal;

kernel void send_uniform(constant float *numBuffer [[buffer(0)]],
                         uint gid [[thread_position_in_grid]]) {
    float num = numBuffer[gid];
}
