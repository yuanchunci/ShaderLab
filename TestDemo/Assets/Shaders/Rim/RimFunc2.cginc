fixed3 MyUnpackNormal(fixed3 packednormal)
{
	fixed3 ret = 2 * packednormal - 1;
	ret.z = 1.0 - 0.5 * dot(packednormal.xy, packednormal.xy);
	return ret;
}

v2f vert(app_data input) 
{
	v2f output;

	fixed3x3 modelMatrix = _Object2World;
	fixed3x3 modelMatrixInverse = _World2Object; 
	fixed3 normalDirection = normalize(mul(input.normal, modelMatrixInverse)); 
	fixed attenuation = 1.0; // no attenuation
	fixed3 ambientLighting = ShadeSH9 (fixed4(normalDirection,1.0)) * _ambientscale;
	output.tex = input.texcoord;
	output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
	output.diffuse = ambientLighting;
	output.posWorld = mul(modelMatrix, input.vertex.xyz);
	output.normalWorld = normalDirection;
#ifdef MY_NORMAL
	output.tangentWorld = normalize(mul(modelMatrix, input.tangent.xyz));
    output.binormalWorld = normalize(cross(output.normalWorld, output.tangentWorld) * input.tangent.w);
#endif
	return output;
}

fixed4 frag(v2f input) : COLOR
{
	fixed4 finalColor = (0,0,0,0);
	fixed4 diffuseColor = tex2D(_basetexture, input.tex) * _color;
#ifdef MY_NORMAL
	fixed3 normal = MyUnpackNormal(tex2D(_BumpMap, input.tex));
	fixed3x3 local2WorldTranspose = fixed3x3(
									input.tangentWorld, 
									input.binormalWorld, 
									input.normalWorld);
	fixed3 normalDirection = normalize(mul(normal, local2WorldTranspose));
#else
	fixed3 normalDirection = normalize(input.normalWorld);
#endif
	
	input.cap.xy = mul((fixed3x3)UNITY_MATRIX_V, normalDirection) * 0.5 + 0.5;
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
//	finalColor.rgb = diffuseColor.rgb;
	finalColor.rgb = diffuse;
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
	fixed3 specMask = tex2D(_SpecMap, input.tex);
	half3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld);
	half3 halfDir = normalize(-_LightDir + viewDirection);
	fixed hasSpec = max(0, dot(-_LightDir, normalDirection));
	fixed spec = pow(max(0,dot(halfDir, normalDirection)), _Shininess * 128);
//	fixed spec = pow(max(0,dot(halfDir, normalDirection)), dot(_LuminateVector, fixed4(diffuseColor.rgb,1)) * _Shininess);
	spec *= specMask.r;
	finalColor.rgb += spec * hasSpec * _LuminateVector.w;
//	finalColor.rgb = dot(_LuminateVector, fixed4(diffuseColor.rgb,1));
#endif
	finalColor.rgb *= diffuseColor.rgb;
#ifdef GAMMA_ON
	finalColor.rgb = sqrt(finalColor.rgb);
#endif
#ifdef FLASH_COLOR
	finalColor = lerp(finalColor, _flashColor, _flashValue);
#endif
	return finalColor;
}