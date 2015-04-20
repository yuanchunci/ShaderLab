// Blackfire Studio
// Matthieu Ostertag

#ifndef DOTA_LIGHTING_CGINC
#define DOTA_LIGHTING_CGINC
	

half4 LightingCustomHero(CustomHeroOutput o, half3 lightDir, half3 viewDir, half atten) {
	half4 color = half4(0.0, 0.0, 0.0, 0.0);
	
	#ifndef USING_DIRECTIONAL_LIGHT
    	lightDir = normalize(lightDir);
    #endif
    viewDir = normalize(viewDir);
  	
  	/////////////// Useful stuff
	half NdotL		= saturate(dot(o.Normal, lightDir));
	
	/////////////// Light color
	half3 lightColor = _LightColor0.rgb * 2.0;
	
	/////////////// Shadows
	half attenuation = atten;
	if (0.0 != _WorldSpaceLightPos0.w)
	{ attenuation = atten * NdotL; }
	
	/////////////// Half Lambert
	half halfLambert = NdotL * 0.5 + 0.5;
//	halfLambert = lightColor * halfLambert * atten;
	
	/////////////// Fresnel Warp and Fresnel
	half3 fresnel = pow(1.0 - saturate(dot(o.Normal, viewDir)), 5.0);
	fresnel.b = 1.0 - fresnel.b;
	fresnel = lerp(fresnel, tex2D(_fresnelwarp, half2(saturate(dot(o.Normal, viewDir)), 0)), _fresnelwarpblendtonone);
	
	/////////////// Diffuse lighting
	half3 diffuselighting = half3(1.0, 1.0, 1.0);
	/////////////// Diffuse warp
	#ifndef _SIMPLE
		half3 diffusewarp = tex2D(_diffusewarp, half2(halfLambert, halfLambert));
		diffuselighting = lerp(half3(halfLambert, halfLambert, halfLambert), diffusewarp, max(o.Mask1.g, _diffusewarpblendtofull));
	#else
		diffuselighting = halfLambert;
	#endif
	diffuselighting *= lightColor;
	diffuselighting *= attenuation;
	// Spherical Harmonics and Ambient Light
	half3 sphericalharmonics = ShadeSH9(float4(o.WorldNormal, 1.0));
	if (0.0 != _WorldSpaceLightPos0.w)	// This is a point light
	{
		#ifndef UNITY_PASS_FORWARDBASE
			sphericalharmonics = 0;
		#endif
	}
	diffuselighting += sphericalharmonics * _ambientscale;
	
	/////////////// Specular lighting
	/////////////// Specular warp
	half3 reflectionVector = normalize(2.0 * o.Normal * halfLambert - lightDir);
	half r = max(0, dot(reflectionVector, viewDir));
	half3 specularlighting = pow(r, o.Mask2.a * _specularexponent);
	#ifndef _SIMPLE
		half3 specularlightingwarp = tex2D(_specularwarp, half2(pow(r, 1), 1.0 - o.Mask2.a));
		specularlighting = lerp(specularlighting, specularlightingwarp, _specularwarpintensity) * lightColor;
	#else
		specularlighting = specularlighting * lightColor;
	#endif
	
	/////////////// Fresnel Color Warp
	#ifndef _SIMPLE
		o.Albedo = lerp(o.Albedo, tex3D(_fresnelcolorwarp, o.Albedo), o.Mask2.g * fresnel.g * _fresnelcolorwarpblendtonone);
	#endif
	
	/////////////// Diffuse
	/////////////// Color Warp
	#ifndef _SIMPLE
		half3 diffuse = lerp(o.Albedo, tex3D(_colorwarp, o.Albedo), _colorwarpblendtonone);
	#else
		half3 diffuse = o.Albedo;
	#endif
	diffuse *= diffuselighting;
	color.rgb = diffuse;
	
	/////////////// Specular
	half3 specular = specularlighting * _specularscale;
	#ifdef _GAMMA_SPACE
		o.Mask2.r = toLinear(o.Mask2.r);
	#endif
	specular *= max(o.Mask2.r, _specularblendtofull);
	/////////////// Tint by Color and Metalness
	specular *= lerp(color.rgb + o.Mask1.b, _specularcolor, o.Mask2.b)
				* fresnel.b
				* NdotL;
	specular *= attenuation;
	color.rgb += specular;
	
	/////////////// Metalness
	half3 metalness = lerp(color.rgb, specular, o.Mask1.b);
	color.rgb = metalness;
	
	/////////////// Rim Light
	half3 rimlight = max(o.Mask2.g, _rimlightblendtofull)
						 * fresnel.r
						 * _rimlightscale
						 * _rimlightcolor
						 * saturate(dot(UNITY_MATRIX_V[1], o.WorldNormal));
	if (0.0 != _WorldSpaceLightPos0.w)
	{ rimlight *= atten; }
	color.rgb += rimlight;
	
	/////////////// Environement
	half3 environment = lerp(o.Specular * _envmapintensity * o.Mask2.r, o.Specular * _envmapintensity * o.Mask1.b, _maskenvbymetalness);
	if (0.0 != _WorldSpaceLightPos0.w)
	{
		#ifndef UNITY_PASS_FORWARDBASE
			environment *= attenuation;
		#endif
	}
	color.rgb += environment;
	
	/////////////// Alpha
	// TODO
	#if defined (_ALPHA_SOFT) || defined (_ALPHA_HARD)
		color.a = o.Alpha;
	#elif defined (_ALPHA_TRANSPARENT)
		color.a = saturate(o.Alpha + specular + rimlight + environment);
	#else
		color.a = 1.0;
	#endif
	
	#ifdef _GAMMA_SPACE
		color.rgb = toGamma(color.rgb);
	#endif
	return color;
}	

#endif