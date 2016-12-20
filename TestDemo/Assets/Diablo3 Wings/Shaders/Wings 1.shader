Shader "kokichi/Fx/Wings" {
	Properties {
		_MainTex("Wave", 2D) = "white" {}
		_WaveAlpha("WaveAlpha", 2D) = "white" {}
		_Mask1("Mask1", 2D) = "white" {}
		_Pattern1("Pattern1", 2D) = "white" {}
	}
 
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		
		Pass {
			Cull Off
			ZWrite Off // dont write to z-buff to render xray color only

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag
		
			uniform	sampler2D _MainTex;
			uniform	sampler2D _WaveAlpha;
			uniform	sampler2D _Mask1;
			uniform	sampler2D _Pattern1;
			uniform	fixed4 _MainTex_ST;
			struct app_data
			{
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};
		
			struct v2f
			{
				fixed4 pos: SV_POSITION;
				fixed4 uv: TEXCOORD0;
			}; 
			
			v2f vert(app_data input) 
			{
				v2f output;
				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				output.uv.xy = TRANSFORM_TEX(input.texcoord,_MainTex);
				output.uv.zw = input.texcoord.xy;
				return output;
			}
			
			fixed4 frag(v2f i) :COLOR {
				fixed4 c = tex2D(_MainTex, i.uv.xy);
				fixed mask1 = tex2D(_Mask1, i.uv.zw).r;
				fixed4 pattern1 = tex2D(_Pattern1, i.uv.zw);
				fixed alpha = tex2D(_WaveAlpha, i.uv.xy).r;
				c.a *= alpha;
				pattern1 *= mask1;
				return c * pattern1 * 2;
//				return c  ;
			}
			ENDCG
		}
	 
	}
}