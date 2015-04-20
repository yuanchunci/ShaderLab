// Updated for Sunshine 1.4.3
Shader "Hidden/Sunshine/Occluder"
{
    Properties
    {
		_MainTex ("", 2D) = "white" {}
		_Cutoff ("", Float) = 0.5
		_Color ("", Color) = (1,1,1,1)
    }
    
    CGINCLUDE
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		
		#include "Assets/Sunshine/Shaders/Compatibility/Helper.cginc"
		#if UnityMajorVersion >= 5
			#include "Assets/Sunshine/Shaders/Compatibility/UnityBuiltin3xTreeLibrary.cginc"
		#else
		    fixed4 _Color;
			#include "TerrainEngine.cginc"
		#endif
		
	    sampler2D _MainTex;
	    float4 _MainTex_ST;
	    fixed _Cutoff;
	    #define SHADOW_CUTOFF(alpha, cutoff) clip((alpha) - (cutoff))

		#include "Assets/Sunshine/Shaders/Sunshine.cginc"
		#define SLOPE_BIAS

		float2 sunshine_DepthBiases;
		#define sunshine_DepthBias (sunshine_DepthBiases.x)
		#define sunshine_DepthSlopeBias (sunshine_DepthBiases.y)
							
		struct v2f {
		    float4 pos : SV_POSITION;
		    float2 uv : TEXCOORD0;
		    fixed4 color : COLOR;
			float2 depthAndBias : TEXCOORD1;
		};

		
		void baseVert_Depth (appdata_full v, inout v2f o) 
		{
		    o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		    o.depthAndBias = mul(UNITY_MATRIX_MV, v.vertex).z;
		}
		v2f baseVert (appdata_full v, v2f o)
		{
			baseVert_Depth(v, o);
		    #ifdef SLOPE_BIAS
				o.depthAndBias.y = sunshine_DepthBias + (1.0 - mul((float3x3)UNITY_MATRIX_IT_MV, v.normal.xyz).z) * sunshine_DepthSlopeBias;
		    #endif
		    return o;
		}
		v2f baseVertNoSlope (appdata_full v, v2f o)
		{
			baseVert_Depth(v, o);
		    return o;
		}
		v2f vert (appdata_full v) 
		{
		    v2f o;
		    SUNSHINE_INITIALIZE_OUTPUT(v2f, o);
		    o.uv = TRANSFORM_TEX(v.texcoord.xy, _MainTex);
		    return baseVert(v, o);
		}

		v2f treeVert( appdata_full v )
		{
			v2f o;
		    SUNSHINE_INITIALIZE_OUTPUT(v2f, o);
		 	TerrainAnimateTree(v.vertex, v.color.w);
		 	o.uv = v.texcoord.xy;
		 	return baseVert(v, o);
		}
		
		fixed4 frag (v2f i)
		{
		    #ifdef SLOPE_BIAS
				float depth = (-i.depthAndBias.x + max(0.0, i.depthAndBias.y)) * _ProjectionParams.w;
		    #else
				float depth = (-i.depthAndBias.x + sunshine_DepthBias) * _ProjectionParams.w;
			#endif
			return WriteSun(min(depth, 0.995));
		}
		fixed4 opaqueFrag (v2f i) : COLOR
		{
			return frag(i);
		}
		fixed4 cutoutFrag (v2f i) : COLOR
		{
			SHADOW_CUTOFF(SUNSHINE_SAMPLE_1CHANNEL(_MainTex, i.uv), _Cutoff);
			return frag(i);
		}
		fixed4 alphaFrag (v2f i) : COLOR
		{
			SHADOW_CUTOFF(SUNSHINE_SAMPLE_1CHANNEL(_MainTex, i.uv) * _Color.a, 0.75);
			return frag(i);
		}
		fixed4 constColorCutoutFrag (v2f i) : COLOR
		{
			SHADOW_CUTOFF(SUNSHINE_SAMPLE_1CHANNEL(_MainTex, i.uv) * _Color.a, _Cutoff);
			return frag(i);
		}
		fixed4 vertColorCutoutFrag (v2f i) : COLOR
		{
			SHADOW_CUTOFF(SUNSHINE_SAMPLE_1CHANNEL(_MainTex, i.uv) * i.color.a, _Cutoff);
			return frag(i);
		}
	ENDCG

	Category
	{
		Fog { Mode Off }

	    SubShader
		{
			Tags { "RenderType" = "Opaque" }
			Pass
		    {
				CGPROGRAM
					#pragma vertex vert
					#pragma fragment opaqueFrag
				ENDCG
		    }
		}
		SubShader
		{
			Tags { "RenderType" = "TransparentCutout" }
			Pass
		    {
		    	//Cull Off
				CGPROGRAM
					#pragma vertex vert
					#pragma fragment constColorCutoutFrag
				ENDCG
		    }
		}
		SubShader
		{
			Tags { "RenderType" = "Transparent" }
			Pass
		    {
		    	//Cull Off
				CGPROGRAM
					#pragma vertex vert
					#pragma fragment alphaFrag
				ENDCG
		    }
		}
	    SubShader
		{
			Tags { "RenderType" = "TreeOpaque" }
			Pass
		    {
				CGPROGRAM
					#pragma vertex treeVert
					#pragma fragment opaqueFrag
				ENDCG
		    }
		}
		SubShader
		{
			Tags { "RenderType" = "TreeTransparentCutout" }
			Pass
		    {
		    	Cull Off
				CGPROGRAM
					#pragma vertex treeVert
					#pragma fragment cutoutFrag
				ENDCG
		    }
		}

		SubShader
		{
			Tags { "RenderType" = "TreeBark" }
			Pass
			{
				CGPROGRAM
					#pragma vertex barkVert
					#pragma fragment opaqueFrag
					#pragma glsl_no_auto_normalization
					v2f barkVert( appdata_full v )
					{
	  				 	TreeVertBark(v);
	  				 	return vert(v);
					}
				ENDCG
			}
		}
		SubShader
		{
			Tags { "RenderType" = "TreeLeaf" }
			Pass
			{
				//Cull Off
				CGPROGRAM
					#pragma vertex leafVert
					#pragma fragment cutoutFrag
					#pragma glsl_no_auto_normalization
					v2f leafVert( appdata_full v )
					{
	  				 	TreeVertLeaf(v);
	  				 	return vert(v);
					}
				ENDCG
			}
		}
		SubShader
		{
			Tags { "RenderType" = "Grass" }
			Pass
		    {
		    	Cull Off
				CGPROGRAM
					#pragma vertex grassVert
					#pragma fragment vertColorCutoutFrag
					v2f grassVert( appdata_full v )
					{
						v2f o;
					    SUNSHINE_INITIALIZE_OUTPUT(v2f, o);
					 	WavingGrassVert(v);
						o.color = v.color;
					 	o.uv = v.texcoord.xy;
					 	return baseVert(v, o);
					}
				ENDCG
		    }
		}
		/*
		SubShader
		{
			Cull Off
			Tags { "RenderType" = "AtsFoliage" }
			Pass
			{
					CGPROGRAM
						#define _Color _AtsColor
						#include "../../../Advanced Foliage Shader v2.041/Shaders/Includes/Tree.cginc"
						#include "../../../Advanced Foliage Shader v2.041/Shaders/Includes/CustomBending.cginc"
						#undef _Color
						#undef SLOPE_BIAS
						#pragma vertex vertAtsFoliage
						#pragma fragment cutoutFrag
						
						v2f vertAtsFoliage( appdata_full v )
						{
							v2f o;
						    SUNSHINE_INITIALIZE_OUTPUT(v2f, o);
							CustomBending (v);
							o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
						 	return baseVert(v, o);
						}
						
					ENDCG

			}
		}
		SubShader
		{
			Cull Off
			Tags { "RenderType" = "AtsFoliageTouchBending" }
			Pass
			{
					CGPROGRAM
						#define _Color _AtsColor
						#include "../../../Advanced Foliage Shader v2.041/Shaders/Includes/Tree.cginc"
						#include "../../../Advanced Foliage Shader v2.041/Shaders/Includes/TouchBending.cginc"
						#undef _Color
						#undef SLOPE_BIAS
						#pragma vertex vertAtsFoliage
						#pragma fragment cutoutFrag
						
						v2f vertAtsFoliage( appdata_full v )
						{
							v2f o;
						    SUNSHINE_INITIALIZE_OUTPUT(v2f, o);
							TouchBending (v);
							o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
						 	return baseVert(v, o);
						}
						
					ENDCG

			}
		}
		*/
	}
	Fallback Off
}