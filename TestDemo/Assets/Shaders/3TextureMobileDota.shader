Shader "Custom/3TextureMobileDota (1 Directional Light)" {
	Properties {
		_basetexture("Diffuse (RGB) Self-Illumination (A)", 2D)	= "white" {}
		_normalmap	("Normal (RG) Metalness (B)", 2D) = "bump" {}
		_maskmap1	("Mask 1 (RGBA) ", 2D) = "black" {}
		
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
		
		_behindwallColor ("Behind Wall Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_Outline ("Outline Width", Float) = 1.0
		_OutlineColor ("Outline Color", Color) = (0.2, 0.2, 0.2, 1)
	}
	SubShader {
	Tags {"Queue"="Geometry+1" "IgnoreProjector"="True"}
	
	UsePass "kokichi/Hidden/XRay Wall/WALL"
    
	Pass
	{
	
		Tags { "LIGHTMODE"="ForwardBase"}
		
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		
		fixed	_ambientscale;
		sampler2D	_basetexture;
		sampler2D	_normalmap;
		sampler2D	_maskmap1;
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
			fixed4 tangent : TANGENT;  
			fixed4 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			fixed4 pos : SV_POSITION;
			fixed4 posWorld : TEXCOORD0;
               // position of the vertex (and fragment) in world space 
            fixed4 tex : TEXCOORD1;
            fixed3 tangentWorld : TEXCOORD2;  
            fixed3 normalWorld : TEXCOORD3;
            fixed3 binormalWorld : TEXCOORD4;
            fixed3 WorldNormal : TEXCOORD5;
		};

		v2f vert(app_data input) 
		{
			v2f output;

			fixed4x4 modelMatrix = _Object2World;
			fixed4x4 modelMatrixInverse = _World2Object; 
			// unity_Scale.w is unnecessary 

			output.tangentWorld = normalize(
			mul(modelMatrix, fixed4(input.tangent.xyz, 0.0)).xyz);
			output.normalWorld = normalize(
			mul(fixed4(input.normal, 0.0), modelMatrixInverse).xyz);
			output.binormalWorld = normalize(
			cross(output.normalWorld, output.tangentWorld) 
			* input.tangent.w); // tangent.w is specific to Unity

			output.posWorld = mul(modelMatrix, input.vertex);
			output.tex = input.texcoord;
			output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
			output.WorldNormal = mul( _Object2World, fixed4( input.normal, 0.0 ) ).xyz;
			return output;
		}
 
         fixed4 frag(v2f input) : COLOR
         {
         	fixed4 finalColor = (0,0,0,1);
			fixed4 Mask1 = tex2D(_maskmap1, input.tex.xy);
         	fixed4 diffuseColor = tex2D(_basetexture, input.tex.xy);
            fixed4 encodedNormal = tex2D(_normalmap, input.tex.xy);
            fixed3 localCoords = fixed3(2.0 * encodedNormal.r - 1.0, 
                2.0 * encodedNormal.g - 1.0, 0.0);
            localCoords.z = 1.0 - 0.5 * dot(localCoords, localCoords);
               // approximation without sqrt:  localCoords.z = 
               // 1.0 - 0.5 * dot(localCoords, localCoords);
 
            fixed3x3 local2WorldTranspose = fixed3x3(
               input.tangentWorld, 
               input.binormalWorld, 
               input.normalWorld);
            fixed3 normalDirection = 
               normalize(mul(localCoords, local2WorldTranspose));
 
            fixed3 viewDirection = normalize(
               _WorldSpaceCameraPos - input.posWorld.xyz);
            fixed3 lightDirection;
            fixed attenuation;
 
 			attenuation = 1.0; // no attenuation
            lightDirection = normalize(_WorldSpaceLightPos0.xyz);
//            if (0.0 == _WorldSpaceLightPos0.w) // directional light?
//            {
//               attenuation = 1.0; // no attenuation
//               lightDirection = normalize(_WorldSpaceLightPos0.xyz);
//            } 
//            else // point or spot light
//            {
//               fixed3 vertexToLightSource = 
//                  _WorldSpaceLightPos0.xyz - input.posWorld.xyz;
//               fixed distance = length(vertexToLightSource);
//               attenuation = 1.0 / distance; // linear attenuation 
//               lightDirection = normalize(vertexToLightSource);
//            }
 
//            fixed3 ambientLighting = 
//               UNITY_LIGHTMODEL_AMBIENT.rgb * _ambientscale;
            half NdotL = saturate(dot(normalDirection, lightDirection));
 			fixed3 halfLambert = (0.5 * NdotL + 0.5);
            fixed3 diffuseReflection = 
               attenuation * _LightColor0.rgb
               * halfLambert;
 
            fixed3 specularReflection;
            fixed3 reflectionVector = normalize(2.0 * normalDirection * halfLambert - lightDirection);
            specularReflection = attenuation * _LightColor0.rgb
                  * _specularcolor.rgb * pow(max(0.0, dot(
                  reflectionVector, 
                  viewDirection)), Mask1.a * _specularexponent);
//            finalColor.rgb = diffuseColor * (diffuseReflection + ambientLighting);
            finalColor.rgb = diffuseColor * diffuseReflection;
            fixed3 specular = specularReflection * _specularscale
            	* Mask1.r
            	* lerp(finalColor.rgb + encodedNormal.r, _specularcolor,  Mask1.b) * NdotL
            	* attenuation;
			finalColor.rgb += specular;
			half3 rimlight = max(Mask1.g, _rimlightblendtofull)
						 * _rimlightscale
						 * _rimlightcolor
						 * saturate(dot(UNITY_MATRIX_V[1], input.WorldNormal));
			if (0.0 != _WorldSpaceLightPos0.w)
			{ rimlight *= attenuation; }
			finalColor.rgb += rimlight;
			finalColor.rgb += max (diffuseColor.a, _selfillumblendtofull) * diffuseColor.rgb;
//			finalColor.rgb = encodedNormal.a;
			finalColor.a = saturate(_alpha + specular + rimlight);
            return finalColor;
         }
		ENDCG
	}
		
	} 
	FallBack "Diffuse"
}
