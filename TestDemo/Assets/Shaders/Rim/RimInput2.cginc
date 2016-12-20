

fixed	_ambientscale;
sampler2D	_basetexture;
#ifdef TOON_RAMP
sampler2D _ramp;
fixed _diffusescale;
fixed _mulscale;
fixed _addscale;
#endif
#ifdef MAT_CAP
fixed4 _color;
sampler2D _matcap;
fixed _diffusescale;
fixed _mulscale;
fixed _addscale;
#endif
#ifdef RIM_LIGHT
fixed	_rimlightscale;
fixed3	_rimlightcolor;
	#ifndef MAT_CAP
		fixed	_rimlightpower;
	#else
		sampler2D _rimTex;
	#endif
#endif
fixed4 _LightColor0;
#ifdef ALPHA_CUT
fixed _AlphaCut;
#endif

#ifdef HUE
fixed _HueShift;
fixed _Sat;
fixed _Val;
#endif

#ifdef FLASH_COLOR
fixed4 _flashColor;
fixed _flashValue;
#endif

#ifdef SPECULAR
uniform fixed4 _LightDir;
uniform fixed _Shininess;
uniform fixed4 _LuminateVector;
uniform sampler2D _BumpMap;
uniform sampler2D _SpecMap;
#endif

struct app_data
{
	fixed4 vertex : POSITION;
	fixed3 normal : NORMAL;
	fixed4 tangent : TANGENT;
	fixed4 texcoord : TEXCOORD0;
};

struct v2f
{
	fixed4 pos : SV_POSITION;
	fixed2 tex : TEXCOORD0;
	fixed3 diffuse : TEXCOORD1;
	
#if defined(RIM_LIGHT) && !defined(MAT_CAP)
	fixed3 rim : TEXCOORD2;
#endif

#if defined(MAT_CAP) || defined(TOON_RAMP)
	fixed2 cap : TEXCOORD3;
#endif

#ifdef SPECULAR
	fixed3 posWorld : TEXCOORD3;
	fixed3 normalWorld : TEXCOORD4;
#ifdef MY_NORMAL
	fixed3 tangentWorld : TEXCOORD6;
	fixed3 binormalWorld : TEXCOORD7;
#endif

};