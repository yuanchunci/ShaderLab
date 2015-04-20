Shader "Custom/3TextureMobileDota Probe" {
	Properties {
		_basetexture("Diffuse (RGB) Self-Illumination (A)", 2D)	= "white" {}
		_normalmap	("Normal (RG) Metalness (B)", 2D) = "bump" {}
		_maskmap2	("Mask 2 (RGBA) ", 2D) = "black" {}
		
		_ambientscale	("Ambient Scale", Float) = 1.0

		_rimlightcolor ("Rim Light Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_rimlightscale ("Rim Light Scale", Float) = 1.0
		_rimlightblendtofull ("Rim Light Blend To Full", Range(0.0, 1.0)) = 0.0
		
		_specularcolor ("Specular Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_specularexponent ("Specular Exponent", Float) = 1.0
		_specularscale ("Specular Scale", Float) = 1.0
		_specularblendtofull ("Specular Blend To Full", Range(0.0, 1.0)) = 0.0
		
		_selfillumblendtofull ("Self-Illumination Blend To Full", Range(0.0, 1.0)) = 0.0
		_alpha ("Alpha ", Range(0,1)) = 1
	}
	SubShader {
	Tags { "RenderType"="Opaque" "BW"="TrueProbes"}
	Pass
	{
		Tags { "LIGHTMODE"="ForwardBase" "Queue"="Geometry" }
		
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest
		#pragma target 3.0
		#include "UnityCG.cginc"
		
		fixed	_ambientscale;
		sampler2D	_basetexture;
		sampler2D	_normalmap;
		sampler2D	_maskmap2;
		fixed	_alpha;
		fixed	_rimlightscale;
		fixed	_rimlightblendtofull;
		fixed3	_rimlightcolor;

		fixed	_selfillumblendtofull;

		fixed	_specularexponent;
		fixed	_specularblendtofull;
		fixed3	_specularcolor;
		fixed	_specularscale;
		fixed4 _LightColor0;
		
		struct app_data
		{
			fixed4 vertex : POSITION;
			fixed3 normal : NORMAL;
			fixed4 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			fixed4 pos : SV_POSITION;
			fixed4 posWorld : TEXCOORD0;
               // position of the vertex (and fragment) in world space 
            fixed4 tex : TEXCOORD1;
            fixed3 WorldNormal : TEXCOORD2;
		};

		v2f vert(app_data input) 
		{
			v2f output;

			fixed4x4 modelMatrix = _Object2World;
			fixed4x4 modelMatrixInverse = _World2Object; 
			output.posWorld = mul(modelMatrix, input.vertex);
			output.tex = input.texcoord;
			output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
			output.WorldNormal = mul( _Object2World, fixed4( input.normal, 0.0 ) ).xyz;
			return output;
		}
 
         fixed4 frag(v2f input) : COLOR
         {
         	fixed4 finalColor = (0,0,0,1);
			fixed4 Mask2 = tex2D(_maskmap2, input.tex.xy);
			fixed4 diffuseColor = tex2D(_basetexture, input.tex.xy);
			fixed4 encodedNormal = tex2D(_normalmap, input.tex.xy);
			fixed3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld.xyz);
			fixed4 lightDirection; // no attenuation
			if (0.0 == _WorldSpaceLightPos0.w) // directional light?
			{
				lightDirection.w = 1.0; // no attenuation
				lightDirection.xyz = normalize(_WorldSpaceLightPos0.xyz);
			} 
			else // point or spot light
			{
				fixed3 vertexToLightSource = _WorldSpaceLightPos0.xyz - input.posWorld.xyz;
				fixed distance = length(vertexToLightSource);
				lightDirection.w = 1.0 / distance; // linear attenuation 
				lightDirection.xyz = normalize(vertexToLightSource);
			}
			fixed NdotL = saturate(dot(input.WorldNormal, lightDirection.xyz));
			fixed3 halfLambert = (0.5 * NdotL + 0.5);
			fixed3 lightColor = _LightColor0.rgb * 1.5;
			fixed3 diffuseReflection = lightDirection.w * lightColor * halfLambert;
			fixed3 reflectionVector = normalize(2 * input.WorldNormal * halfLambert - lightDirection.xyz);
			half3 fresnel = pow(1.0 - saturate(dot(input.WorldNormal, viewDirection)), 5.0);
			fresnel.b = 1.0 - fresnel.b;
			fixed3 specularReflection = lightDirection.w * fresnel.b
										* diffuseReflection
										* _specularcolor.rgb * pow(max(0.0, dot(reflectionVector, 
																			  viewDirection)),
																	Mask2.a * _specularexponent);	
			finalColor.rgb = diffuseColor * (diffuseReflection + ShadeSH9 (float4(input.WorldNormal,1.0)) * _ambientscale );
			fixed3 specular = specularReflection * _specularscale
							* Mask2.r
							* lerp(finalColor.rgb + encodedNormal.r, _specularcolor, Mask2.b) 
							* NdotL
							* lightDirection.w;
			finalColor.rgb += specular;
			fixed3 rimlight = max(Mask2.g, _rimlightblendtofull) * fresnel.r
							 * _rimlightscale
							 * _rimlightcolor
							 * saturate(dot(UNITY_MATRIX_V[1], input.WorldNormal));
			finalColor.rgb += rimlight;
			finalColor.rgb += max (diffuseColor.a, _selfillumblendtofull) * diffuseColor.rgb;
			finalColor.a = saturate(_alpha + specular + rimlight);
			return finalColor;
        }
		ENDCG
	}
	
	Pass
	{
		Tags { "LIGHTMODE"="ForwardAdd" "Queue"="Geometry" }
		Blend One One
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma target 3.0
		#pragma fragmentoption ARB_precision_hint_fastest
		#include "UnityCG.cginc"
		
		fixed	_ambientscale;
		sampler2D	_basetexture;
		sampler2D	_normalmap;
		sampler2D	_maskmap2;
		fixed	_alpha;
		fixed	_rimlightscale;
		fixed	_rimlightblendtofull;
		fixed3	_rimlightcolor;

		fixed	_selfillumblendtofull;

		fixed	_specularexponent;
		fixed	_specularblendtofull;
		fixed3	_specularcolor;
		fixed	_specularscale;
		fixed4 _LightColor0;
		
		struct app_data
		{
			fixed4 vertex : POSITION;
			fixed3 normal : NORMAL;
			fixed4 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			fixed4 pos : SV_POSITION;
			fixed4 posWorld : TEXCOORD0;
               // position of the vertex (and fragment) in world space 
            fixed4 tex : TEXCOORD1;
            fixed3 WorldNormal : TEXCOORD2;
		};

		v2f vert(app_data input) 
		{
			v2f output;

			fixed4x4 modelMatrix = _Object2World;
			fixed4x4 modelMatrixInverse = _World2Object; 
			output.posWorld = mul(modelMatrix, input.vertex);
			output.tex = input.texcoord;
			output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
			output.WorldNormal = mul( _Object2World, fixed4( input.normal, 0.0 ) ).xyz;
			return output;
		}
 
         fixed4 frag(v2f input) : COLOR
         {
         	fixed4 finalColor = (0,0,0,1);
			fixed4 Mask2 = tex2D(_maskmap2, input.tex.xy);
			fixed4 diffuseColor = tex2D(_basetexture, input.tex.xy);
			fixed4 encodedNormal = tex2D(_normalmap, input.tex.xy);
			fixed3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld.xyz);
			fixed4 lightDirection; // no attenuation
			if (0.0 == _WorldSpaceLightPos0.w) // directional light?
			{
				lightDirection.w = 1.0; // no attenuation
				lightDirection.xyz = normalize(_WorldSpaceLightPos0.xyz);
			} 
			else // point or spot light
			{
				fixed3 vertexToLightSource = _WorldSpaceLightPos0.xyz - input.posWorld.xyz;
				fixed distance = length(vertexToLightSource);
				lightDirection.w = 1.0 / distance; // linear attenuation 
				lightDirection.xyz = normalize(vertexToLightSource);
			}
			fixed NdotL = saturate(dot(input.WorldNormal, lightDirection.xyz));
			fixed3 halfLambert = (0.5 * NdotL + 0.5);
			fixed3 lightColor = _LightColor0.rgb * 1.5;
			fixed3 diffuseReflection = lightDirection.w * lightColor * halfLambert;
			fixed3 reflectionVector = normalize(2 * input.WorldNormal * halfLambert - lightDirection.xyz);
			half3 fresnel = pow(1.0 - saturate(dot(input.WorldNormal, viewDirection)), 5.0);
			fresnel.b = 1.0 - fresnel.b;
			fixed3 specularReflection = lightDirection.w * fresnel.b
										* diffuseReflection
										* _specularcolor.rgb * pow(max(0.0, dot(reflectionVector, 
																			  viewDirection)),
																	Mask2.a * _specularexponent);	
			finalColor.rgb = diffuseColor * (diffuseReflection + ShadeSH9 (float4(input.WorldNormal,1.0)) * _ambientscale );
			fixed3 specular = specularReflection * _specularscale
							* Mask2.r
							* lerp(finalColor.rgb + encodedNormal.r, _specularcolor, Mask2.b) 
							* NdotL
							* lightDirection.w;
			finalColor.rgb += specular;
			fixed3 rimlight = max(Mask2.g, _rimlightblendtofull) * fresnel.r
							 * _rimlightscale
							 * _rimlightcolor
							 * saturate(dot(UNITY_MATRIX_V[1], input.WorldNormal));
			finalColor.rgb += rimlight;
			finalColor.rgb += max (diffuseColor.a, _selfillumblendtofull) * diffuseColor.rgb;
			finalColor.a = saturate(_alpha + specular + rimlight);
			return finalColor;
        }
		ENDCG
	}
		
	} 
	FallBack "Diffuse"
}
