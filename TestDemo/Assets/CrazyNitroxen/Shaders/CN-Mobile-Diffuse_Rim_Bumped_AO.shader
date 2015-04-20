//---------------------------------------------------------------//
//	special thanks to MatCap Shader, (c) 2013 Jean Moreno.
//	Custom tweak MatCap Shader Author (c) 2013 Crazy Nitroxen.
//	http://www.leegoonz.com	
//	https://www.facebook.com/crazynitroxen
//	email : leegoon73@gmail.com
//---------------------------------------------------------------//

Shader "Crazy Nitroxen/Mobile/BonusShader/MatCap_Diffuse_Bumped_Rim_AO(unlit)"
{
	Properties
	{
		_MainTex ("Diffuse (RGB)", 2D) = "white" {}
		_NormalTex("Normal (RGB)", 2D) = "white" {}
		_InvertY("Invert_Y" , Range(-1,1)) = 0
		_AOTex("AO (RGB)", 2D) = "white" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
		_MatCapBlendFactor ("MatCap Blend Factor" , float) = 1
		_MatRim ("RimTex (RGB)", 2D) = "white" {}
		_RimPower ("RimPower", float) = 1
		_RimColor("Rim Color" , Color) = (1 , 1 , 1 , 1)
		
		
	}
	
	Subshader
	{
		Tags { "RenderType"="Opaque" }
		Pass
		{
			
			
			Tags { "LightMode" = "Always" }
		
			
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"
				
				struct v2f
				{
					float4 pos	: SV_POSITION;
					float2 uv 	: TEXCOORD0;
					float2 uv_bump	: TEXCOORD1;
					
					float3 c0 : TEXCOORD2;
					float3 c1 : TEXCOORD3;
					
				};
				
				uniform float4 _MainTex_ST;
				uniform float4 _NormalTex_ST;
				
				
				v2f vert (appdata_tan v)
				{
					v2f o;
					o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.uv_bump = TRANSFORM_TEX(v.texcoord,_NormalTex);
					
					TANGENT_SPACE_ROTATION;
					o.c0 = mul(rotation, UNITY_MATRIX_IT_MV[0].xyz);
					o.c1 = mul(rotation, UNITY_MATRIX_IT_MV[1].xyz);
					
					return o;
				}
				
				uniform sampler2D	_MainTex;
				uniform sampler2D	_NormalTex;
				uniform sampler2D	_AOTex;
				uniform sampler2D	_MatCap;
				uniform sampler2D	_MatRim;
				uniform float		_InvertY;
				uniform float		_RimPower;
				uniform fixed		_MatCapBlendFactor;
				uniform fixed4 _RimColor;
				
				
				
				
			
				
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 tex = tex2D(_MainTex, i.uv);
					fixed4 ao  = tex2D(_AOTex, i.uv).r;
					fixed3 normals = UnpackNormal(tex2D(_NormalTex, i.uv_bump));
					
					normals = float3(normals.x , normals.y * _InvertY , normals.z);
					
					fixed2 capCoord = half2(dot(i.c0, normals), dot(i.c1, normals));
					
					float4 mc = tex2D(_MatCap, capCoord*0.5+0.5) * _MatCapBlendFactor;
					fixed4 mcRim = tex2D(_MatRim, capCoord*0.5+0.5) *_RimColor;
					return tex *  ((mc * 2.0) * ao) + (mcRim * _RimPower) ;
				
				}
			ENDCG
		}
	}
	
	Fallback "VertexLit"
}