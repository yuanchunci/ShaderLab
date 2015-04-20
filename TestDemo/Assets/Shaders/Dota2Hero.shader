Shader "Custom/Dota2Hero" {
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
         CGPROGRAM
 
		#pragma vertex vert  
		#pragma fragment frag 
 		#include "UnityCG.cginc" 
       	#pragma target 3.0
		sampler2D _basetexture;
		sampler2D _normalmap;
		sampler2D _maskmap1;
		sampler2D _maskmap2;
		float _ambientscale;
		float4 _rimlightcolor;
		float _rimlightscale;
		float _rimlightblendtofull;
		float4 _specularcolor;
		float _specularexponent;
		float _specularscale;
		float _specularblendtofull;
		float _selfillumblendtofull;
 		float4 _LightColor0;
		struct app_data
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 tangent : TANGENT;  
			float4 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			float4 pos : SV_POSITION;
			float2 tex : TEXCOORD0;
			float4 tex1 : TEXCOORD1;
			float4 tex2 : TEXCOORD2;
			float4 tex3 : TEXCOORD3;
			float3 tex4 : TEXCOORD4;
			float3 tex5 : TEXCOORD5;
			float3 tex6 : TEXCOORD6;
		};

		v2f vert(app_data data) 
		{
			v2f ret;
			float4 tmpvar_1;
			tmpvar_1.w = 1.0;
			tmpvar_1.xyz = _WorldSpaceCameraPos;
			float3x3 tmpvar_2;
			tmpvar_2[0] = _Object2World[0].xyz;
			tmpvar_2[1] = _Object2World[1].xyz;
			tmpvar_2[2] = _Object2World[2].xyz;
			float3 tmpvar_3;
  			tmpvar_3 = mul(tmpvar_2 ,(data.vertex.xyz - (mul(_World2Object , tmpvar_1).xyz * unity_Scale.w)));
  			float3 tmpvar_4;
			float3 tmpvar_5;
			tmpvar_4 = data.tangent.xyz;
			tmpvar_5 = (((data.normal.yzx * data.tangent.zxy) - (data.normal.zxy * data.tangent.yzx)) * data.tangent.w);
			float3x3 tmpvar_6;
			tmpvar_6[0].x = tmpvar_4.x;
			tmpvar_6[0].y = tmpvar_5.x;
			tmpvar_6[0].z = data.normal.x;
			tmpvar_6[1].x = tmpvar_4.y;
			tmpvar_6[1].y = tmpvar_5.y;
			tmpvar_6[1].z = data.normal.y;
			tmpvar_6[2].x = tmpvar_4.z;
			tmpvar_6[2].y = tmpvar_5.z;
			tmpvar_6[2].z = data.normal.z;
			float4 v_7;
			v_7.x = _Object2World[0].x;
			v_7.y = _Object2World[1].x;
			v_7.z = _Object2World[2].x;
			v_7.w = _Object2World[3].x;
			float4 tmpvar_8;
			tmpvar_8.xyz = mul(tmpvar_6 , v_7.xyz);
			tmpvar_8.w = tmpvar_3.x;
			float4 v_9;
			v_9.x = _Object2World[0].y;
			v_9.y = _Object2World[1].y;
			v_9.z = _Object2World[2].y;
			v_9.w = _Object2World[3].y;
			float4 tmpvar_10;
			tmpvar_10.xyz = mul(tmpvar_6 , v_9.xyz);
			tmpvar_10.w = tmpvar_3.y;
			float4 v_11;
			v_11.x = _Object2World[0].z;
			v_11.y = _Object2World[1].z;
			v_11.z = _Object2World[2].z;
			v_11.w = _Object2World[3].z;
			float4 tmpvar_12;
			tmpvar_12.xyz = mul(tmpvar_6 , v_11.xyz);
			tmpvar_12.w = tmpvar_3.z;
			float4 tmpvar_13;
			tmpvar_13.w = 1.0;
			tmpvar_13.xyz = _WorldSpaceCameraPos;
			ret.pos = mul(UNITY_MATRIX_MVP, data.vertex);
			ret.tex = data.texcoord;
			ret.tex1 = (tmpvar_8 * unity_Scale.w);
			ret.tex2 = (tmpvar_10 * unity_Scale.w);
			ret.tex3 = (tmpvar_12 * unity_Scale.w);
			ret.tex4 = mul(tmpvar_6 , mul(_World2Object ,_WorldSpaceLightPos0).xyz);
			ret.tex5 = float3(0.0, 0.0, 0.0);
			ret.tex6 = mul(tmpvar_6 , mul(_World2Object , tmpvar_13).xyz * unity_Scale.w - data.vertex.xyz);
			return ret;
		}

		float4 frag(v2f data) : COLOR // fragment shader
		{
			float4 c_1;
			float3 tmpvar_2;
			tmpvar_2.x = data.tex1.w;
			tmpvar_2.y = data.tex2.w;
			tmpvar_2.z = data.tex3.w;
			float4 tmpvar_3;
			tmpvar_3 = tex2D (_maskmap1, data.tex);
			float4 tmpvar_4;
			tmpvar_4 = tex2D (_maskmap2, data.tex);
			float4 tmpvar_5;
			tmpvar_5 = tex2D (_basetexture, data.tex);
			float3 normal_6;
			normal_6.xy = ((tex2D (_normalmap, data.tex).wy * 2.0) - 1.0);
			normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
			float3 tmpvar_7;
			tmpvar_7.x = dot (data.tex1.xyz, normal_6);
			tmpvar_7.y = dot (data.tex2.xyz, normal_6);
			tmpvar_7.z = dot (data.tex3.xyz, normal_6);
			float3 tmpvar_8;
			tmpvar_8.x = dot (data.tex1.xyz, normal_6);
			tmpvar_8.y = dot (data.tex2.xyz, normal_6);
			tmpvar_8.z = dot (data.tex3.xyz, normal_6);
			float3 tmpvar_10;
			tmpvar_10 = (max (tmpvar_3.w, _selfillumblendtofull) * tmpvar_5.xyz);
			c_1 = float4(0.0, 0.0, 0.0, 0.0);
			float3 rimlight_11;
			float3 fresnel_12;
			float attenuation_13;
			float4 color_14;
			color_14 = float4(0.0, 0.0, 0.0, 0.0);
			float3 tmpvar_15;
			tmpvar_15 = normalize(normalize(data.tex6));
			float tmpvar_16;
			tmpvar_16 = clamp (dot (normal_6, data.tex4), 0.0, 1.0);
			float3 tmpvar_17;
			tmpvar_17 = (_LightColor0.xyz * 2.0);
			attenuation_13 = 1.0;
			if ((0.0 != _WorldSpaceLightPos0.w)) {
				attenuation_13 = tmpvar_16;
			};
			float tmpvar_18;
			tmpvar_18 = ((tmpvar_16 * 0.5) + 0.5);
			float tmpvar_19;
			tmpvar_19 = pow ((1.0 - clamp (dot (normal_6, tmpvar_15), 0.0, 1.0)), 5.0);
			fresnel_12.xy = float2(tmpvar_19);
			fresnel_12.z = (1.0 - tmpvar_19);
			float2 tmpvar_20;
			tmpvar_20.y = 0.0;
			tmpvar_20.x = clamp (dot (normal_6, tmpvar_15), 0.0, 1.0);
			float3 tmpvar_21;
			tmpvar_21 = fresnel_12;
			float4 tmpvar_22;
			tmpvar_22.w = 1.0;
			tmpvar_22.xyz = tmpvar_7;
			float3 x2_23;
			float3 x1_24;
			x1_24.x = dot (unity_SHAr, tmpvar_22);
			x1_24.y = dot (unity_SHAg, tmpvar_22);
			x1_24.z = dot (unity_SHAb, tmpvar_22);
			float4 tmpvar_25;
			tmpvar_25 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
			x2_23.x = dot (unity_SHBr, tmpvar_25);
			x2_23.y = dot (unity_SHBg, tmpvar_25);
			x2_23.z = dot (unity_SHBb, tmpvar_25);
			float3 tmpvar_26;
			tmpvar_26 = (tmpvar_5.xyz * (((float3(tmpvar_18) * tmpvar_17) * attenuation_13) + (((x1_24 + x2_23) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))) * _ambientscale)));
			float3 tmpvar_27;
			tmpvar_27 = (((((float3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_18) - data.tex4)), tmpvar_15)), (tmpvar_4.w * _specularexponent))) * tmpvar_17) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((lerp ((tmpvar_26 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_21.z) * tmpvar_16)) * attenuation_13);
			color_14.xyz = (tmpvar_26 + tmpvar_27);
			color_14.xyz = lerp (color_14.xyz, tmpvar_27, tmpvar_3.zzz);
			float4 v_28;
			v_28.x = unity_MatrixV[0].y;
			v_28.y = unity_MatrixV[1].y;
			v_28.z = unity_MatrixV[2].y;
			v_28.w = unity_MatrixV[3].y;
			float4 tmpvar_29;
			tmpvar_29.w = 0.0;
			tmpvar_29.xyz = tmpvar_7;
			float3 tmpvar_30;
			tmpvar_30 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_21.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_28, tmpvar_29), 0.0, 1.0));
			rimlight_11 = tmpvar_30;
			if ((0.0 != _WorldSpaceLightPos0.w)) {
				rimlight_11 = tmpvar_30;
			};
			color_14.xyz = (color_14.xyz + rimlight_11);
			color_14.w = 1.0;
			c_1.w = color_14.w;
			c_1.xyz = (color_14.xyz + (tmpvar_5.xyz * data.tex5));
			c_1.xyz = (c_1.xyz + tmpvar_10);
			return c_1;
		}

         ENDCG
      }
   }
	Fallback "Unlit/Texture"
}
