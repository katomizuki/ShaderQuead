//
//  02.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/30.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;

[[ visible ]]
void twoGeometry(realitykit::geometry_parameters modifier)
{
    float3 worldPos = modifier.geometry().world_position();
    modifier.geometry().set_world_position_offset(worldPos);
}

[[visible]]
void twoSurface(realitykit::surface_parameters shader)
{
    realitykit::surface::surface_properties ssh = shader.surface();
    float3 worldPosition = shader.geometry().world_position();
    
    float4 custom = shader.uniforms().custom_parameter();
//    array<packed_float4, 8> customize = shader.uniforms().custom_collec
    float time = shader.uniforms().time();
    float dotResult = dot(worldPosition, float3(1,1,0));
    float repeat = abs(dotResult - time);
    float interpolation = step(fmod(repeat, 1), 0.1);
    float4 color1 = float4(1,1,0,1);
    float4 color2 = float4(0,1,0,1);
    float4 finalColor = mix(color1, custom, interpolation);
    ssh.set_base_color(half3(finalColor.x,finalColor.y, finalColor.z));
    ssh.set_opacity(finalColor.w);
}
