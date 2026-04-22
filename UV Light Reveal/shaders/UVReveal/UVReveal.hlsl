#ifndef UV_REVEAL_INCLUDED
#define UV_REVEAL_INCLUDED

void UVReveal_float(
    float3 AbsoluteWorldPos,
    float3 LightPos,
    float3 LightForward, // The direction the light is pointing (world space)
    float LightRange, // Maximum distance the light can reach
    float SpotAngle, // Full cone angle in degrees (e.g., 45 means ±22.5° from center)
    out float Mask)
{
    // Vector from the light source to the current pixel
    float3 toPixel = AbsoluteWorldPos - LightPos;
    float dist = length(toPixel);
    
    // 1. Distance falloff — linearly fades to 0 at LightRange
    float rangeMask = saturate(1.0 - (dist / max(LightRange, 0.0001)));

    // 2. Spotlight cone — checks if the pixel is within the cone angle
    float3 dir = normalize(toPixel);
    float cosAngle = dot(dir, normalize(LightForward));

    // SpotAngle is the full cone angle; *0.5 converts it to the half-angle from the center axis
    float minCos = cos(radians(SpotAngle * 0.5));

    // Smoothstep softens the cone edge. 0.05 is intentional — larger values cause visible banding
    float spotMask = smoothstep(minCos, minCos + 0.05, cosAngle);

    Mask = rangeMask * spotMask;
}

#endif