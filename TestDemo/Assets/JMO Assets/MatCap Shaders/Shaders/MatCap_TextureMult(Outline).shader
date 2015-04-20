// MatCap Shader, (c) 2013,2014 Jean Moreno

Shader "MatCap/Vertex/Textured Multiply(Outline)"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
//		_factorA("_factorA", Float) = 1
//		_factorB("_factorB", Float) = 1
//		_factorC("_factorC", Float) = 1
//		_factorD("_factorD", Float) = 1
//		_rimlightcolor ("Rim Light Color", Color) = (1.0, 1.0, 1.0, 1.0)
//		_rimlightscale ("Rim Light Scale", Float) = 1.0
//		_rimlightpower ("Rim Light Power", Float) = 0.2
		_OutlineColor("Outline Color", Color) = (1,1,1,1)
         _Outline("Outline Thickness", Float) = 1
         _OutlineDiffusion("Outline Diffusion", Float) = 1
	}
	
	Subshader
	{
		Tags { "RenderType"="Opaque" }
		
		Pass
		{
			Tags { "LightMode" = "Always" }
//			Cull Front
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"
				fixed4 _OutlineColor;
		 		fixed _Outline;
		 		fixed _OutlineDiffusion;
				struct v2f
				{
					float4 pos	: SV_POSITION;
					float2 uv 	: TEXCOORD0;
					float2 cap	: TEXCOORD1;
//					float4 color : COLOR;
//					float3 rim : TEXCOORD2;
//					float3 normal	: TEXCOORD3;
//					float3 viewDir	: TEXCOORD4;
				};
				
				uniform float4 _MainTex_ST;
//				float _factorA;
//				float _factorB;
//				float _factorC;
//				float _factorD;
//				fixed	_rimlightscale;
//				fixed	_rimlightpower;
//				fixed3	_rimlightcolor;
				v2f vert (appdata_full v)
				{
					v2f o;
					o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					float3 posWorld = mul(_Object2World, v.vertex).xyz;
					float3 viewDir = normalize(_WorldSpaceCameraPos - posWorld);
					float3 normalDir = normalize(mul(float4(v.normal, 0.0), _World2Object).xyz);
					fixed3x3 modelMatrixInverse = _World2Object; 
					half2 capCoord;
					capCoord.x = dot(UNITY_MATRIX_IT_MV[0].xyz,v.normal);
					capCoord.y = dot(UNITY_MATRIX_IT_MV[1].xyz,v.normal);
					o.cap = capCoord * 0.5 + 0.5;
//					o.color = v.color;
//					fixed rim = 1.0f - saturate( dot(normalize(ObjSpaceViewDir(v.vertex)), v.normal) );
////					fixed rim = saturate(dot(UNITY_MATRIX_V[1], normalize(mul(v.normal, modelMatrixInverse))));
//					fixed3 rimlight = (_rimlightcolor.rgb * pow(rim, _rimlightpower));
//					fixed attenuation = 1.0;
//					if (0.0 != _WorldSpaceLightPos0.w)
//					{ rimlight *= attenuation; }
//					o.rim = rimlight * _rimlightscale;		
//					o.normal = normalDir;
//					o.viewDir = viewDir;						
					return o;
				}
				
				uniform sampler2D _MainTex;
				uniform sampler2D _MatCap;
				
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 tex = tex2D(_MainTex, i.uv);
					fixed4 mc = tex2D(_MatCap, i.cap);
//					float outlineStren = saturate((dot(i.normal, i.viewDir) - _Outline) * 
//								pow(2-_OutlineDiffusion, 10) + _Outline);
//					float4 outlineOverlay = float4(_OutlineColor.rgb * (1-outlineStren) + outlineStren,1);
//					return (tex * mc * 2 + fixed4(i.rim, 1)) * outlineOverlay;
//					return (tex * mc * 2 + fixed4(i.rim, 1));
					return tex * mc * 2;
//					return tex * mc * _factorA + _factorB * tex + _factorC * mc + _factorD;
//					return lerp(tex * mc,mc, _factor);
				}
			ENDCG
		}
		UsePass "kokichi/Hidden/Outline/OUTLINE"
	}
	
	Fallback "VertexLit"
}