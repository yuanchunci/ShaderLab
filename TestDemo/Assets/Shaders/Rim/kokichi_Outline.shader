Shader "kokichi/Hidden/Outline"
{
	Properties
	{
		//OUTLINE
		_Outline ("Outline Width", Float) = 1.0
		_OutlineColor ("Outline Color", Color) = (0.2, 0.2, 0.2, 1)
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Geometry" }
		
		//Outline default
		Pass
		{
			Name "OUTLINE"
			Cull Front
//			ZWrite Off
//			ZTest Always
//			ColorMask RGB
//			Blend SrcAlpha OneMinusSrcAlpha 
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			struct a2v
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			}; 
			
			struct v2f
			{
				float4 pos : POSITION;
			};
			
			float _Outline;
			sampler2D _MainTex;
			fixed4 _OutlineColor;
			float4 _MainTex_ST;
			
			v2f vert (a2v v)
			{
				v2f o;
				float4 pos = mul( UNITY_MATRIX_MV, v.vertex + float4(v.normal,0) * _Outline);
				o.pos = mul(UNITY_MATRIX_P, pos);
				return o;
			}
			
			float4 frag (v2f IN) : COLOR
			{
				return _OutlineColor;
			}
			ENDCG
		}
	}
}
