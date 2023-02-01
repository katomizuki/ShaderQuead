//
//  ValueNoise2d.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/30.
//

#include <metal_stdlib>
using namespace metal;

float pseudoRandom(float2 v)
{
    return -1.0 + 2.0 * fract(sin(dot(v, float2(12.9898, 78.233))) * 43758.5453);
}

float2 interpolate(float2 t)
{
    return t * t * (3.0 - 2.0 * t);
}

float valueNoise2D(float2 x)
{
    float2 i = floor(x);
    float2 f = fract(x);
    
    // 格子点座標
    float2 i00 = i;
    float2 i10 = i + float2(1.0, 0.0);
    float2 i01 = i + float2(0.0, 1.0);
    float2 i11 = i + float2(1.0, 1.0);

    // 格子点の座標上での疑似乱数の値
    float n00 = pseudoRandom(i00);
    float n10 = pseudoRandom(i10);
    float n01 = pseudoRandom(i01);
    float n11 = pseudoRandom(i11);

    // 補間係数を求める
    float2 u = interpolate(f);
    // 2次元格子の補間
    return mix(mix(n00, n10, u.x), mix(n01, n11, u.x), u.y);
}
