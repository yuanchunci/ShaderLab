Shader "kokichi/Hidden/Screen/Stencil Reflation Interpolate"
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
				Ref 1
				Comp Equal
			}
			
			Lighting Off
			Cull Off
			ZTest Always
			ZWrite Off
			Blend One One
//			Blend SrcAlpha OneMinusSrcAlpha
			
			Fog
			{
				Mode Off
			}
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			sampler2D _reflectionTex;
			float4x4 _biasMat;
			struct app_data
			{
				fixed4 vertex : POSITION;
				fixed2 uv : TEXCOORD0;
			};

			struct v2f
			{
				fixed4 position : SV_POSITION;
				fixed2 uv : TEXCOORD0;
			};

			v2f vert(app_data IN)
			{
				v2f OUT;
				
				OUT.position = IN.vertex;
				OUT.uv = IN.uv;
				return OUT;
			}

			float4 frag(v2f IN) : COLOR
			{
				return tex2D(_reflectionTex, IN.uv);
			}
			ENDCG
		}
	}
}