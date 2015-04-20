Shader "kokichi/Hidden/PostFX/RenderMotionBlur" {
 Properties {
 	 _MainTex ("Base (RGB)", 2D) = "white" {}
 	 _VelocTex ("Base (RGB)", 2D) = "black" {}
 	 _VelocScale("Velocity Scale", Float) = 0
 }
 SubShader {
	  Tags { "RenderType"="Opaque" }
	  LOD 200
	  
	  Pass {
		   ZTest Always Cull Off ZWrite Off Lighting Off Fog { Mode off }
//            ColorMask 
            CGPROGRAM
                #pragma vertex vert_img
                #pragma fragment frag
                #pragma fragmentoption ARB_precision_hint_fastest
                #include "UnityCG.cginc"
// 	 			#pragma target 3.0
                sampler2D _MainTex;
                sampler2D _VelocTex;
 				float _VelocScale;
                fixed4 frag (v2f_img IN) : COLOR {
					float2 velocity = tex2D(_VelocTex, IN.uv).rg;
					velocity *= _VelocScale;

					float4 oResult = tex2D(_MainTex, IN.uv);
					for (int i = 1; i < 8; ++i) {
						vec2 offset = velocity * (float(i) / float(8 - 1) - 0.5);
						oResult.rgb += tex2D(_MainTex, IN.uv + offset).rgb;
					}
					oResult.rgb /= 8;
//					oResult.rg += velocity;
					return oResult;
                }
	  
	  		ENDCG
	  }
 }
 

}