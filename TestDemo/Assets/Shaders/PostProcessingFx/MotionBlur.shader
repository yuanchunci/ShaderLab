Shader "kokichi/Hidden/PostFX/MotionBlur" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _AccumOrig("Weight", Float) = 1
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
 	
                sampler2D _MainTex;
 				fixed _AccumOrig;
 				
                fixed4 frag (v2f_img IN) : COLOR {
                    fixed4 col = tex2D(_MainTex, IN.uv);
                    col.a = _AccumOrig;
                    return col;
                }
                
            ENDCG
        }
    }
    Fallback off
}