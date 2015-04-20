// Blackfire Studio
// Matthieu Ostertag

Shader "Blackfire Studio/Dota 2/Custom Hero/Custom Hero Advanced" {
	Properties {
		_basetexture("Diffuse (RGB) Alpha (A)", 2D)	= "white" {}
		_normalmap	("Normal (RGB)", 2D) = "bump" {}
		_maskmap1	("Mask 1 (RGBA)", 2D) = "black" {}
		_maskmap2	("Mask 2 (RGBA)", 2D) = "black" {}
		
		_ambientscale	("Ambient Scale", Float) = 1.0

		_rimlightcolor ("Rim Light Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_rimlightscale ("Rim Light Scale", Float) = 1.0
		_rimlightblendtofull ("Rim Light Blend To Full", Range(0.0, 1.0)) = 0.0
		
		_specularcolor ("Specular Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_specularexponent ("Specular Exponent", Float) = 1.0
		_specularscale ("Specular Scale", Float) = 1.0
		_specularblendtofull ("Specular Blend To Full", Range(0.0, 1.0)) = 0.0
		
		_selfillumblendtofull ("Self-Illumination Blend To Full", Range(0.0, 1.0)) = 0.0
		
		_fresnelwarp ("Fresnel Warp (RGB)", 2D) = "black" {}
		_fresnelwarpblendtonone ("Fresnel Warp Blend To None", Range(0.0, 1.0)) = 0.0
		
		_diffusewarp ("Diffuse Warp (RGB)", 2D)	= "white" {}
		_diffusewarpblendtofull	("Diffuse Warp Blend To Full", Range(0.0, 1.0)) = 0.0
		
		_specularwarp ("Specular Warp (RGB)", 2D) = "black" {}
		_specularwarpintensity ("Specular Warp Intensity",  Range(0.0, 1.0)) = 0.0
		
		_fresnelcolorwarp ("Fresnel Color Warp (RGB)", 3D)= "black" {}
		_fresnelcolorwarpblendtonone ("Fresnel Color Warp Intensity", Range(0.0, 1.0)) = 0.0
		
		_colorwarp ("Color Warp (RGB)", 3D) = "white" {}
		_colorwarpblendtonone ("Color Warp Intensity", Range(0.0, 1.0)) = 0.0
		
		_envmap ("Environment (RGB)", Cube) = "white" {}
		_envmapintensity ("Environment Intensity", Float) = 0.0
		_maskenvbymetalness ("Mask Environment by Metalness",  Range(0.0, 1.0)) = 0.0
		
		[KeywordEnum(Off, Add, Self Illumination, Mod2x)]
		_detail1blendmode ("Detail 1 Blend Mode", Float) = 0
		_detail1map	("Detail 1 (RGB)", 2D) = "white" {}
		_detail1scale ("Detail 1 Scale", Float) = 1.0
		_detail1blendfactor	("Detail 1 Blend Factor", Float) = 1.0
		_detail1blendtofull ("Detail 1 Blend To Full", Range(0.0, 1.0)) = 0.0
		_detail1scrollrate ("Detail 1 Scroll Rate", Float) = 0.0
		_detail1scrollangle	("Detail 1 Scroll Angle", Float) = 0.0
	}
	
	SubShader {
		Tags { "Queue" = "Geometry" "RenderType" = "Opaque" }
		LOD 400
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf CustomHero noambient novertexlights nolightmap nodirlightmap
		
		#ifdef SHADER_API_OPENGL	
			#pragma glsl
		#endif

		#pragma multi_compile _LINEAR_SPACE _GAMMA_SPACE
		#pragma multi_compile _DETAIL1BLENDMODE_OFF _DETAIL1BLENDMODE_ADD _DETAIL1BLENDMODE_SELF_ILLUMINATION _DETAIL1BLENDMODE_MOD2X
		
		#include "DotaCore.cginc"
		#include "DotaInputs.cginc"
		#include "DotaLighting.cginc"
		#include "DotaSurface.cginc"

		ENDCG
	}
	FallBack "Diffuse"
	CustomEditor "DotaMaterialEditor"
}
