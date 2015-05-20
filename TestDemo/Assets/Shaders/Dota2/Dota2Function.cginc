// kokichi88
void diffuseLighting(fixed3 diffuseReflection, v2f input, inout fixed3 finalDiffuse)
{
	#ifdef ONE_LIGHT
		finalDiffuse = (diffuseReflection + UNITY_LIGHTMODEL_AMBIENT.rgb * _ambientscale );
	#elif defined(LIGHT_PROBES)
		finalDiffuse = (ShadeSH9 (float4(input.normalWorld,1.0)) * _ambientscale );
	#else
		finalDiffuse = (diffuseReflection + ShadeSH9 (float4(input.normalWorld,1.0)) * _ambientscale );
	#endif
}

void specularLighting(fixed3 V, fixed3 N, fixed3 L, fixed NdotL, fixed3 lightColor, fixed specularExponentByMask, inout fixed3 finalSpecular)
{
	fixed3 R = reflect( V, N ); // No half-vector so this is consistent in look with ps2.0
	fixed RdotL = saturate( dot( L, -R ) );
	fixed3 SpecularLighting = 0.0;
	specularExponentByMask *= _specularexponent;
	fixed flSpecularIntensity = NdotL * pow( RdotL, specularExponentByMask );
	SpecularLighting = fixed3( flSpecularIntensity);
	SpecularLighting *= lightColor;
	finalSpecular += SpecularLighting; 
}

v2f vert(app_data input) 
{
	v2f output;

	fixed3x3 modelMatrix = (fixed3x3)_Object2World;
	fixed3x3 modelMatrixInverse = (fixed3x3)_World2Object; 
	output.tangentWorld = normalize(mul(modelMatrix, input.tangent.xyz));
	output.normalWorld = normalize(mul(input.normal, modelMatrixInverse));
	output.binormalWorld = normalize(cross(output.normalWorld, output.tangentWorld) * input.tangent.w); 
	output.posWorld = mul(_Object2World, input.vertex);
	output.tex = input.texcoord;
	output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
	return output;
}

fixed4 frag(v2f input) : COLOR
{
	fixed4 finalColor = (0,0,0,1);
	fixed4 Mask2 = tex2D(_maskmap2, input.tex.xy);
	fixed4 diffuseColor = tex2D(_basetexture, input.tex.xy);
	fixed4 encodedNormal = tex2D(_normalmap, input.tex.xy);
	#if defined(HUE) && defined(SIMPLE)
		if(encodedNormal.a > 0)
			diffuseColor.rgb = simple_low_shift_col(diffuseColor, _HueShift);
	#elif defined(HUE)
		fixed3 shift = fixed3(_HueShift, _Sat, _Val);  
		if(encodedNormal.a > 0)
			diffuseColor.rgb = low_shift_col(diffuseColor, shift);
	#endif
	diffuseColor.rgb = toLinear(diffuseColor.rgb);
	
	fixed metalnessMask = encodedNormal.b;
	fixed specularMask = Mask2.r;
	fixed rimMask = Mask2.g;
	fixed tintByBaseMask = Mask2.b;
	fixed specularExponentByMask = Mask2.a;
	fixed3 normalDirection  = getNormal(encodedNormal, input.tangentWorld, 
														input.binormalWorld, 
														input.normalWorld);
	fixed3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld.xyz);
	#ifndef LIGHT_PROBES
		fixed4 lightDirection = getLightDirAndAtten(input);
		fixed NdotL = (dot(normalDirection, lightDirection.xyz));
		fixed3 halfLambert = (0.5 * NdotL + 0.5);
		fixed3 lightColor = _LightColor0.rgb * 1.5;
		fixed3 diffuseReflection = lightDirection.w * lightColor * halfLambert;
		fixed3 reflectionVector = normalize(2 * normalDirection * NdotL - lightDirection.xyz);
	#endif
	fixed3 fresnel = Fresnel(normalDirection, viewDirection, 5.0);
	fresnel.b = 1.0 - fresnel.b;
//	fresnel.b = max(fresnel.b, metalnessMask);
	fixed3 finalDiffuse = 0;
	fixed3 finalSpecular = 0;
	#ifdef LIGHT_PROBES
		diffuseLighting(0, input, finalDiffuse);
		fixed3 cSpecular = Mask2.r * _specularcolor.rgb * fresnel.b
						 * saturate(dot(UNITY_MATRIX_V[1], normalDirection));
	#else
		diffuseLighting(diffuseReflection, input, finalDiffuse);
		specularLighting(viewDirection, normalDirection, lightDirection.xyz, NdotL, lightColor, specularExponentByMask, finalSpecular);
		fixed3 cSpecular = finalSpecular * _specularscale;
		cSpecular *= lightDirection.w * _specularscale * specularMask;
		fixed3 specularTint = lerp(diffuseColor, _specularcolor.rgb, tintByBaseMask);
		cSpecular *= specularTint * fresnel.b;
	#endif
	
	finalColor.rgb = finalDiffuse * diffuseColor.rgb;
	
	finalColor.rgb += cSpecular;
	finalColor.rgb = lerp( finalColor.rgb, cSpecular, metalnessMask );
	
	#if defined(SIMPLE) || defined(LIGHT_PROBES)
		fixed3 rimlight = rimMask  * fresnel.r
							* _rimlightcolor
						 	* saturate(dot(fixed3(0,1,0), normalDirection));
	#else
		fixed3 rimlight = max(rimMask, _rimlightblendtofull) * fresnel.r
					 		* _rimlightscale
					 		* _rimlightcolor
					 		* saturate(dot(fixed3(0,1,0), normalDirection));
	#endif
	rimlight = getRimLight(rimlight) * ( 1.0 - metalnessMask);
	finalColor.rgb += rimlight;
	
	#if defined(SIMPLE) || defined(LIGHT_PROBES)
		finalColor.rgb += diffuseColor.a * diffuseColor.rgb;
	#else
		finalColor.rgb += max (diffuseColor.a, _selfillumblendtofull) * diffuseColor.rgb;
	#endif
	
	#if defined(TRANSPARENT)
		finalColor.a = saturate (_alpha + cSpecular + rimlight);
	#else
		finalColor.a = 1;
	#endif
	return fixed4(toGamma(finalColor.rgb), finalColor.a);
//	return finalColor;
}

