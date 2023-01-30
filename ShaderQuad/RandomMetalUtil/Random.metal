//
//  Random.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/30.
//

#include <metal_stdlib>
using namespace metal;

float random(float2 seed) {
    return fract(sin(dot(seed, float2(12.9898, 78.233))) * 43758.5453);
}
