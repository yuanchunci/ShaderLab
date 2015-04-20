Shader "Custom/Mobile Shadow Kit/ShadowReceiver" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Main Color", COLOR) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf ShadowLambert vertex:vert

		sampler2D _MainTex;
		sampler2D _ShadowMapTex;
		float4x4 _ShadowProjectionMatrix;
		float _ShadowMapCoverage;


		float4 _Color;

		struct Input {
			float2 uv_MainTex;
			float4 sh;
			float dpth;
			float dpth2;
		};

		struct CustomSurfaceOutput {
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Specular;
			half Gloss;
			half Alpha;
			half Shade;
		};

		half4 LightingShadowLambert (CustomSurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = saturate( dot (s.Normal, lightDir) ) * s.Shade;
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * ( NdotL * atten * 2 );
			c.a = s.Alpha;
			return c;
		}

		void vert (inout appdata_full v, out Input o) {
			o.sh = mul( _Object2World, v.vertex );
			o.sh = mul( _ShadowProjectionMatrix, o.sh );
			o.dpth = ( o.sh.z / o.sh.w );
			
			float4 vert = mul( UNITY_MATRIX_MVP, v.vertex );
			o.dpth2 = vert.z;
		}

		half sampleShadowmap( float2 uv, float depth )
		{
			half4 enc = tex2D (_ShadowMapTex, uv);
			float shD = DecodeFloatRGBA( enc );
			return 1.0 - step(shD, depth);
		}

		void surf (Input IN, inout CustomSurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);

			o.Albedo = c.rgb * _Color;
			float mult = step(_ShadowMapCoverage, IN.dpth2);
			o.Shade = max( sampleShadowmap( IN.sh.xy, IN.dpth ), mult );
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}