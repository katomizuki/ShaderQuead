//
//  01.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/29.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;

[[visible]]
void basicModifier(realitykit::geometry_parameters modifier)
{
    float3 pose = modifier.geometry().model_position();
    float time = modifier.uniforms().time();
    float speed = 1.5f;
    float amplitude = 0.1f;
    float offset = 0.05f;
    float cosTime = (cos(time * speed)) * amplitude;
    float sinTime = (sin(time * speed)) * (amplitude + offset);
    modifier.geometry().set_model_position_offset(
        float3(cosTime, sinTime, pose.z + 0.1)
    );
}

[[visible]]
void basicShader(realitykit::surface_parameters shader)
{
    realitykit::surface::surface_properties ssh = shader.surface();
    float time = shader.uniforms().time();
    half r = abs(cos(time * 2.5));
    half g = abs(sin(time * 5.0));
    half b = abs(r - (g * r));
    ssh.set_base_color(half3(r, g, b));
    ssh.set_metallic(half(1.0));
    ssh.set_roughness(half(0.0));
    ssh.set_clearcoat(half(1.0));
    ssh.set_clearcoat_roughness(half(0.0));
}
