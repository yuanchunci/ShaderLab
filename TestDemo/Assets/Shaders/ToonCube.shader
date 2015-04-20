 Shader "Custom/ToonCube" {
     Properties 
     {
         _MainTex ("Base (RGB)", 2D) = "white" {}
         _ToonRampTex ("Toon Cube", CUBE) = "white" {Texgen CubeNormal}
         _AlphaCut("CutOff", Range(0,1)) = 0
     }
     SubShader {
         Tags { "RenderQueue"="Geometry" }
       Pass
	{
		Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry"}
//		Blend SrcAlpha OneMinusSrcAlpha
         LOD 200
         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag
         #include "UnityCG.cginc"
         sampler2D _MainTex;
         samplerCUBE _ToonRampTex;
 		fixed _AlphaCut;
 		uniform fixed4 _LightColor0;
		struct v2f
		{
			float4 pos	: POSITION;
			float2 uv 	: TEXCOORD0;
			float3 cap	: TEXCOORD1;
			float4 diff	: TEXCOORD2;
		};
         
         v2f vert (appdata_base v)
		{
			v2f o;
			o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
			o.uv = v.texcoord;
			float3x3 m = float3x3(UNITY_MATRIX_IT_MV[0].xyz,UNITY_MATRIX_IT_MV[0].xyz,UNITY_MATRIX_IT_MV[0].xyz);
			o.cap = mul(m,v.normal);
			return o;
		}

		float4 frag (v2f i) : COLOR
		{
			float4 tex = tex2D(_MainTex, i.uv);
			float4 mc = texCUBE(_ToonRampTex, (i.cap));
			if(tex.a < _AlphaCut)
				discard;
			else
				return tex * mc * 2;
		}
         ENDCG
     } 
     
     }
     FallBack "Diffuse"
 }