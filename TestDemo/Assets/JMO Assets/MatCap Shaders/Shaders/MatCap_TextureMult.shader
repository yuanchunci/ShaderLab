// MatCap Shader, (c) 2013,2014 Jean Moreno

Shader "MatCap/Vertex/Textured Multiply"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
		_factorA("_factorA", Float) = 1
		_factorB("_factorB", Float) = 1
		_factorC("_factorC", Float) = 1
		_factorD("_factorD", Float) = 1
		_rimlightcolor ("Rim Light Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_rimlightscale ("Rim Light Scale", Float) = 1.0
		_rimlightpower ("Rim Light Power", Float) = 0.2
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
				
				struct v2f
				{
					float4 pos	: SV_POSITION;
					fixed2 uv 	: TEXCOORD0;
					fixed2 cap	: TEXCOORD1;
//					float4 color : COLOR;
//					float3 rim : TEXCOORD2;
				};
				
				uniform float4 _MainTex_ST;
				float _factorA;
				float _factorB;
				float _factorC;
				float _factorD;
				fixed	_rimlightscale;
				fixed	_rimlightpower;
				fixed3	_rimlightcolor;
				v2f vert (appdata_full v)
				{
					v2f o;
					o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					fixed3x3 modelMatrixInverse = _World2Object; 
					fixed2 capCoord;
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
					return o;
				}
				
				uniform sampler2D _MainTex;
				uniform sampler2D _MatCap;
				
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 tex = tex2D(_MainTex, i.uv);
					fixed4 mc = tex2D(_MatCap, i.cap);
					return tex * mc * 2 ;//+ fixed4(i.rim, 1);
//					return tex * mc;
//					return tex * mc * _factorA + _factorB * tex + _factorC * mc + _factorD;
//					return lerp(tex * mc,mc, _factor);
				}
			ENDCG
		}
		
		
	}
	
	Fallback "VertexLit"
}