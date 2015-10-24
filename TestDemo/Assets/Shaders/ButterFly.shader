Shader "kokichi/Environment/ButterFly" {
	Properties {
		_MainTex("Diffuse (RGB) Self-Illumination (A)", 2D)	= "white" {}
		_Vec("Velocity", Vector) = (1,1,1,1)
		_VecAmount("Amount Velocity", Range(0,1)) = 0.5
		_Frequency("_Frequency", Float) = 5
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
		fixed	_VecAmount;
		fixed	_Frequency;
		fixed4 _Vec;
		
		
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
			fixed4 amount = _Vec * input.color.r;
			amount = lerp(amount, amount * sin(_Frequency * _Time.z), _VecAmount);
			output.pos = mul(UNITY_MATRIX_MVP, input.vertex) + amount;
			output.uv = TRANSFORM_TEX(input.texcoord, _MainTex);
			output.color = input.color;
			return output;
		}
 
         fixed4 frag(v2f input) : COLOR
         {
         	fixed4 finalColor = tex2D(_MainTex, input.uv.xy) * 1.5;
         	finalColor.a *= input.color.a;
            return finalColor;
         }
		ENDCG
	}
		
	} 
	FallBack "Diffuse"
}
