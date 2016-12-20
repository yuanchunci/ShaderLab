Shader "kokichi/Hidden/Stencil UI(Cutoff)"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white"{}
		_AlphaCut("Alpha cutoff", Range(0,1)) = 0.5
	}
	
	SubShader
	{
		Tags { "Queue" = "Transparent" }
		Pass
		{
			Name "PLANAR_SHADOW"
			Offset -1.0, -2.0 			
			Stencil
			{
				Ref 10
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			
			Lighting Off
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off
			Fog
			{
				Mode Off
			}
 
	         CGPROGRAM
	 		
	         #pragma vertex vert 
	         #pragma fragment frag
	 
	         #include "UnityCG.cginc"
	 		struct app_data
			{
				float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 tex : TEXCOORD0;
			};	
	         // User-specified uniforms
	         uniform fixed4 _ShadowColor;
	         uniform float _AlphaCut;
	 		 sampler2D	_MainTex;
			 fixed4	_MainTex_ST;
			 
	         v2f vert(app_data input) : SV_POSITION
	         {
	         	v2f output;
	         	output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
	         	output.tex = TRANSFORM_TEX(input.texcoord, _MainTex);
	            return output;
	         }
	 
	         float4 frag(v2f input) : COLOR 
	         {
	         	float4 color = tex2D(_MainTex, input.tex);
	         	clip(color.a - _AlphaCut);
	            return color;
	         }
			ENDCG
		}
		
	}
}
