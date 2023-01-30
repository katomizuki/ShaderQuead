//
//  03.metal
//  ShaderQuead
//
//  Created by ミズキ on 2023/01/31.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;

[[ visible ]]
void threeGeometry(realitykit::geometry_parameters modifier) {
    float3 worldPos = modifier.geometry().world_position();
    float2 uv = modifier.geometry().uv0();
    float3 normal = modifier.geometry().normal();

    modifier.geometry().set_uv0(uv);
    modifier.geometry().set_world_position_offset(worldPos);
    modifier.geometry().set_normal(normal);
}

[[ visible ]]
void threeSurface(realitykit::surface_parameters surface) {
    float4 customParameter = surface.uniforms().custom_parameter();
    auto viewMatrix = surface.uniforms().world_to_view();
    float4 myVector = float4(0.5,0.5,0.5,1);
    float3 cameraPos = (myVector * viewMatrix).xyz;
//    float3 cameraPos = float3(customParameter[0], customParameter[1], customParameter[2]);
    float3 worldPos = surface.geometry().world_position();
    float3 viewDirection = normalize(cameraPos - worldPos);
    float dotVN = dot(viewDirection, surface.geometry().normal());
    half rim = 1.0 - saturate(dotVN);
    float4 tintColor = float4(1,1,0,1);
    float4 rimColor = float4(0,1,0,1);
    half rimPower = 0.4;
    float4 col = mix(tintColor, rimColor, rim * rimPower);
    surface.surface().set_base_color(half3(col.r,col.g,col.b));
    surface.surface().set_opacity(col.a);
}


