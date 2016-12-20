Shader "kokichi/Environment/AnimatedByVertexColor" {
	Properties {
		_MainTex("Diffuse (RGB) Self-Illumination (A)", 2D)	= "white" {}
	}
	SubShader {
	Tags { "Queue" = "Transparent" } 
	Pass
	{
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Lighting Off
		ZWrite Off
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"
		sampler2D	_MainTex;
		fixed4	_MainTex_ST;
		fixed	_Alpha;
		
		
		struct app_data
		{
			fixed4 vertex : POSITION;
			fixed4 texcoord : TEXCOORD0;
			fixed4 color : COLOR;
		};

		struct v2f
		{
			fixed4 pos : SV_POSITION;
			fixed2 uv : TEXCOORD0;
			fixed4 color : COLOR;
		};

		v2f vert(app_data input) 
		{
			v2f output;
			output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
			output.uv = TRANSFORM_TEX(input.texcoord, _MainTex);
			output.color = input.color;
			return output;
		}
 
         fixed4 frag(v2f input) : COLOR
         {
         	fixed4 finalColor = tex2D(_MainTex, input.uv.xy) * 1.5 * input.color.a ;
         	finalColor.a *= (_Alpha > input.color.r);
            return finalColor;
         }
		ENDCG
	}
		
	} 
	FallBack "Diffuse"
}
