Shader "Hidden/RenderDepth" {
	Properties {
	}
	SubShader {
	Pass {
			Cull Front
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct v2f {
				float4 pos : POSITION;
				float4 depth : TEXCOORD0;
			};

			v2f vert( appdata_full v )
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.depth = float4( o.pos.z / o.pos.w, 1, 1, 1 );
				return o;
			}

			half4 frag( v2f i ) : COLOR
			{
				//float decodedDepth = DecodeFloatFromRGBA( i.depth );
				return half4( EncodeFloatRGBA( i.depth.r ) );
			}

			ENDCG
		}
	}
}
