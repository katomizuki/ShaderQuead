//
//  04.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/02/07.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
#include <RealityKit/RealityKitTextures.h>
#include <metal_types>
using namespace metal;

[[ visible ]]
void fourGeometry(realitykit::geometry_parameters modifier) {
    float3 worldPos = modifier.geometry().world_position();
    float2 uv = modifier.geometry().uv0();
    float3 normal = modifier.geometry().normal();
    
    modifier.geometry().set_uv0(uv);
    modifier.geometry().set_world_position_offset(worldPos);
    modifier.geometry().set_normal(normal);
}

[[ visible ]]
void fourSurface(realitykit::surface_parameters surface) {
    float2 uv = surface.geometry().uv0();
    float3 red = float3(1,0,0);
    float3 blue = float3(0,0,1);
    float3 finalColor = mix(red, blue, uv.x);
    surface.surface().set_base_color(half3(finalColor));
    surface.surface().set_opacity(1);
}

