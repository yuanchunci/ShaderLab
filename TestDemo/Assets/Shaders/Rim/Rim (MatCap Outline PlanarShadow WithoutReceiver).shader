Shader "kokichi/Mobile/Rim/MatCap/Textured Outline PlanarShadow(WithoutReceiver)
"
{
	Properties
	{
		_basetexture ("Base (RGB) Cutoff(A)", 2D) = "white" {}
		_color("Main Color", Color) = (1,1,1,1)
		_matcap ("MatCap (RGB)", 2D) = "white" {}
		_rimTex ("Rim Tex (RGB)", 2D) = "black" {}
		_ambientscale("Ambient Scale", Float) = 1.0
		_diffusescale("Diffuse Scale", Float) = 1.0
		_mulscale("Multiple Scale", Float) = 0.8
		_addscale("Add Scale", Float) = 0.8
		_rimlightcolor ("Rim Light Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_rimlightscale ("Rim Light Scale", Float) = 1.0
		_Outline ("Outline Width", Range(0,0.05)) = 0.005
		_Outline (" ", Float) = 0.005
		_OutlineColor ("Outline Color", Color) = (0.2, 0.2, 0.2, 1)
		_Shininess ("Shininess", Range(0.03,1)) = 0.15
      	_Shininess ("Shininess", Float) = 0.15
      	_LuminateVector("Luminate (XYZ) Bias (W)", Vector) = (0.3,0.58,0.12,0.35)
	}
	
	Subshader
	{
		Tags {"QUEUE"="Geometry" }
		LOD 400
		Pass
		{
			Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile GAMMA_ON GAMMA_OFF
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc" 
			
			#define RIM_LIGHT	
			#define MAT_CAP 
			#define FLASH_COLOR
			#define SPECULAR
			
			#include "RimInput.cginc"
			#include "RimFunc.cginc"
			
			ENDCG
		}
		UsePass "kokichi/Hidden/Outline/OUTLINE"
		UsePass "kokichi/Hidden/Stencil(Without Receiver)/PLANAR_SHADOW"
	}
	
	Subshader
	{
		Tags {"QUEUE"="Geometry" }
		LOD 300
		Pass
		{
			Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile GAMMA_ON GAMMA_OFF
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc" 
			
			#define RIM_LIGHT	
			#define MAT_CAP 
			#define FLASH_COLOR
			
			#include "RimInput.cginc"
			#include "RimFunc.cginc"
			
			ENDCG
		}
		UsePass "kokichi/Hidden/Outline/OUTLINE"
	}
	
	Subshader
	{
		Tags {"QUEUE"="Geometry" }
		LOD 200
		Pass
		{
			Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile GAMMA_ON GAMMA_OFF
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc" 
			
			#define RIM_LIGHT	
			#define MAT_CAP 
			#define FLASH_COLOR
			
			#include "RimInput.cginc"
			#include "RimFunc.cginc"
			
			ENDCG
		}
	}
	
}