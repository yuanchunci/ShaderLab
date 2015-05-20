// kokichi88
#include "UnityCG.cginc"
sampler2D _basetexture;
sampler2D _normalmap;
sampler2D _maskmap2;
fixed _ambientscale;
fixed4 _LightColor0;
fixed3 _rimlightcolor;
fixed3 _specularcolor;

#if defined(TRANSPARENT)
fixed _alpha;
#endif

#if !(defined(SIMPLE) || defined(LIGHT_PROBES))
fixed _rimlightblendtofull;

fixed _selfillumblendtofull;

fixed _specularblendtofull;
#endif
fixed _rimlightscale;
fixed _specularexponent;
fixed _specularscale;

#if defined(HUE)
fixed _HueShift;
fixed _Sat;
fixed _Val;
#endif
struct app_data
{
	fixed4 vertex : POSITION;
	fixed3 normal : NORMAL;
	fixed4 tangent : TANGENT;  
	fixed2 texcoord : TEXCOORD0;
};

struct v2f
{
	fixed4 pos : SV_POSITION;
	fixed4 posWorld : TEXCOORD0;
	// position of the vertex (and fragment) in world space 
	fixed2 tex : TEXCOORD1;
	fixed3 tangentWorld : TEXCOORD2;  
	fixed3 normalWorld : TEXCOORD3;
	fixed3 binormalWorld : TEXCOORD4;
	fixed3 WorldNormal : TEXCOORD5;
};
