// ============================== CONSTANTS ==============================

#ifdef SUNSHINE_MOBILE
	#define SUNSHINE_ONE_CASCADE
	#ifndef SUNSHINE_OVERCAST_ON
		#undef SUNSHINE_OVERCAST_OFF
		#define SUNSHINE_OVERCAST_OFF
	#endif
	#ifndef SUNSHINE_TEXCENTERING_ON
		#undef SUNSHINE_TEXCENTERING_OFF
		#define SUNSHINE_TEXCENTERING_OFF
	#endif
#endif

#define PRE_TRANSFORM_INTO_CASCADE0

//PI is a lie ;)
#define TAU 6.2831853072
#define HALF_TAU 3.1415926536

#ifdef UNITY_COMPILER_HLSL
	#define SUNSHINE_INITIALIZE_OUTPUT(t, v) v = (t)0;
#else
	#define SUNSHINE_INITIALIZE_OUTPUT(t, v)
#endif

#ifdef UNITY_SAMPLE_1CHANNEL
	#define SUNSHINE_SAMPLE_1CHANNEL(t, c) UNITY_SAMPLE_1CHANNEL(t, c)
#else
	#define SUNSHINE_SAMPLE_1CHANNEL(t, c) tex2D(t, c).x
#endif


#define SUNSTEP(y, x) step(y, x)


// ============================== PARAMETERS ==============================

sampler2D sunshine_Lightmap;
sampler2D sunshine_OvercastMap;

float4 sunshine_Lightmap_TexelSize; //Use the built-in functionality. :)
#define sunshine_LightmapSize (sunshine_Lightmap_TexelSize.zw)
#define sunshine_LightmapTexel (sunshine_Lightmap_TexelSize.xy)

float4 sunshine_ShadowParamsAndHalfTexel;
#define sunshine_ShadowParams (sunshine_ShadowParamsAndHalfTexel.xy)
#define sunshine_LightmapHalfTexel (sunshine_ShadowParamsAndHalfTexel.zw)

float2 sunshine_OvercastCoord;
float4 sunshine_OvercastVectorsUV;

float4x4 sunshine_CameraVToSunVP;
float4x4 sunshine_WorldToSunVP;

float4 sunshine_ShadowCoordDepthStart;
float4 sunshine_ShadowCoordDepthRayZ;
float4 sunshine_ShadowCoordDepthRayU;
float4 sunshine_ShadowCoordDepthRayV;
float3 sunshine_ShadowToWorldScale;

float4 sunshine_CascadeNearRatiosSq;
float4 sunshine_CascadeFarRatiosSq;

// Assuming the cascades are square, we can use .xx and .y can be the z-offset...
// This allows staggared cascade rendering without adjusting the depth texture!
float4x4 sunshine_CascadeRanges;

float3 sunshine_ShadowFadeParams;


// ============================== MATH HELPERS ==============================

float2 SnapCoord(float2 TexCoord, float2 Pixel)
{
	return floor(TexCoord * (float2(1, 1) / Pixel)) * Pixel;
}

float2x2 RotationMatrix2D(float r)
{
    float c = cos(r);
    float s = sin(r);
	return float2x2(c, -s, s, c);
}
float2 RotationRay2D(float r)
{
	return float2(cos(r), -sin(r));
}



// Input: Texture Coordinate
// Returns [0, 1]
float Random(float2 coord)
{
	return frac(sin(dot(coord ,float2(78.2331, 120.98981))) * 43758.5453);
}

#define Pulse(dist) frac((dist) * 123456789.987654321)
#define PulseX(dist, pulseCount) frac((dist) * (pulseCount))

// ============================== SHADOW HELPERS ==============================


// Encoding/decoding [0..1) floats into 8 bit/channel RGBA. Note that 1.0 will not be encoded properly.
inline float4 SunshineEncodeFloatRGBA( float v )
{
	float4 kEncodeMul = float4(1.0, 255.0, 65025.0, 16581375.0); //Was 160581375, but 16581375 seems correct...?
	float kEncodeBit = 1.0/255.0;
	float4 enc = kEncodeMul * v;
	enc = frac (enc);
	enc -= enc.yzww * kEncodeBit;
	return enc;
}
inline float SunshineDecodeFloatRGBA( float4 enc )
{
	float4 kDecodeDot = float4(1.0, 1/255.0, 1/65025.0, 1/16581375.0); //Was 1/160581375, but 1/16581375 seems correct...?
	return dot( enc, kDecodeDot );
}


#define WriteSun(depth) SunshineEncodeFloatRGBA(depth)
//#define SampleSun(texCoord) DecodeFloatRGBA(tex2D(sunshine_Lightmap, (texCoord)))
//Paranoid about inlined DecodeFloatRGBA() producing 2x tex2D() calls, probably unfounded:
inline float SampleSun(float2 t)
{
	return SunshineDecodeFloatRGBA(tex2D(sunshine_Lightmap, (t)));
}

