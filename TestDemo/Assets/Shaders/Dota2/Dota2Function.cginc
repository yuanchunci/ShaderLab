// kokichi88

v2f vert(app_data input) 
{
	v2f output;

	fixed3x3 modelMatrix = _Object2World;
	fixed3x3 modelMatrixInverse = _World2Object; 
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
	
	fixed3 localCoords = getLocalCoords(encodedNormal);
	fixed3x3 local2WorldTranspose = fixed3x3(
									input.tangentWorld, 
									input.binormalWorld, 
									input.normalWorld);
	fixed3 normalDirection = normalize(mul(localCoords, local2WorldTranspose));
	fixed3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld.xyz);
	#ifndef LIGHT_PROBES
		fixed4 lightDirection = getLightDirAndAtten(input);
		fixed NdotL = (dot(normalDirection, lightDirection.xyz));
		fixed3 halfLambert = (0.5 * NdotL + 0.5);
		fixed3 lightColor = _LightColor0.rgb * 1.5;
		fixed3 diffuseReflection = lightDirection.w * lightColor * halfLambert;
		fixed3 reflectionVector = normalize(2 * normalDirection * NdotL - lightDirection.xyz);
	#endif
	half3 fresnel = pow(1.0 - saturate(dot(normalDirection, viewDirection)), 5.0);
	fresnel.b = 1.0 - fresnel.b;
	#ifdef LIGHT_PROBES
		// do nothing
	#elif defined(SIMPLE)
		fixed3 specularReflection = lightDirection.w * fresnel.b
									* lightColor
									* _specularcolor.rgb * pow(max(0.0, dot(reflectionVector, 
																		  viewDirection)),
																Mask2.a);
	#else
		fixed3 specularReflection = lightDirection.w * fresnel.b
									* lightColor
									* _specularcolor.rgb * pow(max(0.0, dot(reflectionVector, 
																		  viewDirection)),
																Mask2.a * _specularexponent);	
	#endif
	#ifdef ONE_LIGHT
		finalColor.rgb = diffuseColor * (diffuseReflection + UNITY_LIGHTMODEL_AMBIENT.rgb * _ambientscale );
	#elif defined(LIGHT_PROBES)
		finalColor.rgb = diffuseColor * (ShadeSH9 (float4(input.normalWorld,1.0)) * _ambientscale );
	#else
		finalColor.rgb = diffuseColor * (diffuseReflection + ShadeSH9 (float4(input.normalWorld,1.0)) * _ambientscale );
	#endif
	
	Mask2.r = toLinear(Mask2.r);
	
	#ifdef LIGHT_PROBES
		fixed3 specular = Mask2.r * _specularcolor.rgb * fresnel.b
						 * saturate(dot(UNITY_MATRIX_V[1], input.normalWorld));
	#elif defined(SIMPLE)
		fixed3 specular = specularReflection
						* Mask2.r
						* lerp(finalColor.rgb + encodedNormal.b, _specularcolor, Mask2.b) 
						* NdotL
						* lightDirection.w;
	#else
		fixed3 specular = specularReflection * _specularscale
						* Mask2.r
						* lerp(finalColor.rgb + encodedNormal.b, _specularcolor, Mask2.b) 
						* NdotL
						* lightDirection.w;
	#endif
	
	finalColor.rgb += specular;
	finalColor.rgb = lerp(finalColor.rgb, specular, encodedNormal.b);
	
	#if defined(SIMPLE) || defined(LIGHT_PROBES)
		fixed3 rimlight = Mask2.g * _rimlightcolor * fresnel.r
						 * saturate(dot(UNITY_MATRIX_V[1], input.normalWorld));
	#else
		fixed3 rimlight = max(Mask2.g, _rimlightblendtofull) * fresnel.r
					 * _rimlightscale
					 * _rimlightcolor
					 * saturate(dot(UNITY_MATRIX_V[1], input.normalWorld));
	#endif
	rimlight = getRimLight(rimlight);
	finalColor.rgb += rimlight;
	
	#if defined(SIMPLE) || defined(LIGHT_PROBES)
		finalColor.rgb += diffuseColor.a * diffuseColor.rgb;
	#else
		finalColor.rgb += max (diffuseColor.a, _selfillumblendtofull) * diffuseColor.rgb;
	#endif
	
	#if defined(TRANSPARENT)
		finalColor.a = saturate (_alpha + specular + rimlight);
	#else
		finalColor.a = 1;
	#endif
	return finalColor;
}

