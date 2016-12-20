Shader "kokichi/Mobile/MatCap/Textured Outline PlanarShadow"
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
		_Outline ("Outline Width", Range(0,0.05)) = 0.005
		_OutlineColor ("Outline Color", Color) = (0.2, 0.2, 0.2, 1)
		_behindwallColor ("Behind Wall Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}
	
	Subshader
	{
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
		
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
		UsePass "kokichi/Hidden/Outline/OUTLINE"
		UsePass "kokichi/Hidden/Stencil/PLANAR_SHADOW"
//		UsePass "kokichi/Hidden/XRay Wall/WALL"
		
	}
	
	
}