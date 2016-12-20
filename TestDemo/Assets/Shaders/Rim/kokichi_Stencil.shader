Shader "kokichi/Hidden/Stencil"
{
	Properties
	{
	}
	
	SubShader
	{
		Pass
		{
			Name "PLANAR_SHADOW"
			Offset -1.0, -2.0 	
			LOD 400		
			Stencil
			{
				Ref 1
				Comp Equal
				Pass IncrSat
			}
			
			Lighting Off
			ZWrite Off
			Blend Zero One
			Fog
			{
				Mode Off
			}
 
	         CGPROGRAM
	 		
	         #pragma vertex vert 
	         #pragma fragment frag
	 
	         #include "UnityCG.cginc"
	 
	         // User-specified uniforms
	         fixed4 _ShadowColor;
	         uniform float4x4 _World2Receiver; // transformation from 
												// world coordinates to the coordinate system of the plane
	         uniform float4 _LightDir;
	            
	 
	         float4 vert(float4 vertexPos : POSITION) : SV_POSITION
	         {
	            float4x4 modelMatrix = _Object2World;
	            float4x4 modelMatrixInverse = _World2Object * unity_Scale.w;
	            modelMatrixInverse[3][3] = 1.0; 
	            float4 lightDirection = normalize(_LightDir);
	            float4 vertexInWorldSpace = mul(modelMatrix, vertexPos);
	            float4 world2ReceiverRow1 = float4(_World2Receiver[1][0], _World2Receiver[1][1], 
	               									_World2Receiver[1][2], _World2Receiver[1][3]);
	            float distanceOfVertex = dot(world2ReceiverRow1, vertexInWorldSpace); 
	            float lengthOfLightDirectionInY = dot(world2ReceiverRow1, lightDirection); 
	            float step1 = step(0, distanceOfVertex);
	            float step2 = step(lengthOfLightDirectionInY, 0);
	            lightDirection = step1 * step2 * lightDirection  * (distanceOfVertex / (-lengthOfLightDirectionInY));
	            return mul(UNITY_MATRIX_VP, vertexInWorldSpace + lightDirection);
	         }
	 
	         fixed4 frag(void) : COLOR 
	         {
	            return _ShadowColor;
	         }
			ENDCG
		}
		
	}
}
