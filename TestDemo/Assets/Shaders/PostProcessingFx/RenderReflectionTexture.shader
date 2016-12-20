Shader "kokichi/Hidden/PostFX/RenderReflectionTexture" {
 Properties {
 	_MainTex ("Base (RGB)", 2D) = "white" {}
 }
 SubShader {
	  Tags { "RenderType"="Opaque+1" }
//		  ZWrite Off
	  Cull Off
//	  Stencil
//		{
//			Ref 100
//			Comp Equal
//			Pass IncrSat
//		}
	  Pass {
		  CGPROGRAM
		  #pragma vertex vert
		  #pragma fragment frag
		  #include "UnityCG.cginc"
		  
		  struct v2f {
			   float4 position : SV_POSITION;
			   float2 uv : TEXCOORD0;
		  };
		  sampler2D _MainTex;
	      uniform float4x4 _World2Receiver; // transformation from 
												// world coordinates to the coordinate system of the plane
	            
	  	 v2f vert(appdata_base v )
		  {
				v2f o;
				float4 worldPos = mul(_Object2World, v.vertex);
				float4 world2ReceiverRow1 = float4(_World2Receiver[1][0], _World2Receiver[1][1], 
											_World2Receiver[1][2], _World2Receiver[1][3]);
				float distanceOfVertex = dot(world2ReceiverRow1, worldPos); 
				float step1 = step(0, distanceOfVertex);
				worldPos.y = -worldPos.y * step1;
				o.position = mul(UNITY_MATRIX_VP, worldPos);
				o.uv = v.texcoord.xy;
			   return o;
		  }
		  
		  float4 frag(v2f IN) : COLOR
		  {
		  	   return tex2D(_MainTex, IN.uv);
//		  	   return float4(0.5);
		  }	  
		 
	  
	  ENDCG
	  }
 }
 
}