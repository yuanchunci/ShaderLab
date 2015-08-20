Shader "kokichi/Hidden/PostFX/ShadowReceiver" {
 Properties {
 	_MainTex ("Base (RGB)", 2D) = "white" {}
 	_Color("Main Color", Color) = (1,1,1,1)
 }
 SubShader {
	  Tags { "RenderType"="Opaque" }
	  
	  Pass {
		  CGPROGRAM


		  #pragma vertex vert0
		  #pragma fragment frag0
		  #pragma target 3.0
		  #include "UnityCG.cginc"
		  
		  uniform float4 _Color;
		  uniform fixed _bias;
		  uniform fixed _strength;
		  uniform float4x4 _biasMatrix;
		  uniform float4x4 _depthVP;
		  uniform sampler2D _kkShadowMap;
		  uniform sampler2D _MainTex;
	
		  struct v2f {
			   float4 position : SV_POSITION;
			   float2 uv : TEXCOORD0;
			   float4 shadowCoord : TEXCOORD1;
			   float4 depth : TEXCOORD2;
		  };
		  
		  v2f vert(appdata_base v )
		  {
			   v2f o;
			   o.position = mul(UNITY_MATRIX_MVP, v.vertex);
			   o.shadowCoord = mul(_depthVP, mul(_Object2World, v.vertex));
			   o.depth = DecodeFloatRGBA(EncodeFloatRGBA(o.shadowCoord.z / o.shadowCoord.w));
			   o.shadowCoord = mul(_biasMatrix, o.shadowCoord);
			   o.uv = v.texcoord;
			   return o;
		  }
	
		  half4 frag(v2f IN) : COLOR
		  {
//		  		half depth = DecodeFloatRGBA(tex2D(_kkShadowMap, IN.shadowCoord.xy));
		  		half depth = (tex2D(_kkShadowMap, IN.shadowCoord.xy));
		  		fixed shade =  max(step(IN.depth - _bias, depth), _strength);
		  	    return shade * tex2D(_MainTex, IN.uv) * _Color;
		  }
		  
		  v2f vert0(appdata_base v )
		  {
			   v2f o;
			   o.position = mul(UNITY_MATRIX_MVP, v.vertex);
			   o.shadowCoord = mul(_depthVP, mul(_Object2World, v.vertex));
//			   o.depth = (o.shadowCoord.z / o.shadowCoord.w);
			   o.depth = EncodeFloatRGBA(o.shadowCoord.z / o.shadowCoord.w);
			   o.shadowCoord = mul(_biasMatrix, o.shadowCoord);
			   o.uv = v.texcoord;
			   return o;
		  }
	
		  half4 frag0(v2f IN) : COLOR
		  {
//		  		half depth = DecodeFloatRGBA(tex2D(_kkShadowMap, IN.shadowCoord.xy));
		  		half4 depth = (tex2D(_kkShadowMap, IN.shadowCoord.xy));
		  		fixed shade =  max(step(IN.depth - _bias, depth), _strength);
		  	    return shade * tex2D(_MainTex, IN.uv) * _Color;
		  }
		  
		  half4 frag2(v2f IN) : COLOR
		  {
		  		float4 vTexCoords[9];
		   // Texel size
		   		float fTexelSize = 1.0f / 1024.0f;

		   // Generate the tecture co-ordinates for the specified depth-map size
		   // 4 3 5
		   // 1 0 2
		   // 7 6 8
		   int i = 0;
//		   for (int y = -1; y <= 1; y += 1.0)
//  					for (int x = -1; x <= 1; x += 1.0)
//    					vTexCoords[i++] = IN.shadowCoord + float4(x * fTexelSize, y * fTexelSize,0,0);
			   vTexCoords[0] = IN.shadowCoord;
			   vTexCoords[1] = IN.shadowCoord + float4( -fTexelSize, 0.0f, 0.0f, 0.0f );
			   vTexCoords[2] = IN.shadowCoord + float4(  fTexelSize, 0.0f, 0.0f, 0.0f );
			   vTexCoords[3] = IN.shadowCoord + float4( 0.0f, -fTexelSize, 0.0f, 0.0f );
			   vTexCoords[6] = IN.shadowCoord + float4( 0.0f,  fTexelSize, 0.0f, 0.0f );
			   vTexCoords[4] = IN.shadowCoord + float4( -fTexelSize, -fTexelSize, 0.0f, 0.0f );
			   vTexCoords[5] = IN.shadowCoord + float4(  fTexelSize, -fTexelSize, 0.0f, 0.0f );
			   vTexCoords[7] = IN.shadowCoord + float4( -fTexelSize,  fTexelSize, 0.0f, 0.0f );
			   vTexCoords[8] = IN.shadowCoord + float4(  fTexelSize,  fTexelSize, 0.0f, 0.0f );
			   
			   float fShadowTerms[9];
			   float fShadowTerm = 0.0f;
			   for( int i = 0; i < 9; i++ )
			   {
				  float A = tex2Dproj( _kkShadowMap, vTexCoords[i] ).r;
				  float B = IN.depth - _bias;
//
//				  // Texel is shadowed
				  fShadowTerms[i] = A < B ? 0.0f : 1.0f;
				  fShadowTerm	 += fShadowTerms[i];
			   }
//			   // Get the average
			   fShadowTerm /= 9.0f;
			   fixed shade =  max(fShadowTerm, _strength);
			   return shade * tex2D(_MainTex, IN.uv) * _Color;
		  } 
		  
		  half4 frag3(v2f IN) : COLOR
		  {
		  		float4 vTexCoords[16];
		   // Texel size
		   		float fTexelSize = 1.0f / 1024.0f;

		   // Generate the tecture co-ordinates for the specified depth-map size
		   // 4 3 5
		   // 1 0 2
		   // 7 6 8
		   	int i  = 0;
		   		for (int y = -1.5; y <= 1.5; y += 1.0)
  					for (int x = -1.5; x <= 1.5; x += 1.0)
    					vTexCoords[i++] = IN.shadowCoord + float4(x * fTexelSize, y * fTexelSize,0,0);
//			   vTexCoords[0] = IN.shadowCoord;
//			   vTexCoords[1] = IN.shadowCoord + float4( -fTexelSize, 0.0f, 0.0f, 0.0f );
//			   vTexCoords[2] = IN.shadowCoord + float4(  fTexelSize, 0.0f, 0.0f, 0.0f );
//			   vTexCoords[3] = IN.shadowCoord + float4( 0.0f, -fTexelSize, 0.0f, 0.0f );
//			   vTexCoords[6] = IN.shadowCoord + float4( 0.0f,  fTexelSize, 0.0f, 0.0f );
//			   vTexCoords[4] = IN.shadowCoord + float4( -fTexelSize, -fTexelSize, 0.0f, 0.0f );
//			   vTexCoords[5] = IN.shadowCoord + float4(  fTexelSize, -fTexelSize, 0.0f, 0.0f );
//			   vTexCoords[7] = IN.shadowCoord + float4( -fTexelSize,  fTexelSize, 0.0f, 0.0f );
//			   vTexCoords[8] = IN.shadowCoord + float4(  fTexelSize,  fTexelSize, 0.0f, 0.0f );
			   
			   float fShadowTerms[16];
			   float fShadowTerm = 0.0f;
			   for( int i = 0; i < 16; i++ )
			   {
				  float A = tex2Dproj( _kkShadowMap, vTexCoords[i] ).r;
				  float B = IN.depth - _bias;
//
//				  // Texel is shadowed
				  fShadowTerms[i] = A < B ? 0.0f : 1.0f;
				  fShadowTerm	 += fShadowTerms[i];
			   }
//			   // Get the average
			   fShadowTerm /= 16f;
			   fixed shade =  max(fShadowTerm, _strength);
			   return fShadowTerm * tex2D(_MainTex, IN.uv) * _Color;
		  } 	

	  
	  ENDCG
	  }
 }
 
}