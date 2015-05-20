//http://forum.unity3d.com/threads/96393-Achieving-a-multi-pass-effect-with-a-Surface-Shader
//http://answers.unity3d.com/questions/11175/how-to-make-an-outline-of-an-object-behind-a-wall.html
 
Shader "Custom/NewOcclusionOutline" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _RimCol ("Rim Colour" , Color) = (1,0,0,1)
        _RimPow ("Rim Power", Float) = 1.0
    }
    SubShader {
    		Tags { "Queue"="Geometry+1"}
    		
    		Pass {
				Name "WALl"
				Cull Off
				ZWrite Off // dont write to z-buff to render xray color only
				ZTest Greater // further to camera will be render first

				Blend SrcAlpha OneMinusSrcAlpha

				CGPROGRAM
		        #pragma vertex vert
		        #pragma fragment frag
		        #include "UnityCG.cginc"
	                
				fixed4	_RimCol;
				
				
				fixed4 vert (appdata_base v) : POSITION
		        {
		            return mul(UNITY_MATRIX_MVP, v.vertex);
		        }
	                
				fixed4 frag() :COLOR {
					return fixed4(_RimCol);
				}
				ENDCG
			}
            	
    		Pass {
                Name "Regular"
                ZTest LEqual                // this checks for depth of the pixel being less than or equal to the shader
                ZWrite On                   // and if the depth is ok, it renders the main texture.
                Cull Back
               
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
               
                struct v2f {
                    float4 pos : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };
               
                sampler2D _MainTex;
                float4 _MainTex_ST;
               
                v2f vert (appdata_base v)
                {
                    v2f o;
                    o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                    o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                    return o;
                }
               
                half4 frag (v2f i) : COLOR
                {
                    half4 texcol = tex2D(_MainTex,i.uv);
                    return texcol;
                }
                ENDCG
            } 
            
        
           
                     
        }
    FallBack "VertexLit"
}