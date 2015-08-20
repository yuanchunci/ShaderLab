Shader "kokichi/Hidden/PostFX/RenderDepthTexture" {
 Properties {
 }
 SubShader {
	  Tags { "RenderType"="Opaque" }
	  
	  Pass {
		  CGPROGRAM
		  #pragma vertex vert0
		  #pragma fragment frag0
		  #include "UnityCG.cginc"
		  
		  
		  struct v2f {
			   float4 position : SV_POSITION;
			   fixed depth : TEXCOORD0;
		  };
		  
		  v2f vert(appdata_base v )
		  {
			   v2f o;
			   o.position = mul(UNITY_MATRIX_MVP, v.vertex);
			   float depth = o.position.z / o.position.w;
			   o.depth = DecodeFloatRGBA(EncodeFloatRGBA(depth));
			   return o;
		  }
//		  
		  fixed4 frag(v2f IN) : COLOR
		  {
//		  	   return fixed4( DecodeFloatRGBA(EncodeFloatRGBA(min( IN.depth.r,0.999 ))));
		  	   return (IN.depth );
//		  	   return fixed4( (EncodeFloatRGBA(IN.depth.r)));
		  }

	  
	  	 v2f vert0(appdata_base v )
		  {
			   v2f o;
			   o.position = mul(UNITY_MATRIX_MVP, v.vertex);
			   float depth = o.position.z / o.position.w;
			   o.depth = (EncodeFloatRGBA(depth));
			   return o;
		  }
		  
		  fixed4 frag0(v2f IN) : COLOR
		  {
		  	   return (IN.depth );
		  }	  
		 
	  
	  ENDCG
	  }
 }
 
}