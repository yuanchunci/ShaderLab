Shader "kokichi/Hidden/PostFX/RenderVelocBuffer2" {
 Properties {
 }
 SubShader {
	  Tags { "RenderType"="Opaque" }
	  LOD 200
	  
	  Pass {
		  CGPROGRAM
		  #pragma vertex vert
		  #pragma fragment frag
		  
		  #include "UnityCG.cginc"
		  
		  // the model*view matrix of the last frame
		  fixed _extraMask;
		  struct v2f {
			   float4 position : SV_POSITION;
		  };
		  
		  v2f vert(appdata_base v )
		  {
			   v2f o;

			   o.position = mul( UNITY_MATRIX_MVP, v.vertex + fixed4(v.normal,0) * _extraMask);
			   
			   return o;
		  }
		  
		  float4 frag( v2f i ) : COLOR
		  {
			   return float4( 1, 0, 0, 0 );
		  }
	  
	  ENDCG
	  }
 }
 
}