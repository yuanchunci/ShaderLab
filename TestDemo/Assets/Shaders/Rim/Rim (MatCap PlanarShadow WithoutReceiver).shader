Shader "kokichi/Mobile/Rim/MatCap/Textured PlanarShadow WithoutReceiver"
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
		_flashColor("Flash Color", Color) = (1,1,1,1)
		_flashValue("Flash value", Range(0,1)) = 0
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
		
		UsePass "kokichi/Hidden/Stencil(Without Receiver)/PLANAR_SHADOW"
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