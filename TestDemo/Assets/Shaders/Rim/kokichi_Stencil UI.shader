Shader "kokichi/Hidden/Stencil UI"
{
	Properties
	{
	}
	
	SubShader
	{
		Tags { "Queue" = "Transparent" }
		Pass
		{
			Name "PLANAR_SHADOW"
			Offset -1.0, -2.0 			
			Stencil
			{
				Ref 10
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			
			Lighting Off
			ZWrite Off
			Blend Zero One
			Cull Off
			Fog
			{
				Mode Off
			}
 
	         CGPROGRAM
	 		
	         #pragma vertex vert 
	         #pragma fragment frag
	 
	         #include "UnityCG.cginc"
	 
	         // User-specified uniforms
	         uniform fixed4 _ShadowColor;
	 
	         fixed4 vert(fixed4 vertexPos : POSITION) : SV_POSITION
	         {
	            return mul(UNITY_MATRIX_MVP, vertexPos);
	         }
	 
	         fixed4 frag(void) : COLOR 
	         {
	            return _ShadowColor;
	         }
			ENDCG
		}
		
	}
}
