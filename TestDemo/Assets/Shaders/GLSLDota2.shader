Shader "Custom/GLSLDota2" {
   Properties {
		_basetexture ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
		_normalmap ("Normal (RGB)", 2D) = "bump" {}
		_maskmap1 ("Mask 1 (RGBA)", 2D) = "black" {}
		_maskmap2 ("Mask 2 (RGBA)", 2D) = "black" {}
		_ambientscale ("Ambient Scale", Float) = 1
		_rimlightcolor ("Rim Light Color", Color) = (1,1,1,1)
		_rimlightscale ("Rim Light Scale", Float) = 1
		_rimlightblendtofull ("Rim Light Blend To Full", Range(0,1)) = 0
		_specularcolor ("Specular Color", Color) = (1,1,1,1)
		_specularexponent ("Specular Exponent", Float) = 1
		_specularscale ("Specular Scale", Float) = 1
		_specularblendtofull ("Specular Blend To Full", Range(0,1)) = 0
		_selfillumblendtofull ("Self-Illumination Blend To Full", Range(0,1)) = 0
   }
   SubShader {
   	LOD 400
 	Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
      Pass {      
         Name "FORWARD"
  		Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
            // pass for ambient light and first light source
 
         GLSLPROGRAM
 
         #ifdef VERTEX
 		
		varying vec3 xlv_TEXCOORD6;
		varying vec3 xlv_TEXCOORD5;
		varying vec3 xlv_TEXCOORD4;
		varying vec4 xlv_TEXCOORD3;
		varying vec4 xlv_TEXCOORD2;
		varying vec4 xlv_TEXCOORD1;
		varying vec2 xlv_TEXCOORD0;
		attribute vec4 TANGENT;
		uniform vec4 _basetexture_ST;
		uniform vec4 unity_Scale;
		uniform mat4 _World2Object;
		uniform mat4 _Object2World;

		uniform highp vec4 _WorldSpaceLightPos0;
		uniform highp vec3 _WorldSpaceCameraPos;
 
         void main()
         {                                
            vec4 tmpvar_1;
			  tmpvar_1.w = 1.0;
			  tmpvar_1.xyz = _WorldSpaceCameraPos;
			  mat3 tmpvar_2;
			  tmpvar_2[0] = _Object2World[0].xyz;
			  tmpvar_2[1] = _Object2World[1].xyz;
			  tmpvar_2[2] = _Object2World[2].xyz;
			  vec3 tmpvar_3;
			  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
			  vec3 tmpvar_4;
			  vec3 tmpvar_5;
			  tmpvar_4 = TANGENT.xyz;
			  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
			  mat3 tmpvar_6;
			  tmpvar_6[0].x = tmpvar_4.x;
			  tmpvar_6[0].y = tmpvar_5.x;
			  tmpvar_6[0].z = gl_Normal.x;
			  tmpvar_6[1].x = tmpvar_4.y;
			  tmpvar_6[1].y = tmpvar_5.y;
			  tmpvar_6[1].z = gl_Normal.y;
			  tmpvar_6[2].x = tmpvar_4.z;
			  tmpvar_6[2].y = tmpvar_5.z;
			  tmpvar_6[2].z = gl_Normal.z;
			  vec4 v_7;
			  v_7.x = _Object2World[0].x;
			  v_7.y = _Object2World[1].x;
			  v_7.z = _Object2World[2].x;
			  v_7.w = _Object2World[3].x;
			  vec4 tmpvar_8;
			  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
			  tmpvar_8.w = tmpvar_3.x;
			  vec4 v_9;
			  v_9.x = _Object2World[0].y;
			  v_9.y = _Object2World[1].y;
			  v_9.z = _Object2World[2].y;
			  v_9.w = _Object2World[3].y;
			  vec4 tmpvar_10;
			  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
			  tmpvar_10.w = tmpvar_3.y;
			  vec4 v_11;
			  v_11.x = _Object2World[0].z;
			  v_11.y = _Object2World[1].z;
			  v_11.z = _Object2World[2].z;
			  v_11.w = _Object2World[3].z;
			  vec4 tmpvar_12;
			  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
			  tmpvar_12.w = tmpvar_3.z;
			  vec4 tmpvar_13;
			  tmpvar_13.w = 1.0;
			  tmpvar_13.xyz = _WorldSpaceCameraPos;
			  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
			  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
			  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
			  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
			  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
			  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
			  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
			  xlv_TEXCOORD6 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
         }
 
         #endif
 
         #ifdef FRAGMENT
		varying vec3 xlv_TEXCOORD6;
		varying vec3 xlv_TEXCOORD5;
		varying vec3 xlv_TEXCOORD4;
		varying vec4 xlv_TEXCOORD3;
		varying vec4 xlv_TEXCOORD2;
		varying vec4 xlv_TEXCOORD1;
		varying vec2 xlv_TEXCOORD0;
		uniform float _specularscale;
		uniform vec3 _specularcolor;
		uniform float _specularblendtofull;
		uniform float _specularexponent;
		uniform float _selfillumblendtofull;
		uniform vec3 _rimlightcolor;
		uniform float _rimlightblendtofull;
		uniform float _rimlightscale;
		uniform sampler2D _maskmap2;
		uniform sampler2D _maskmap1;
		uniform sampler2D _normalmap;
		uniform sampler2D _basetexture;
		uniform float _ambientscale;
		uniform vec4 _LightColor0;
		uniform mat4 unity_MatrixV;
		uniform vec4 unity_SHC;
		uniform vec4 unity_SHBb;
		uniform vec4 unity_SHBg;
		uniform vec4 unity_SHBr;
		uniform vec4 unity_SHAb;
		uniform vec4 unity_SHAg;
		uniform vec4 unity_SHAr;
		uniform highp vec4 _WorldSpaceLightPos0;
		void main()
		{
			vec4 c_1;
			vec3 tmpvar_2;
			tmpvar_2.x = xlv_TEXCOORD1.w;
			tmpvar_2.y = xlv_TEXCOORD2.w;
			tmpvar_2.z = xlv_TEXCOORD3.w;
			vec4 tmpvar_3;
			tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
			vec4 tmpvar_4;
			tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
			vec4 tmpvar_5;
			tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
			vec3 normal_6;
			normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
			normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
			vec3 tmpvar_7;
			tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
			tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
			tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
			vec3 tmpvar_8;
			tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
			tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
			tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
			vec3 tmpvar_10;
			tmpvar_10 = (max (tmpvar_3.w, _selfillumblendtofull) * tmpvar_5.xyz);
			c_1 = vec4(0.0, 0.0, 0.0, 0.0);
			vec3 rimlight_11;
			vec3 fresnel_12;
			float attenuation_13;
			vec4 color_14;
			color_14 = vec4(0.0, 0.0, 0.0, 0.0);
			vec3 tmpvar_15;
			tmpvar_15 = normalize(normalize(xlv_TEXCOORD6));
			float tmpvar_16;
			tmpvar_16 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
			vec3 tmpvar_17;
			tmpvar_17 = (_LightColor0.xyz * 2.0);
			attenuation_13 = 1.0;
			if ((0.0 != _WorldSpaceLightPos0.w)) {
			attenuation_13 = tmpvar_16;
			};
			float tmpvar_18;
			tmpvar_18 = ((tmpvar_16 * 0.5) + 0.5);
			float tmpvar_19;
			tmpvar_19 = pow ((1.0 - clamp (dot (normal_6, tmpvar_15), 0.0, 1.0)), 5.0);
			fresnel_12.xy = vec2(tmpvar_19);
			fresnel_12.z = (1.0 - tmpvar_19);
			vec2 tmpvar_20;
			tmpvar_20.y = 0.0;
			tmpvar_20.x = clamp (dot (normal_6, tmpvar_15), 0.0, 1.0);
			vec3 tmpvar_21;
			tmpvar_21 = fresnel_12;
			vec4 tmpvar_22;
			tmpvar_22.w = 1.0;
			tmpvar_22.xyz = tmpvar_7;
			vec3 x2_23;
			vec3 x1_24;
			x1_24.x = dot (unity_SHAr, tmpvar_22);
			x1_24.y = dot (unity_SHAg, tmpvar_22);
			x1_24.z = dot (unity_SHAb, tmpvar_22);
			vec4 tmpvar_25;
			tmpvar_25 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
			x2_23.x = dot (unity_SHBr, tmpvar_25);
			x2_23.y = dot (unity_SHBg, tmpvar_25);
			x2_23.z = dot (unity_SHBb, tmpvar_25);
			vec3 tmpvar_26;
			tmpvar_26 = (tmpvar_5.xyz * (((vec3(tmpvar_18) * tmpvar_17) * attenuation_13) + (((x1_24 + x2_23) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))) * _ambientscale)));
			vec3 tmpvar_27;
			tmpvar_27 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_18) - xlv_TEXCOORD4)), tmpvar_15)), (tmpvar_4.w * _specularexponent))) * tmpvar_17) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_26 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_21.z) * tmpvar_16)) * attenuation_13);
			color_14.xyz = (tmpvar_26 + tmpvar_27);
			color_14.xyz = mix (color_14.xyz, tmpvar_27, tmpvar_3.zzz);
			vec4 v_28;
			v_28.x = unity_MatrixV[0].y;
			v_28.y = unity_MatrixV[1].y;
			v_28.z = unity_MatrixV[2].y;
			v_28.w = unity_MatrixV[3].y;
			vec4 tmpvar_29;
			tmpvar_29.w = 0.0;
			tmpvar_29.xyz = tmpvar_7;
			vec3 tmpvar_30;
			tmpvar_30 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_21.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_28, tmpvar_29), 0.0, 1.0));
			rimlight_11 = tmpvar_30;
			if ((0.0 != _WorldSpaceLightPos0.w)) {
			rimlight_11 = tmpvar_30;
			};
			color_14.xyz = (color_14.xyz + rimlight_11);
			color_14.w = 1.0;
			c_1.w = color_14.w;
			c_1.xyz = (color_14.xyz + (tmpvar_5.xyz * xlv_TEXCOORD5));
			c_1.xyz = (c_1.xyz + tmpvar_10);
			gl_FragData[0] = c_1;
		}
 
         #endif
 
         ENDGLSL
      }
 
      
   } 
   // The definition of a fallback shader should be commented out 
   // during development:
   // Fallback "Parallax Specular"
}