#ifndef OverrideSunshineShadowTerm
	#ifdef SUNSHINE_FILTER_HARD
		#define OverrideSunshineShadowTerm(shadowCoordDepth) ShadowTermHard(shadowCoordDepth)
	#endif
	#ifdef SUNSHINE_FILTER_PCF_2x2
		#define OverrideSunshineShadowTerm(shadowCoordDepth) ShadowTermPCF2x2(shadowCoordDepth)
	#endif
	#ifdef SUNSHINE_FILTER_PCF_3x3
		#define OverrideSunshineShadowTerm(shadowCoordDepth) ShadowTermPCF3x3(shadowCoordDepth)
	#endif
	#ifdef SUNSHINE_FILTER_PCF_4x4
		#define OverrideSunshineShadowTerm(shadowCoordDepth) ShadowTermPCF4x4(shadowCoordDepth)
	#endif
#endif

//Failsafe Hard Shadows:
#ifndef OverrideSunshineShadowTerm
	#define OverrideSunshineShadowTerm(shadowCoordDepth) ShadowTermHard(shadowCoordDepth)
#endif

inline float OvercastTerm(float2 lightCoord) { return tex2D(sunshine_OvercastMap, sunshine_OvercastCoord.xy + sunshine_OvercastVectorsUV.xy * lightCoord.x + sunshine_OvercastVectorsUV.zw * lightCoord.y).a; }

#ifdef SUNSHINE_NO_FADE
	#define SunshineFadeSaturate(v) SUNSTEP(0, v)
#else
	#define SunshineFadeSaturate(v) saturate(v)
#endif

//Normal Version:
#define SunshineShadowTerm(lightCoordDepthFade) (1.0 - OverrideSunshineShadowTerm(lightCoordDepthFade.xyz) * sunshine_ShadowParams.x * SunshineFadeSaturate(lightCoordDepthFade.w))

//Overcast Version
#define SunshineShadowTermOvercast(lightCoordDepthFade, overcastTerm) (1.0 - (1.0 - (1.0 - OverrideSunshineShadowTerm(lightCoordDepthFade.xyz) * SunshineFadeSaturate(lightCoordDepthFade.w)) * (overcastTerm)) * sunshine_ShadowParams.x)

#ifdef SUNSHINE_ONE_CASCADE
	#define SunshineInCascades(depth01) float4(1,0,0,0)
#else
	#define SunshineInCascades(depth01) (SUNSTEP(sunshine_CascadeNearRatiosSq, depth01) * SUNSTEP(depth01, sunshine_CascadeFarRatiosSq))
#endif
// Assuming the cascades are square, we can use .xx and .y can be the z-offset...
// This allows staggared cascade rendering without adjusting the depth texture!
//SUNSHINE_ONE_CASCADE and SUNSHINE_TWO_CASCADES are optional optimizations...


#if defined(PRE_TRANSFORM_INTO_CASCADE0) && defined(SUNSHINE_ONE_CASCADE)
	float2 CalculateSunCoord(float3 shadowCoordDepth) { return shadowCoordDepth.xy; }
#else
	float2 CalculateSunCoord(float3 shadowCoordDepth)
	{
		//No Constant Waterfalling!...
		float4 inSplits = SunshineInCascades(shadowCoordDepth.z);
		float4 cascadeRange = sunshine_CascadeRanges[0]
		#ifndef SUNSHINE_ONE_CASCADE
			* inSplits[0] + sunshine_CascadeRanges[1] * inSplits[1]
			#ifndef SUNSHINE_TWO_CASCADES
				+ sunshine_CascadeRanges[2] * inSplits[2]
				#ifndef SUNSHINE_THREE_CASCADES
					+ sunshine_CascadeRanges[3] * inSplits[3]
				#endif
			#endif
		#endif
		;
		return cascadeRange.xy + cascadeRange.zw * shadowCoordDepth.xy;
	}
#endif

#ifdef SUNSHINE_TEXCENTERING_OFF
	#define CenterShadowTexel(coord) (coord)
#else
	#define CenterShadowTexel(coord) (floor(coord * sunshine_LightmapSize) * sunshine_LightmapTexel + sunshine_LightmapHalfTexel)
#endif

float ShadowRayLengthSquared(float3 shadowRay)
{
	float3 scaledRay = shadowRay * sunshine_ShadowToWorldScale;
	return dot(scaledRay, scaledRay);
}

//Pulse is cheaper than Random()...
#define ShadowDepthSquaredJittered(distSq) ((distSq) * (1.0 - Pulse(distSq) * sunshine_ShadowParams.y))

