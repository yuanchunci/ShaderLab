// Blackfire Studio
// Matthieu Ostertag

#ifndef DOTA_SURFACE_CGINC
#define DOTA_SURFACE_CGINC

void surf(Input IN, inout CustomHeroOutput o) {
	/////////////// Mask1
	o.Mask1 = tex2D(_maskmap1, IN.uv_basetexture);

	/////////////// Mask2
	o.Mask2 = tex2D(_maskmap2, IN.uv_basetexture);

	/////////////// Albedo
	half4 basetexture = tex2D(_basetexture, IN.uv_basetexture);
	o.Albedo = basetexture.rgb;
	#ifdef _GAMMA_SPACE
		o.Albedo = toLinear(o.Albedo);
	#endif

	/////////////// Normals
	o.Normal = UnpackNormal(tex2D(_normalmap, IN.uv_basetexture));
	o.WorldNormal = WorldNormalVector(IN, o.Normal);

	/////////////// Environement
	o.Specular = texCUBE(_envmap, WorldReflectionVector (IN, o.Normal)).rgb;
	#ifdef _LINEAR_SPACE
		o.Specular = toLinear(o.Specular);
	#endif

	/////////////// Alpha
	#if defined (_ALPHA_HARD)
		o.Alpha = basetexture.a;
		clip(basetexture.a - _cutoff);
	#elif defined(_ALPHA_SOFT)
		o.Alpha = basetexture.a;
		clip(-(basetexture.a - _cutoff));
	#elif defined(_ALPHA_TRANSPARENT)
		o.Alpha = _alpha;
	#endif

	/////////////// Self Illumination
	o.Emission = max(o.Mask1.a, _selfillumblendtofull) * o.Albedo;

	/////////////// Detail1
	#ifndef _DETAIL1BLENDMODE_OFF
		half scroll = _detail1scrollangle * _Time;
		half s = sin(scroll);
		half c = cos(scroll);
		half2x2 rotationMatrix = half2x2(c, -s, s, c);
		half2 uv_detail1 = mul(IN.uv_basetexture * _detail1scale, rotationMatrix) + _Time * _detail1scrollrate;
		half3 detail1 = tex2D(_detail1map, uv_detail1);
			
		#ifdef _GAMMA_SPACE
			detail1 = toLinear(detail1);
		#endif
			
		half detail1blendtofull = max(o.Mask1.r, _detail1blendtofull);
		#if defined(_DETAIL1BLENDMODE_ADD)
			detail1 = detail1blendtofull * detail1;
			o.Albedo = Add(o.Albedo, detail1 * _detail1blendfactor);
		#elif defined(_DETAIL1BLENDMODE_SELF_ILLUMINATION)
			detail1 = detail1blendtofull * detail1;
			o.Emission = Add(o.Emission, detail1 * _detail1blendfactor);
		#elif defined(_DETAIL1BLENDMODE_MOD2X)
			detail1 = Mod2x(detail1, o.Albedo, detail1blendtofull);
			o.Albedo = lerp(o.Albedo, detail1, _detail1blendfactor);
		#endif
	#endif
	}

#endif