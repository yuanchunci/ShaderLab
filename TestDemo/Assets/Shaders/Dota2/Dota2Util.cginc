// kokichi88

fixed3 getLocalCoords(fixed4 encodedNormal)
{
	fixed3 localCoords = fixed3(2.0 * encodedNormal.r - 1.0, 
                2.0 * encodedNormal.g - 1.0, 0.0);
	#if defined(SIMPLE)
		localCoords.z = 1.0 - 0.5 * dot(localCoords, localCoords);
	#else 
    	localCoords.z = sqrt(1.0 - dot(localCoords, localCoords));
	#endif
	return localCoords;
}

fixed3 getNormal(fixed4 encodedNormal, fixed3 tangentWorld, fixed3 binormalWorld, fixed3 normalWorld)
{
	fixed3 localCoords = getLocalCoords(encodedNormal);
	fixed3x3 local2WorldTranspose = fixed3x3(
									tangentWorld, 
									binormalWorld, 
									normalWorld);
	return normalize(mul(localCoords, local2WorldTranspose));
}

fixed4 getLightDirAndAtten(v2f input)
{
	fixed4 lightDirection;
	#if defined(ONE_LIGHT)
		lightDirection.w = 1.0; // no attenuation
		lightDirection.xyz = normalize(_WorldSpaceLightPos0.xyz);
	#else
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
	#endif
	
	return lightDirection;
}

fixed3 getRimLight(fixed3 rimLight)
{
	#ifndef ONE_LIGHT
		if (0.0 != _WorldSpaceLightPos0.w) // directional light?
		{
			rimLight *= _WorldSpaceLightPos0.w;
		} 
	#endif
	return rimLight;
}

fixed Fresnel( fixed3 N, fixed3 V, fixed X )
{
	fixed Fresnel = 1.0 - saturate( dot( N, V ) );
	return pow(Fresnel, X);
}

inline fixed3 toLinear(fixed3 srcColor)
{ 
	return pow(srcColor, 2.2); 
}

inline fixed3 toGamma(fixed3 srcColor)
{ 
	return pow(srcColor, 1 / 2.2); 
}