// ============================== SHADOW FILTERS ==============================

fixed ShadowTermHard(float3 shadowCoordDepth)
{			
	return SUNSTEP(SampleSun(shadowCoordDepth.xy), shadowCoordDepth.z);
}

fixed ShadowTermPCF2x2(float3 shadowCoordDepth)
{
	//2x2 isn't centered nicely :)
	shadowCoordDepth.xy -= sunshine_LightmapHalfTexel;
	
	//Read from the center of texels to avoid floating point error when reading neighbors...
	float2 sampleCoord = CenterShadowTexel(shadowCoordDepth.xy);
	
	float4 fSamples;
	fSamples.x = SampleSun(sampleCoord);
	fSamples.y = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(1, 0));
	fSamples.z = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(0, 1));
	fSamples.w = SampleSun(sampleCoord + sunshine_LightmapTexel);

	fixed4 inLight = SUNSTEP(fSamples, shadowCoordDepth.zzzz);

	fixed4 vLerps = frac(sunshine_LightmapSize * shadowCoordDepth.xy).xyxy;
	vLerps.zw = 1.0 - vLerps.zw;

	return dot(inLight, vLerps.zxzx*vLerps.wwyy);
}

fixed ShadowTermPCF3x3(float3 shadowCoordDepth)
{
	// Edge tap smoothing
	fixed4 FracWeights = frac(shadowCoordDepth.xy * sunshine_LightmapSize).xyxy;
	FracWeights.zw = 1.0-FracWeights.xy;

	//Read from the center of texels to avoid floating point error when reading neighbors...
	float2 sampleCoord = CenterShadowTexel(shadowCoordDepth.xy);

	fixed3 fShadowTerm;
	for (int y = 0; y < 3; y++)
	{
		float3 fSamples;
		fSamples.x = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(-1, y - 1));
		fSamples.y = SampleSun(sampleCoord + sunshine_LightmapTexel * float2( 0, y - 1));
		fSamples.z = SampleSun(sampleCoord + sunshine_LightmapTexel * float2( 1, y - 1));

		fShadowTerm[y] = dot(SUNSTEP(fSamples, shadowCoordDepth.zzz), fixed3(FracWeights.z, 1, FracWeights.x));
	}        
	
	//We multiply by 0.25 unintuitively because the frac() wittles off 1 weight from width and height, making the sum 2x2=4... so 1/4th
	return dot(fShadowTerm, fixed3(FracWeights.w, 1, FracWeights.y) * 0.25);
}
fixed ShadowTermPCF4x4(float3 shadowCoordDepth)
{
	//4x4 isn't centered nicely :)
	shadowCoordDepth.xy -= sunshine_LightmapHalfTexel;

	// Edge tap smoothing
	fixed4 FracWeights = frac(shadowCoordDepth.xy * sunshine_LightmapSize).xyxy;
	FracWeights.zw = 1.0-FracWeights.xy;

	//Read from the center of texels to avoid floating point error when reading neighbors...
	float2 sampleCoord = CenterShadowTexel(shadowCoordDepth.xy);

	fixed4 fShadowTerm = 0;
	for (int y = 0; y < 2; y++)
	{
		for (int x = 0; x < 2; x++)
		{
			float4 fSamples;
			fSamples.x = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(x*2-1, y*2-1));
			fSamples.y = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(x*2  , y*2-1));
			fSamples.z = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(x*2-1, y*2  ));
			fSamples.w = SampleSun(sampleCoord + sunshine_LightmapTexel * float2(x*2  , y*2  ));
			
			fixed4 inLight = SUNSTEP(fSamples, shadowCoordDepth.zzzz);
			if(x==0)
			{
				fShadowTerm[y*2] = dot(inLight.xy, float2(FracWeights.z, 1));
				fShadowTerm[y*2+1] = dot(inLight.zw, float2(FracWeights.z, 1));
			}
			else
			{
				fShadowTerm[y*2] += dot(inLight.xy, float2(1, FracWeights.x));
				fShadowTerm[y*2+1] += dot(inLight.zw, float2(1, FracWeights.x));
			}
		}        
	}	
	//We multiply by 0.11111 unintuitively because the frac() wittles off 1 weight from width and height, making the sum 3x3=9... so 1/9th
	return dot(fShadowTerm, fixed4(FracWeights.w, 1, 1, FracWeights.y) * 0.11111);
}


// ============================== SHADOW SURFACE SHADER HELPERS ==============================

