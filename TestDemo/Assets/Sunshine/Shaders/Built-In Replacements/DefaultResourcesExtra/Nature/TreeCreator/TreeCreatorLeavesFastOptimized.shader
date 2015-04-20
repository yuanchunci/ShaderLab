// Updated for Sunshine 1.4.3
Shader "Hidden/Sunshine/Nature/Tree Creator Leaves Fast Optimized" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_TranslucencyColor ("Translucency Color", Color) = (0.73,0.85,0.41,1) // (187,219,106,255)
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.3
	_TranslucencyViewDependency ("View dependency", Range(0,1)) = 0.7
	_ShadowStrength("Shadow Strength", Range(0,1)) = 1.0
	
	_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
	_ShadowTex ("Shadow (RGB)", 2D) = "white" {}

	// These are here only to provide default values
	_Scale ("Scale", Vector) = (1,1,1,1)
	_SquashAmount ("Squash", Float) = 1
}

SubShader { 
	Tags {
		"IgnoreProjector"="True"
		"RenderType" = "TreeLeaf"
	}
	LOD 200

	Pass {
		Tags { "LightMode" = "ForwardBase" }
		Name "ForwardBase"

	CGPROGRAM
		
		#include "Assets/Sunshine/Shaders/Compatibility/Helper.cginc"
		#if UnityMajorVersion >= 5
			#include "Assets/Sunshine/Shaders/Compatibility/UnityBuiltin3xTreeLibrary.cginc"
		#else
			#include "TreeVertexLit.cginc"
		#endif

		#include "Assets/Sunshine/Shaders/Sunshine.cginc"

		#pragma vertex VertexLeaf
		#pragma fragment FragmentLeaf
		#pragma exclude_renderers flash
		#pragma multi_compile_fwdbase nolightmap
		
		//Leaves don't require higher quality filters:
		#pragma multi_compile SUNSHINE_DISABLED SUNSHINE_FILTER_PCF_2x2 SUNSHINE_FILTER_HARD
		#pragma target 3.0
		
		sampler2D _MainTex;
		float4 _MainTex_ST;

		fixed _Cutoff;
		sampler2D _ShadowMapTexture;

		struct v2f_leaf {
			float4 pos : SV_POSITION;
			fixed4 diffuse : COLOR0;
			fixed4 mainLight : COLOR1;
			float2 uv : TEXCOORD0;
		#if defined(SHADOWS_SCREEN)
			float4 screenPos : TEXCOORD1;
		#else
			SUNSHINE_INPUT_PARAMS;
		#endif
		};

		v2f_leaf VertexLeaf (appdata_full v)
		{
			v2f_leaf o;
			TreeVertLeaf(v);
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

			fixed ao = v.color.a;
			ao += 0.1; ao = saturate(ao * ao * ao); // emphasize AO

			fixed3 color = v.color.rgb * _Color.rgb * ao;
			
			float3 worldN = mul ((float3x3)_Object2World, SCALED_NORMAL);

			fixed4 mainLight;
			mainLight.rgb = ShadeTranslucentMainLight (v.vertex, worldN) * color;
			mainLight.a = v.color.a;
			o.diffuse.rgb = ShadeTranslucentLights (v.vertex, worldN) * color;
			o.diffuse.a = 1;

			o.mainLight = mainLight;
		#if defined(SHADOWS_SCREEN)
			o.screenPos = ComputeScreenPos (o.pos);
		#endif					
			o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
			
			#if !defined(SHADOWS_SCREEN)
				SUNSHINE_WRITE_VERTEX(v, o);
			#endif
			
			return o;
		}

		fixed4 FragmentLeaf (v2f_leaf IN) : COLOR
		{
			fixed4 albedo = tex2D(_MainTex, IN.uv);
			fixed alpha = albedo.a;
			clip (alpha - _Cutoff);

			half4 light = IN.mainLight;
		#if defined(SHADOWS_SCREEN)
			half atten = tex2Dproj(_ShadowMapTexture, UNITY_PROJ_COORD(IN.screenPos)).r;
		#else
			half atten = SunshineLightAttenuation(IN.sunshine_lightData);
		#endif
			light.rgb *= lerp(2, 2*atten, _ShadowStrength);
			light.rgb += IN.diffuse.rgb;

			return fixed4 (albedo.rgb * light, 0.0);
		}

	ENDCG
	}

} 

Dependency "BillboardShader" = "Hidden/Nature/Tree Creator Leaves Rendertex"

Fallback "Hidden/Nature/Tree Creator Leaves Fast Optimized"
}
