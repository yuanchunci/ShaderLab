Shader "Custom/RippleWaveShader" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Scale ( "Scale ", Float) = 1
		_Speed ("Speed", Float) = 1
		_Frequency ( "Frequency", Float) = 1
		_WaveInfo("Offset(X,Y,Z) WaveAmplitude(W)", Vector) = (0,0,0,0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		Pass
		{  
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			sampler2D _MainTex;
			float _Scale, _Speed, _Frequency;
			float4 _WaveInfo;
			
			struct app_data
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert(app_data v)
			{
				v2f output;
				float offsetvert = ( v.vertex.x * v.vertex.x ) + 
						( v.vertex.y * v.vertex.y );
				float offsetvert2 = v.vertex.x * _WaveInfo.x + v.vertex.y * _WaveInfo.y;
//				float offsetvert = ( v.vertex.x  * v.vertex.z );
				float value = _Scale * sin(_Time.w * _Speed + offsetvert * _Frequency + offsetvert2);
//				v.vertex.z += value * _WaveInfo.w + _WaveInfo.z;
				output.pos = v.vertex;
//				output.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				output.uv = v.texcoord - value * _WaveInfo.w + _WaveInfo.z;
				return output;
			}
			
			float4 frag(v2f input) : COLOR
			{
				float4 c = tex2D(_MainTex, input.uv);
				return c;
			}
			
			ENDCG
		}
	} 
	FallBack "Diffuse"
}
