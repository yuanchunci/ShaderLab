// Upgrade NOTE: replaced 'glstate.matrix.invtrans.modelview[0]' with 'UNITY_MATRIX_IT_MV'
// Upgrade NOTE: replaced 'glstate.matrix.mvp' with 'UNITY_MATRIX_MVP'

Shader "Hidden/ShadowVolume/Extrusion" {
Properties {
	_Extrusion ("Extrusion", Range(0,30)) = 5.0
}

CGINCLUDE
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it does not contain a surface program or both vertex and fragment programs.
#pragma exclude_renderers gles
// Upgrade NOTE: excluded shader from DX11 and Xbox360; has structs without semantics (struct appdata members vertex,normal)
#pragma exclude_renderers d3d11 xbox360
#pragma vertex vert
#include "UnityCG.cginc"

struct appdata {
	float4 vertex;
	float3 normal;
};

float _Extrusion;

// camera space light position
// xyz = position, w = 1 for point/spot lights
// xyz = direction, w = 0 for directional lights
float4 _LightPosition;
float4x4 _World2Receiver;

float4 vert( appdata v ) : POSITION {
	
	// point to light vector
	float4 objLightPos = mul( _LightPosition, UNITY_MATRIX_IT_MV );
	float3 toLight = normalize(objLightPos.xyz - v.vertex.xyz * objLightPos.w);
	
	// dot with normal
	float backFactor = dot( toLight, v.normal );
	
	float extrude = (backFactor < 0.0) ? 1.0 : 0.0;
	v.vertex.xyz -= toLight * (extrude * _Extrusion);
	
	return mul( UNITY_MATRIX_MVP, v.vertex );
}

fixed4 vert2(fixed4 vertexPos : POSITION) : SV_POSITION
{
	fixed4x4 modelMatrix = _Object2World;
	fixed4x4 modelMatrixInverse = _World2Object;
	modelMatrixInverse[3][3] = 1.0; 
	
	float4 objLightPos = mul( _LightPosition, UNITY_MATRIX_IT_MV );
	float4 lightDirection = normalize(objLightPos - vertexPos * objLightPos.w);
	fixed4 vertexInWorldSpace = mul(modelMatrix, vertexPos);
	fixed4 world2ReceiverRow1 = fixed4(0,1,0,0);
	fixed distanceOfVertex = dot(world2ReceiverRow1, vertexInWorldSpace); 
	fixed lengthOfLightDirectionInY = dot(world2ReceiverRow1, lightDirection); 
	if (distanceOfVertex > 0.0 && lengthOfLightDirectionInY < 0.0)
	{
//		lightDirection = lightDirection  * (distanceOfVertex / (-lengthOfLightDirectionInY));
	}
	else
	{
//		lightDirection = fixed4(0.0, 0.0, 0.0, 0.0); 
	  // don't move vertex
	}
	return mul(UNITY_MATRIX_VP, vertexInWorldSpace + lightDirection);
}

 
ENDCG


SubShader {
	Tags { "Queue" = "Transparent+10" }
	
	ZWrite Off
	ColorMask A
	Offset 1,1
	// Draw front faces, doubling the value in alpha channel
	Pass {
		Cull Back
		Blend DstColor One
		
		CGPROGRAM
		ENDCG
	
		SetTexture[_MainTex] { constantColor(1,1,1,1) combine constant }		
	}
	
	
	// Draw back faces, halving the value in alpha channel
	Pass {
		Cull Front
		Blend DstColor Zero
		
		CGPROGRAM
		ENDCG
	
		SetTexture[_MainTex] { constantColor(0.5,0.5,0.5,0.5) combine constant }
		
	}
	
	
	
} 

FallBack Off
}
