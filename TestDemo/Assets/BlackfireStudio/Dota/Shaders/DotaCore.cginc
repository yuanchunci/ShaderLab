// Blackfire Studio
// Matthieu Ostertag

#ifndef DOTA_CORE_CGINC
#define DOTA_CORE_CGINC

inline half3 Add(half3 srcColor, half3 dstColor)
{ return srcColor + dstColor; }

inline half3 Mod2x(half3 srcColor, half3 dstColor, half srcFactor)
{
	srcColor *= 2.0;
	srcColor = lerp(float3(1.0, 1.0, 1.0), srcColor, srcFactor);
	return srcColor * dstColor;
}

inline half3 Overlay(half3 srcColor, half3 dstColor)
{
	dstColor = saturate(dstColor);
	half3 check = step(float3(0.5, 0.5, 0.5), dstColor.rgb);
	half3 result = check * (half3(1.0, 1.0, 1.0) - ((half3(1.0, 1.0, 1.0) - 2.0 * (dstColor.rgb - 0.5)) * (1.0 - srcColor.rgb))); 
	result += (1.0 - check) * (2.0 * dstColor.rgb) * srcColor.rgb;
	return result;
}

inline float3 toLinear(float3 srcColor)
{ return pow(srcColor, 2.2); }

inline float3 toGamma(float3 srcColor)
{ return pow(srcColor, 1 / 2.2); }

#endif