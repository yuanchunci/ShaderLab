Shader "kokichi/Fx/Scrolling Transperant" {
	Properties {
		_MainTex("MainTexture", 2D) = "white" {}
		_ScrollSpeed ("_ScrollSpeed", Vector) = (1.0, 1.0, 1.0, 1.0)
	}
 
	SubShader {
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Pass {
//			Cull Off
//			ZWrite Off // dont write to z-buff to render xray color only

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
		
			uniform fixed2	_ScrollSpeed;
			uniform	sampler2D _MainTex;
			struct app_data
			{
				fixed4 vertex : POSITION;
				fixed2 texcoord : TEXCOORD0;
			};
		
			struct v2f
			{
				fixed4 pos: SV_POSITION;
				fixed2 uv: TEXCOORD0;
			}; 
			
			v2f vert(app_data input) 
			{
				v2f output;
				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				output.uv = input.texcoord + _ScrollSpeed * _Time.x;
//				output.uv = input.texcoord;
				return output;
			}
			
			fixed4 frag(v2f i) :COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);
				return c;
			}
			ENDCG
		}
	 
	}
}