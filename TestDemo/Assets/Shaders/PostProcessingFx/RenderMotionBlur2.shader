Shader "kokichi/Hidden/PostFX/RenderMotionBlur2" {
 Properties {
 	 _MainTex ("Base (RGB)", 2D) = "white" {}
 	 _VelocTex ("Base (RGB)", 2D) = "black" {}
 	 _VelocScale("Velocity Scale", Float) = 0
 }
 SubShader {
	  Pass {
		   ZTest Always Cull Off ZWrite Off Lighting Off Fog { Mode off }
		   Blend SrcAlpha OneMinusSrcAlpha
//            ColorMask 
            CGPROGRAM
                #pragma vertex vert_img
                #pragma fragment frag
                #pragma fragmentoption ARB_precision_hint_fastest
                #include "UnityCG.cginc"
// 	 			#pragma target 3.0
                sampler2D _MainTex;
                sampler2D _VelocTex;
 				fixed _AccumOrig;
                fixed4 frag (v2f_img IN) : COLOR {
					fixed4 col = tex2D(_MainTex, IN.uv);
					fixed velocity = tex2D(_VelocTex, IN.uv).r;
                    col.a =  velocity * _AccumOrig + (1-velocity);
					return col;
                }
	  
	  		ENDCG
	  }
 }
 

}