// Updated for Sunshine 1.4.3
Shader "Sunshine/Nature/Tree Creator Leaves" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_Shininess ("Shininess", Range (0.01, 1)) = 0.078125
	_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
	_BumpMap ("Normalmap", 2D) = "bump" {}
	_GlossMap ("Gloss (A)", 2D) = "black" {}
	_TranslucencyMap ("Translucency (A)", 2D) = "white" {}
	_ShadowOffset ("Shadow Offset (A)", 2D) = "black" {}
	
	// These are here only to provide default values
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.3
	_Scale ("Scale", Vector) = (1,1,1,1)
	_SquashAmount ("Squash", Float) = 1
}

SubShader { 
	Tags { "IgnoreProjector"="True" "RenderType"="TreeLeaf" }
	LOD 200
		
CGPROGRAM
#pragma exclude_renderers flash
#pragma glsl_no_auto_normalization

#include "Assets/Sunshine/Shaders/Compatibility/Helper.cginc"
#if UnityMajorVersion >= 5
	#include "Assets/Sunshine/Shaders/Compatibility/UnityBuiltin3xTreeLibrary.cginc"
#else
	#include "Tree.cginc"
#endif


 #include "Assets/Sunshine/Shaders/Sunshine.cginc"
//Leaves don't require higher quality filters:
#pragma multi_compile SUNSHINE_DISABLED SUNSHINE_FILTER_PCF_2x2 SUNSHINE_FILTER_HARD
#pragma target 3.0
#pragma surface surf TreeLeaf alphatest:_Cutoff vertex:sunshine_surf_vert exclude_path:prepass nolightmap

sampler2D _MainTex;
sampler2D _BumpMap;
sampler2D _GlossMap;
sampler2D _TranslucencyMap;
half _Shininess;

struct Input {
	float2 uv_MainTex;
	fixed4 color : COLOR; // color.a = AO
	SUNSHINE_INPUT_PARAMS;
};

SUNSHINE_SURFACE_VERT_PIGGYBACK(Input, TreeVertLeaf)

void surf (Input IN, inout LeafSurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = c.rgb * _Color.rgb * IN.color.a;
	o.Translucency = tex2D(_TranslucencyMap, IN.uv_MainTex).rgb;
	o.Gloss = SUNSHINE_SAMPLE_1CHANNEL(_GlossMap, IN.uv_MainTex);
	o.Alpha = c.a;
	o.Specular = _Shininess;
	o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));
}
ENDCG
}

Dependency "OptimizedShader" = "Hidden/Sunshine/Nature/Tree Creator Leaves Optimized"
FallBack "Nature/Tree Creator Leaves"
}
