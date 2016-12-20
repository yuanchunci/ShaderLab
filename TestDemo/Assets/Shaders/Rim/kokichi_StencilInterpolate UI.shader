Shader "kokichi/Hidden/Screen/Stencil Interpolate UI"
{
	SubShader
	{
		Tags
		{
			"Queue" = "Overlay"
			"IgnoreProjector" = "True"
		}
		
		// Linearly interpolate the scene color towoards the shadow color
		Pass
		{
			Stencil
			{
				Ref 10
				Comp NotEqual
			}
			
			Lighting Off
			Cull Off
			ZTest Always
			ZWrite Off
//			Blend SrcAlpha OneMinusSrcAlpha, Zero One
			Blend SrcAlpha OneMinusSrcAlpha
			
			Fog
			{
				Mode Off
			}
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "kokichi_StencilScreen.cginc"
			ENDCG
		}
	}
}