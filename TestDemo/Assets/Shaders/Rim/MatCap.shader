Shader "kokichi/Mobile/MatCap/Textured"
{
	Properties
	{
		_basetexture ("Base (RGB) Cutoff(A)", 2D) = "white" {}
		_color("Main Color", Color) = (1,1,1,1)
		_matcap ("MatCap (RGB)", 2D) = "white" {}
		_ambientscale("Ambient Scale", Float) = 1.0
		_diffusescale("Diffuse Scale", Float) = 1.0
		_mulscale("Multiple Scale", Float) = 0.8
		_addscale("Add Scale", Float) = 0.8
	}
	
	Subshader
	{
		Tags {"QUEUE"="Transparent" }
		Pass
		{
			Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc" 
				
			#define MAT_CAP 
			
			#include "RimInput.cginc"
			#include "RimFunc.cginc"
			
			ENDCG
		}
		Pass
		{
			Cull Front
			ZWrite Off
//			ZTest Always
			Stencil
			{
				Ref 1
				Comp Equal
			}
			Blend SrcAlpha OneMinusSrcAlpha
		
			Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Transparent" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc" 
				
			#define MAT_CAP 
			#define REFLECTIVE
			
			#include "RimInput.cginc"
			#include "RimFunc.cginc"
			
			ENDCG
		}
		
		

	}
	
	
}