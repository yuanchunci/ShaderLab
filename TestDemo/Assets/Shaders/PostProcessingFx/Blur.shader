Shader "kokichi/Hidden/PostFX/Blur" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    SubShader {
        Pass {
            ZTest Always Cull Off ZWrite Off Lighting Off Fog { Mode off }
//            ColorMask 
            CGPROGRAM
                #pragma vertex vert_img
                #pragma fragment frag
                #pragma fragmentoption ARB_precision_hint_fastest
                #include "UnityCG.cginc"
 	
                sampler2D _MainTex;
 				fixed4x4 samples = fixed4x4
 				(  -1,  0, 0, 0.25,
 					1,  0, 0, 0.25,
 					0,  0, 0, 0.25,
 					0, -1, 0, 0.25
 				);
 				
                fixed4 frag (v2f_img IN) : COLOR {
//                    fixed4 col = tex2D(_MainTex, IN.uv);
                    fixed4 col;
                    for(int i = 0; i < 4 ; ++i)
                    {
                    	col += samples[i].w * tex2D(_MainTex, IN.uv + fixed2(samples[i].xy / _ScreenParams.xy));
                    }
                    return col;
                }
                
            ENDCG
        }
    }
    Fallback off
}