// Hack Note: We can use "surfIN.sunshine_lightData" instead of "IN.cust_sunshine_lightData" if needed...
// Optimization Notes:
// 1-(depth*scale*10-9) shouldn't be in the Pixel Shader, but we want to avoid a second interpolator...
// We Pre-multiply scale*10, which gives us: 1-(depth*scaleTen-9)
// Pre-subtract (-9), which gives us 10-(depth*scaleTen)
fixed SunshineLightAttenuation(float4 lightData)
{
	float radialDistanceSq = ShadowRayLengthSquared(lightData.xyz - sunshine_ShadowCoordDepthStart.xyz);
	float2 sunCoord =
		#ifdef SUNSHINE_ONE_CASCADE
			lightData.xy;
		#else
			CalculateSunCoord(float3(lightData.xy,
			#ifdef SUNSHINE_NO_FADE
				radialDistanceSq
			#else
				ShadowDepthSquaredJittered(radialDistanceSq)
			#endif		
				));
		#endif
	float4 sunCoordDepthFade = float4(sunCoord, lightData.z,
		//sunshine_ShadowFadeParams.x-(sqrt(radialDistanceSq)*sunshine_ShadowFadeParams.y);
		//Working in r^2 Space to avoid sqrt... (See SunshineCamera.cs)
		sunshine_ShadowFadeParams.x-(radialDistanceSq*sunshine_ShadowFadeParams.y));

	#ifdef SUNSHINE_OVERCAST_OFF
		return SunshineShadowTerm(sunCoordDepthFade);
	#else
		return SunshineShadowTermOvercast(sunCoordDepthFade, OvercastTerm(lightData.xy));
	#endif
}

// Decodes lightmaps:
// - doubleLDR encoded on GLES
// - RGBM encoded with range [0;8] on other platforms using surface shaders
inline fixed3 SunshineDecodeLightmap( fixed4 color )
{
	#if defined(SHADER_API_GLES) && defined(SHADER_API_MOBILE)
		return 2.0 * color.rgb;
	#else
		// potentially faster to do the scalar multiplication
		// in parenthesis for scalar GPUs
		return (8.0 * color.a) * color.rgb;
	#endif
}


#define SUNSHINE_INPUT_PARAMS float4 sunshine_lightData

#define SUNSHINE_WRITE_VERTEX(input, output) \
float4 sunshine_viewPos = mul(UNITY_MATRIX_MV, input.vertex); \
output.sunshine_lightData = mul(sunshine_CameraVToSunVP, sunshine_viewPos)


inline fixed3 SunshineDecodeLightmapCombined(fixed4 lmtex, fixed3 lm, fixed atten)
{
	#if defined(SHADER_API_GLES) && defined(SHADER_API_MOBILE)
		return min(lm, atten*2);
	#else
		return max(min(lm,(atten*2)*lmtex.rgb), lm*atten);
	#endif
}

#if defined(UNITY_PASS_FORWARDBASE) && !defined(SUNSHINE_DISABLED) && !defined(SUNSHINE_ALPHA_DISABLED)
	#define SUNSHINE_WRITE_SURF_VERTEX(input, output) SUNSHINE_WRITE_VERTEX(input, output)
	#if !defined(SUNSHINE_DISABLED) && !defined(SUNSHINE_ALPHA_DISABLED)
		#ifdef DIRECTIONAL
			#ifdef DIRECTIONAL_COOKIE
				#undef DIRECTIONAL_COOKIE
			#endif
			//SHADOW_ATTENUATION or LIGHT_ATTENUATION works...
			#undef SHADOW_ATTENUATION

			//IN.cust_sunshine_lightData no longer works in Unity 5
			//This should work with Unity 3, 4, and 5:
			#define SHADOW_ATTENUATION(IN) SunshineLightAttenuation(surfIN.sunshine_lightData)

			#ifndef LIGHTMAP_OFF
				#undef DecodeLightmap
				#define DecodeLightmap(_lmtex_) SunshineDecodeLightmapCombined(_lmtex_, SunshineDecodeLightmap(_lmtex_), atten)
			#endif

		#endif
	#endif
#else
	#define SUNSHINE_WRITE_SURF_VERTEX(input, output)
#endif

#define SUNSHINE_SURFACE_VERT(input_struct) void sunshine_surf_vert (inout appdata_full v, out input_struct o) { SUNSHINE_INITIALIZE_OUTPUT(input_struct, o); SUNSHINE_WRITE_SURF_VERTEX(v, o); }
#define SUNSHINE_SURFACE_VERT_PIGGYBACK(input_struct, piggy_vert) void sunshine_surf_vert (inout appdata_full v, out input_struct o) { SUNSHINE_INITIALIZE_OUTPUT(input_struct, o); piggy_vert(v); SUNSHINE_WRITE_SURF_VERTEX(v, o); }

#define SUNSHINE_ATTENUATION(in) SunshineLightAttenuation(in.sunshine_lightData)
