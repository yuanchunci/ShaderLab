Shader "Cg shader for billboards" {
   Properties {
      _MainTex ("Texture Image", 2D) = "white" {}
      _Scale ("Scale (X,Y)", Vector) = (1,1,0,0)
   }
   SubShader {
   	  
      Pass {   
         CGPROGRAM
 
         #pragma vertex vert  
         #pragma fragment frag 
 
         // User-specified uniforms            
         uniform sampler2D _MainTex;        
         uniform float2 _Scale;        
 
         struct vertexInput {
            float4 vertex : POSITION;
            float4 tex : TEXCOORD0;
         };
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 tex : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.pos = mul(UNITY_MATRIX_P, mul(UNITY_MATRIX_MV, float4(0.0, 0.0, 0.0, 1.0))
              + float4(input.vertex.x * _Scale.x, input.vertex.y * _Scale.y, 0.0, 0.0));
//              output.pos = mul(UNITY_MATRIX_MVP, float4(0.0, 0.0, 0.0, 1.0));
//              output.pos /= output.pos.w;
//              output.pos += float4(input.vertex.x * _Scale.x, input.vertex.y * _Scale.y, 0.0, 0.0); 
 
            output.tex = input.tex;
 
            return output;
         }
 			
 		 uniform sampler2D _CameraDepthTexture;
         float4 frag(vertexOutput input) : COLOR
         {
         	float4 c = tex2D(_CameraDepthTexture,input.tex.xy);
//            return tex2D(_MainTex, float2(input.tex.xy));   
			return c;
         }
 
         ENDCG
      }
   }
}