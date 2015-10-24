
Shader "kokichi/Environment/Blinking GodRays" {

Properties {
	_MainTex ("Base texture", 2D) = "white" {}
	_FadeOutDistNear ("Near fadeout dist", float) = 10	
	_FadeOutDistFar ("Far fadeout dist", float) = 10000	
	_Multiplier("Color multiplier", float) = 1
	_Bias("Bias",float) = 0
	_TimeOnDuration("ON duration",float) = 0.5
	_BlinkingTimeOffsScale("Blinking time offset scale (seconds)",float) = 5
	_NoiseAmount("Noise amount (when zero, pulse wave is used)", Range(0,0.5)) = 0
	_SizeGrowStartDist("Size grow start dist",float) = 5
	_SizeGrowEndDist("Size grow end dist",float) = 50
	_MaxGrowSize("Max grow size",float) = 2.5
	_Color("Color", Color) = (1,1,1,1)
}

	
SubShader {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend One OneMinusSrcColor
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
	
	LOD 100
	
	CGINCLUDE	
	#include "UnityCG.cginc"
	sampler2D _MainTex;
	
	fixed _FadeOutDistNear;
	fixed _FadeOutDistFar;
	fixed _Multiplier;
	fixed	_Bias;
	fixed _TimeOnDuration;
	fixed _BlinkingTimeOffsScale;
	fixed _NoiseAmount;
	fixed4 _Color;
	fixed _SizeGrowStartDist;
	fixed _SizeGrowEndDist;
	fixed _MaxGrowSize;
	
	struct v2f {
		fixed4	pos	: SV_POSITION;
		fixed2	uv		: TEXCOORD0;
		fixed4	color	: TEXCOORD1;
	};

	
	v2f vert (appdata_full v)
	{
		v2f 		o;
		
		fixed		time 			= _Time.y + _BlinkingTimeOffsScale * v.vertex.x;		
		fixed3	viewPos		= mul(UNITY_MATRIX_MV,v.vertex);
		fixed		dist			= length(viewPos);
		fixed		nfadeout	= saturate(dist / _FadeOutDistNear);
		fixed		ffadeout	= 1 - saturate(max(dist - _FadeOutDistFar,0) * 0.2);
		fixed		noiseTime	= time *  (6.2831853f / _TimeOnDuration);
		fixed		noise			= (sin(noiseTime) * (0.5f * cos(noiseTime * 0.6366f + 56.7272f) + 0.5f));
		fixed		noiseWave	= _NoiseAmount * noise + (1 - _NoiseAmount);	
		fixed wave = noiseWave;
		fixed		distScale	= min(max(dist - _SizeGrowStartDist,0) / _SizeGrowEndDist,1);
		distScale = _MaxGrowSize * v.color.a;
		
		wave += _Bias;
		ffadeout *= ffadeout;
		
		nfadeout *= nfadeout;
		nfadeout *= nfadeout;
		
		nfadeout *= ffadeout;
		o.uv		= v.texcoord.xy;
		o.pos	= mul(UNITY_MATRIX_MVP, v.vertex + fixed4(distScale * v.normal,0));
		o.color	= nfadeout * _Color * _Multiplier * wave;
						
		return o;
	}
	ENDCG


	Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest		
		fixed4 frag (v2f i) : COLOR
		{		
			return tex2D (_MainTex, i.uv.xy) * i.color;
		}
		ENDCG 
	}	
}


}

