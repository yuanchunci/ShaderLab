

v2f vert(app_data input) 
{
	v2f output;

	fixed3x3 modelMatrix = _Object2World;
	fixed3x3 modelMatrixInverse = _World2Object; 
	
	fixed3 normalDirection = normalize(mul(input.normal, modelMatrixInverse)); 
	fixed attenuation = 1.0; // no attenuation
	fixed3 ambientLighting = ShadeSH9 (fixed4(normalDirection,1.0)) * _ambientscale;
//	fixed3 lightDirection = normalize(_WorldSpaceLightPos0.xyz); 
//	fixed NdotL = (dot(normalDirection, lightDirection));
//	fixed halfLambert = (0.5 * NdotL + 0.5);
	#ifdef TOON_RAMP
		output.cap = halfLambert;
		fixed3 diffuseReflection = ambientLighting;
	#elif defined(MAT_CAP)
		half2 capCoord ;
		capCoord.x = dot(UNITY_MATRIX_IT_MV[0].xyz,normalDirection);
		capCoord.y = dot(UNITY_MATRIX_IT_MV[1].xyz,normalDirection);
		output.cap = capCoord.xy * 0.5 + 0.5;
//		fixed3 lightColor = _LightColor0.rgb * 2;
//		fixed3 diffuseReflection = attenuation * lightColor * halfLambert;
		fixed3 diffuseReflection = ambientLighting;
	#else
//		fixed3 lightColor = _LightColor0.rgb * 2;
//		fixed3 diffuseReflection = attenuation * lightColor * halfLambert;
		fixed3 diffuseReflection = ambientLighting;
	#endif
	output.tex = input.texcoord;
#ifdef REFLECTIVE
	fixed4 worldPos = mul(_Object2World, input.vertex);
	float4 world2ReceiverRow1 = float4(_World2Receiver[1][0], _World2Receiver[1][1], 
	               									_World2Receiver[1][2], _World2Receiver[1][3]);
    float distanceOfVertex = dot(world2ReceiverRow1, worldPos); 
    float step1 = step(0, distanceOfVertex);
    worldPos.y = -step1 * distanceOfVertex;
	output.pos = mul(UNITY_MATRIX_VP, worldPos);
#else
	output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
#endif
	output.diffuse = diffuseReflection;
#ifdef RIM_LIGHT
	#ifndef MAT_CAP
		fixed rim = 1.0f - saturate( dot(normalize(ObjSpaceViewDir(input.vertex)), input.normal) );
		fixed3 rimlight = (_rimlightcolor.rgb * pow(rim, _rimlightpower));
		if (0.0 != _WorldSpaceLightPos0.w)
		{ rimlight *= attenuation; }
		output.rim = rimlight * _rimlightscale;
	#endif
#endif
#ifdef SPECULAR
	output.posWorld = mul(modelMatrix, input.vertex.xyz);
	output.normalWorld = normalDirection;
#endif
	return output;
}

fixed4 frag(v2f input) : COLOR
{
	fixed4 finalColor = (0,0,0,0);
	fixed4 diffuseColor = tex2D(_basetexture, input.tex) * _color;
#ifdef HUE
	fixed3 shift = fixed3(_HueShift, _Sat, _Val);  
	diffuseColor.rgb = low_shift_col(diffuseColor, shift);
#endif
#ifdef GAMMA_ON
//	diffuseColor.rgb = pow(diffuseColor.rgb,2.2);
	diffuseColor.rgb = diffuseColor.rgb * diffuseColor.rgb;
#endif
	finalColor.a = diffuseColor.a;
#ifdef ALPHA_CUT
	if(diffuseColor.a < _AlphaCut)
		discard;
#endif
	fixed3 diffuse;
#ifdef TOON_RAMP
	fixed3 ramp = tex2D(_ramp, input.cap.xy);
	diffuse = input.diffuse * _diffusescale + input.diffuse * ramp * _mulscale + ramp * _addscale;
#elif defined(MAT_CAP)
	fixed3 ramp = tex2D(_matcap, input.cap.xy);
	diffuse = input.diffuse * _diffusescale + input.diffuse * ramp * _mulscale + ramp * _addscale;
#endif
	finalColor.rgb = diffuseColor.rgb * diffuse;
//	finalColor.rgb = diffuse;
#ifdef RIM_LIGHT
	#ifndef MAT_CAP
		fixed3 rimlight = input.rim;
		#if defined(RIM_MASK) && !defined(ALPHA_CUT)
			rimlight *= diffuseColor.a;
		#endif
	#else
		fixed3 rimlight = tex2D(_rimTex, input.cap.xy) * _rimlightcolor * _rimlightscale;
	#endif
	finalColor.rgb += rimlight;
#endif

#ifdef SPECULAR
	half3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld);
	half3 halfDir = normalize(-_LightDir + viewDirection);
	fixed hasSpec = step(0, dot(-_LightDir, input.normalWorld));
	fixed spec = pow(max(0,dot(halfDir, input.normalWorld)), _Shininess * 128);
	spec = spec * max(0,dot(_LuminateVector, fixed4(diffuseColor.rgb,1)));
	finalColor.rgb += spec * hasSpec ;
#endif
#ifdef GAMMA_ON
	finalColor.rgb = sqrt(finalColor.rgb);
#endif
#ifdef FLASH_COLOR
	finalColor = lerp(finalColor, _flashColor, _flashValue);
#endif
#ifdef REFLECTIVE
	finalColor.a = 0.6f;
#endif
	return finalColor;
}