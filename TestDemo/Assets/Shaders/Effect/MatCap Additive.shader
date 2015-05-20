// MatCap Shader, (c) 2013,2014 Jean Moreno

Shader "kokichi/Fx/MatCap/Plain Additive"
{
	Properties
	{
		_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
	}
	
	Subshader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend One OneMinusSrcColor
		Cull Off
		Lighting Off
		ZWrite Off
		
		Pass
		{
			Tags { "LightMode" = "Always" }
			
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"
				
				struct v2f
				{
					fixed4 pos	: SV_POSITION;
					fixed2 cap	: TEXCOORD0;
				};
				
				v2f vert (appdata_base v)
				{
					v2f o;
					o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
					
					fixed3 capCoord = normalize(mul(v.normal, (fixed3x3)_World2Object));
					capCoord = mul((fixed3x3)UNITY_MATRIX_V, capCoord);
					o.cap = capCoord * 0.5 + 0.5;
					
					return o;
				}
				
				uniform fixed4 _Color;
				uniform sampler2D _MatCap;
				
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 mc = tex2D(_MatCap, i.cap);
					
					return _Color * mc * 2.0;
				}
			ENDCG
		}
	}
	
}