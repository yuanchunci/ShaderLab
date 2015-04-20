Shader "kokichi/Hidden/PostFX/GrayScale" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _W("weight", Float) = 1
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
 				uniform fixed _W;
                fixed4 frag (v2f_img i) : COLOR {
                    fixed4 col = tex2D(_MainTex, i.uv);
                    fixed intensity = 0.299 * col.r + 0.587 * col.g + 0.184 * col.r;
                    return lerp(col,fixed4(intensity.xxx,col.a), _W);
                }
            ENDCG
        }
    }
    Fallback off
}