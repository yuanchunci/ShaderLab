Shader "Custom/3DiffuseAlpha" {
	Properties {
		_basetexture("Diffuse (RGB) Self-Illumination (A)", 2D)	= "white" {}
		_alpha ("Alpha ", Range(0,1)) = 1
	}
	SubShader {
	Tags { "Queue" = "Geometry" } 
	Pass
	{
//		Tags { "LIGHTMODE"="ForwardBase" "Queue"="Transparent" }
		
//		Blend SrcAlpha OneMinusSrcAlpha
//		Cull Off
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		
		sampler2D	_basetexture;
		fixed	_alpha;
		
		
		struct app_data
		{
			fixed4 vertex : POSITION;
			fixed4 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			fixed4 pos : SV_POSITION;
			fixed4 tex : TEXCOORD1;
		};

		v2f vert(app_data input) 
		{
			v2f output;
			output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
			output.tex = input.texcoord;
			return output;
		}
 
         fixed4 frag(v2f input) : COLOR
         {
         	fixed4 finalColor = (0,0,0,1);
         	fixed4 diffuseColor = tex2D(_basetexture, input.tex.xy);
			finalColor = diffuseColor;
//			if(finalColor.a < 0)
//				discard;
//			finalColor.a = 0.5;
            return finalColor;
         }
		ENDCG
	}
		
	} 
	FallBack "Diffuse"
}
