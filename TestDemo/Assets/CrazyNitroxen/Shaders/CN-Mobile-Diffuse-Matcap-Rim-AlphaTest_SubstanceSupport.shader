//---------------------------------------------------------------//
//	special thanks to MatCap Shader, (c) 2013 Jean Moreno.
//	Custom tweak MatCap Shader Author (c) 2013 Crazy Nitroxen.
//	http://www.leegoonz.com
//	https://www.facebook.com/crazynitroxen
//	email : leegoon73@gmail.com
//---------------------------------------------------------------//

Shader "Crazy Nitroxen/Mobile/Substance Mobile/MatCap_Diffuse_Rim(unlit)_AlphaTest"
{
	Properties
	{
		_MainTex ("Base (RGBA)", 2D) = "white" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
		_MatCapBlendFactor ("MatCap Blend Factor" , float) =1
		_MatRim ("RimTex (RGB)", 2D) = "white" {}
		_RimPower ("RimPower", float) = 1
		_AlphaTest("AlphaTest" , Range(0,1))=1
		
		
	}
	
	Subshader
	{
		Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
		LOD 100
		
		Lighting OFF
		Cull OFF
		
		Pass
		{
			
			
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"
				
				struct v2f
				{
					float4 pos	: SV_POSITION;
					float2 uv 	: TEXCOORD0;
					float2 cap	: TEXCOORD1;
				};
				
				
				sampler2D _MainTex;
				sampler2D _MatCap;
				sampler2D _MatRim;
				float4 _MainTex_ST;						
				float _RimPower;
				
				float _MatCapBlendFactor;
				fixed _AlphaTest;
				
				v2f vert (appdata_base v)
				{
					v2f o;
					o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					
					half2 capCoord;
					capCoord.x = dot(UNITY_MATRIX_IT_MV[0].xyz,v.normal);
					capCoord.y = dot(UNITY_MATRIX_IT_MV[1].xyz,v.normal);
					o.cap = capCoord * 0.5 + 0.5;
					
					return o;
				}
		
				
				
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 tex = tex2D(_MainTex, i.uv);
					fixed4 mc = tex2D(_MatCap, i.cap) * _MatCapBlendFactor;
					fixed4 mcRim = tex2D(_MatRim, i.cap);
					fixed4 finalcolor = tex * mc * 2.0 + (mcRim * _RimPower);
					clip(tex.a - _AlphaTest);
					return finalcolor;
				}
			ENDCG
		}
	}
	
	SubShader 
	{
	Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 100
	
	Pass 
	{
		Lighting Off
		Alphatest Greater [_AlphaTest]
		SetTexture [_MainTex] { combine texture } 
	}
	}
	
	Fallback "VertexLit"
}
