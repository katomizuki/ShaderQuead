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
void waveMotion(realitykit::geometry_parameters params)
{
    float xSpeed = 1;
    float zSpeed = 1.1;
    float xAmp = 0.01;
    float zAmp = 0.02;

    float3 localPos = params.geometry().model_position();

    float xPeriod = (sin(localPos.x * 40 + params.uniforms().time() /40) + 3) * 2;
    float zPeriod = (sin(localPos.z * 20 + params.uniforms().time() /13) + 3);

    float xOffset = xAmp * sin(xSpeed * params.uniforms().time() + xPeriod * localPos.x);
    float zOffset = zAmp * sin(zSpeed * params.uniforms().time() + zPeriod * localPos.z);
    params.geometry().set_model_position_offset(
        float3(0, xOffset + zOffset, 0)
    );
}

[[visible]]
void waveSurface(realitykit::surface_parameters params)
{
  auto surface = params.surface();
  float maxAmp = 0.03;
  half3 oceanBlue = half3(0, 0.412, 0.58);
  float waveHeight = (
    params.geometry().model_position().y + maxAmp
  ) / (maxAmp * 2);

  surface.set_base_color(
    oceanBlue + min(1.0f, pow(waveHeight, 8)) * (1 - oceanBlue)
  );
}


