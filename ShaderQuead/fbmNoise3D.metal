////
////  fbmNoise3D.metal
////  ShaderQuead
////
////  Created by ミズキ on 2023/02/01.
////
//
//#include <metal_stdlib>
//using namespace metal;
//
//#define NUM_OCTAVES 5
//
//float fbm(float x) {
//    float v = 0.0;
//    float a = 0.5;
//    float shift = float(100);
//    for (int i = 0; i < NUM_OCTAVES; ++i) {
//        v += a * noise(x);
//        x = x * 2.0 + shift;
//        a *= 0.5;
//    }
//    return v;
//}
//
//float fbm(float2 x) {
//    float v = 0.0;
//    float a = 0.5;
//    float2 shift = float2(100);
//    // Rotate to reduce axial bias
//    float2x2 rot = float2x2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
//    for (int i = 0; i < NUM_OCTAVES; ++i) {
//        v += a * noise(x);
//        x = rot * x * 2.0 + shift;
//        a *= 0.5;
//    }
//    return v;
//}
//
//
//float fbm(float3 x) {
//    float v = 0.0;
//    float a = 0.5;
//    float3 shift = float3(100);
//    for (int i = 0; i < NUM_OCTAVES; ++i) {
//        v += a * noise(x);
//        x = x * 2.0 + shift;
//        a *= 0.5;
//    }
//    return v;
//}
