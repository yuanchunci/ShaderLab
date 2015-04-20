// Blackfire Studio
// Matthieu Ostertag

//#ifndef DOTA_INPUTS_CGINC
//#define DOTA_INPUTS_CGINC

half		_ambientscale;
fixed _alpha;
sampler2D	_basetexture;
sampler2D	_normalmap;
sampler2D	_maskmap1;
sampler2D	_maskmap2;

#ifndef _SIMPLE
	sampler2D	_diffusewarp;
	half		_diffusewarpblendtofull;
	
	sampler2D	_specularwarp;
	half		_specularwarpintensity;
	
	sampler3D	_fresnelcolorwarp;
	half		_fresnelcolorwarpblendtonone;
	
	sampler3D	_colorwarp;
	half		_colorwarpblendtonone;
#endif

half		_rimlightscale;
half		_rimlightblendtofull;
half3		_rimlightcolor;

half		_selfillumblendtofull;

half		_specularexponent;
half		_specularblendtofull;
half3		_specularcolor;
half		_specularscale;

half		_maskenvbymetalness;
samplerCUBE	_envmap;
half		_envmapintensity;

sampler2D	_fresnelwarp;
half		_fresnelwarpblendtonone;

half		_detail1blendmode;
sampler2D	_detail1map;
half		_detail1scale;
half		_detail1blendfactor;
half		_detail1blendtofull;
half		_detail1scrollrate;
half		_detail1scrollangle;

#if defined(_ALPHA_SOFT) || defined(_ALPHA_HARD)
	half		_cutoff;
#endif

struct Input {
	half2 uv_basetexture;
	half3 worldRefl;
	half3 worldNormal;
	INTERNAL_DATA
};

struct CustomHeroOutput {
	half3 Albedo;
	half3 Normal;
	half3 Emission;
	half3 Specular;	// Used for Environment
	half Alpha;
	half4 Mask1;
	half4 Mask2;
	half3 WorldNormal;
};

//#endif