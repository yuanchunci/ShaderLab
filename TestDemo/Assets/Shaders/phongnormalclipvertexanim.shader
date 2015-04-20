//phong CG shader with vertex animation and translucency


Shader "CG Shaders/Phong/Phong Texture Vertex Anim"
{
	Properties
	{
		_diffuseColor("Diffuse Color", Color) = (1,1,1,1)
		_diffuseMap("Diffuse", 2D) = "white" {}
		_specularPower ("Specular Power", Range(1.0, 50.0)) = 10
		_specularPower (" ", Float) = 10
		_specularColor("Specular Color", Color) = (1,1,1,1)
		_normalMap("Normal / Specular (A)", 2D) = "bump" {}
		//vertex animation
		_windSource("Wind Direction", Float) = (1,0,0,0)
		windSpeed ("Wind Speed", Range(0.0, 5.0)) = 1
		windSpeed (" ", Float) = 1			
		windStrength ("Wind Strength", Range(0.0, 3.0)) = 1
		windStrength (" ", Float) = 1		
		_pivot("Pivot Offset", Float) = (0,0,0,1)				
		_mainBendFalloff ("Main Bending Falloff", Range(0.0, 1.0)) = .25
		_mainBendFalloff (" ", Float) = .25
		_mainBendSpeed ("Main Bending Speed", Range(0.0, 1.0)) = .25
		_mainBendSpeed (" ", Float) = .25
		_mainBendStrength ("Main Bending Strength", Range(0.0, 1.0)) = .25
		_mainBendStrength (" ", Float) = .25
		_branchBendSpeed ("Branch Bending Speed", Range(0.0, 1.0)) = .5
		_branchBendSpeed (" ", Float) = .5
		_branchBendStrength ("Branch Bending Strength", Range(0.0, 1.0)) = 0.2
		_branchBendStrength (" ", Float) = 0.2
		_branchBendSize ("Branch Bending Size", Range(0.0, 5.0)) = 2.5
		_branchBendSize (" ", Float) = 2.5			
		_branchBendVariation ("Branch Bending Variation", Range(0.0, 1.0)) = 0.5
		_branchBendVariation (" ", Float) = 0.5
		_edgeBendSpeed ("Edge Bending Speed", Range(0.0, 5.0)) = 1.5
		_edgeBendSpeed (" ", Float) = 1.5
		_edgeBendStrength ("Edge Bending Strength", Range(0.0, 1)) = 0.25
		_edgeBendStrength (" ", Float) = 0.25	
		_edgeBendSize ("Edge Bending Size", Range(0.0, 5.0)) = 1
		_edgeBendSize (" ", Float) = 1		
			
		
	}
	SubShader
	{
		Tags {"Queue" = "Transparent" }
		//since we are only using clip, we can continue to z test
		//blending would need seperate samples for back and front - 4 passes - yikes
		AlphaTest Greater 0.3
		
		Pass
		{
			Tags { "LightMode" = "ForwardBase" } 
			Cull Front
			
            
			CGPROGRAM
			
			#pragma vertex vShader
			#pragma fragment pShader
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			//if you MUST compile for flash, you might have to remove some features
			//personally i'm not trying to render on a potato
			#pragma target 3.0
			
			uniform fixed3 _diffuseColor;
			uniform sampler2D _diffuseMap;
			uniform half4 _diffuseMap_ST;			
			uniform fixed4 _LightColor0; 
			uniform half _FrenselPower;
			uniform fixed4 _rimColor;
			uniform half _specularPower;
			uniform fixed3 _specularColor;
			uniform sampler2D _normalMap;
			uniform half4 _normalMap_ST;
			//vertex animation
			uniform fixed3 _windSource;			
			half windStrength;
			half windSpeed;
			half _mainBendSpeed;
			half _mainBendStrength;
			half _branchBendSpeed;
			half _branchBendSize;
			half _branchBendStrength;
			half _branchBendVariation;
			half _edgeBendSpeed;
			half _edgeBendSize;
			half _edgeBendStrength;
			uniform fixed3 _pivot;
			half _mainBendFalloff;
			
			
			
			struct app2vert {
				float4 vertex 	: 	POSITION;
				fixed2 texCoord : 	TEXCOORD0;
				fixed4 normal 	:	NORMAL;
				fixed4 tangent : TANGENT;
				//vertex colors
				fixed4 color : COLOR; 
				
				
			};
			struct vert2Pixel
			{
				float4 pos 						: 	SV_POSITION;
				fixed2 uvs						:	TEXCOORD0;
				fixed3 normalDir						:	TEXCOORD1;	
				fixed3 binormalDir					:	TEXCOORD2;	
				fixed3 tangentDir					:	TEXCOORD3;	
				half3 posWorld						:	TEXCOORD4;	
				fixed3 viewDir						:	TEXCOORD5;
				fixed3 lighting						:	TEXCOORD6;
			};
			
			fixed lambert(fixed3 N, fixed3 L)
			{
				return saturate(dot(N, L));
			}
			fixed frensel(fixed3 V, fixed3 N, half P)
			{	
				return pow(1 - saturate(dot(V,N)), P);
			}
			fixed phong(fixed3 R, fixed3 L)
			{
				return pow(saturate(dot(R, L)), _specularPower);
			}
			
			//some wave functions
			fixed3 SmoothWave(fixed3 input)
			{
				//smooths the curve via cubic interpolation
				return input * input * (3.0 - 2.0 * input);
			}
			fixed3 TriangleWave(fixed3 input)
			{
				//get the decimals of input + 0.5
				//multiply by 2 and subtract 1
				//so we go 0 up to 1 down to 0 instead of jumping between 1 and 0
				return abs( frac( input + 0.5 ) * 2.0 - 1.0);
			}
			fixed3 SmoothTriangleWave(fixed3 input)
			{
				return SmoothWave( TriangleWave(input) );
			}
			vert2Pixel vShader(app2vert IN)
			{
				vert2Pixel OUT;
				float4x4 WorldViewProjection = UNITY_MATRIX_MVP;
				float4x4 WorldInverseTranspose = _World2Object; 
				float4x4 World = _Object2World;
				
				float4 deformedPosition = IN.vertex;
				deformedPosition = mul( World, deformedPosition  );
				float4 originalPosition  = deformedPosition;
				
				float3 binormal = cross(IN.normal.xyz, IN.tangent.xyz);
					
				float3 deformedPositionT = deformedPosition.xyz -(IN.tangent.xyz * 0.01);
				float3 originalPositionT  = deformedPositionT;
				float3 deformedPositionB = deformedPosition.xyz + (binormal* 0.01);
				float3 originalPositionB  = deformedPositionB;
				
				half3 windDir = normalize( _windSource.xyz );
				float Time = _Time.y*windSpeed;
				fixed variation = _branchBendVariation * IN.color.y;
				half3 pivot = mul( World,  half4(_pivot.xyz, 1)).xyz;
				
				//main bending
				//saturate since we don't want to bend back opposing the wind
				half3 mainDeformation = saturate( SmoothTriangleWave(windDir * Time * _mainBendSpeed ) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				half mainDeformationMask = length(originalPosition.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPosition.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending
				half3 branchDeformation = SmoothTriangleWave( (deformedPosition.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPosition.xyz +=   branchDeformation ;		
				
				//edge bending
				half3 edgeDeformation = SmoothTriangleWave(windDir * ((originalPosition.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;
				half edgeDeformationMask =  IN.color.x;
				// Smooth the mask a bit
				edgeDeformationMask *= edgeDeformationMask +.5; 	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPosition.xyz +=  edgeDeformation;
				
	
				//main bending T
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionT.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionT.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;   
				
				//branch bending T
				branchDeformation = SmoothTriangleWave( (deformedPositionT.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 	
				deformedPositionT.xyz +=   branchDeformation ;	
				 
				//edge bending T
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionT.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionT.xyz +=  edgeDeformation;
				
				//main bending B
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionB.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionB.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending B
				branchDeformation = SmoothTriangleWave( (deformedPositionB.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPositionB.xyz +=   branchDeformation ;	
				 
				//edge bending B
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionB.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionB.xyz +=   edgeDeformation;
							
				//new normals
				fixed3 normB =  normalize(deformedPositionB -  deformedPosition.xyz );
				fixed3 normT =  normalize(deformedPosition.xyz - deformedPositionT );	
				fixed3 normC = cross( normB, -normT );
				
				//transform the normals to object space like normal
				OUT.normalDir  = mul( -normC , float3x3(WorldInverseTranspose) );				
				OUT.binormalDir = mul( -normB , float3x3(WorldInverseTranspose) );				
				OUT.tangentDir = mul( -normT , float3x3(WorldInverseTranspose) ); 
							
				
				OUT.posWorld = deformedPosition.xyz;
				OUT.viewDir = normalize( OUT.posWorld - _WorldSpaceCameraPos);

				deformedPosition = mul(WorldInverseTranspose, float4 (deformedPosition.xyz, 1))* unity_Scale.w;
				OUT.pos = mul(WorldViewProjection, deformedPosition);
				
				OUT.uvs = IN.texCoord;		
				//vertex lights
				fixed3 vertexLighting = fixed3(0.0, 0.0, 0.0);
				#ifdef VERTEXLIGHT_ON
				 for (int index = 0; index < 4; index++)
					{    						
						half3 vertexToLightSource = half3(unity_4LightPosX0[index], unity_4LightPosY0[index], unity_4LightPosZ0[index]) - OUT.posWorld;
						fixed attenuation  = (1.0/ length(vertexToLightSource)) *.5;	
						fixed3 diffuse = unity_LightColor[index].xyz * lambert(OUT.normalDir, normalize(vertexToLightSource)) * attenuation;
						vertexLighting = vertexLighting + diffuse;
					}
				vertexLighting = saturate( vertexLighting );
				#endif
				OUT.lighting = vertexLighting ;
				
				return OUT;
			}
			
			fixed4 pShader(vert2Pixel IN): COLOR
			{
			
				
				
				half2 normalUVs = TRANSFORM_TEX(IN.uvs, _normalMap);
				fixed4 normalD = tex2D(_normalMap, normalUVs);
				normalD.xyz = (normalD.xyz * 2) - 1;
				
				fixed3 normalDir = normalD.xyz;	
				fixed specMap = normalD.w;
				normalDir = normalize((normalDir.x * IN.tangentDir) + (normalDir.y * IN.binormalDir) + (normalDir.z * IN.normalDir));
	
				fixed3 ambientL = fixed3(UNITY_LIGHTMODEL_AMBIENT);
	
				
	
				//Main Light calculation - includes directional lights
				half3 pixelToLightSource =_WorldSpaceLightPos0.xyz - (IN.posWorld*_WorldSpaceLightPos0.w);
				fixed attenuation  = lerp(1.0, 1.0/ length(pixelToLightSource), _WorldSpaceLightPos0.w);				
				fixed3 lightDirection = normalize(pixelToLightSource);
				fixed diffuseL = lambert(normalDir, lightDirection);				
				
				fixed3 diffuse = fixed3(_LightColor0)* (diffuseL )* attenuation;
				diffuse = saturate(IN.lighting + ambientL + diffuse);
		
				//specular
				fixed specularHighlight = phong(reflect(IN.viewDir , normalDir) ,lightDirection)*attenuation;
				
				fixed4 outColor;							
				half2 diffuseUVs = TRANSFORM_TEX(IN.uvs, _diffuseMap);
				fixed4 texSample = tex2D(_diffuseMap, diffuseUVs);
				fixed3 diffuseS = (diffuse * texSample.xyz) * _diffuseColor.xyz;
				fixed3 specular = (specularHighlight * _specularColor * specMap);
				//add transmission to color
				outColor = fixed4( diffuseS + specular ,texSample.w);
				return outColor;
			}
			
			ENDCG
		}	
		
		//the second pass for additional lights
		Pass
		{
			Tags { "LightMode" = "ForwardAdd" } 
			Cull Front
			Blend One One 
			
			CGPROGRAM
			#pragma vertex vShader
			#pragma fragment pShader
			#include "UnityCG.cginc"
			
			uniform fixed3 _diffuseColor;
			uniform sampler2D _diffuseMap;
			uniform half4 _diffuseMap_ST;
			uniform fixed4 _LightColor0; 		
			uniform half _specularPower;
			uniform fixed3 _specularColor;
			uniform sampler2D _normalMap;
			uniform half4 _normalMap_ST;	
			//vertex animation
			uniform fixed3 _windSource;			
			half windStrength;
			half windSpeed;
			half _mainBendSpeed;
			half _mainBendStrength;
			half _branchBendSpeed;
			half _branchBendSize;
			half _branchBendStrength;
			half _branchBendVariation;
			half _edgeBendSpeed;
			half _edgeBendSize;
			half _edgeBendStrength;
			uniform fixed3 _pivot;
			half _mainBendFalloff;
			
			
			struct app2vert {
				float4 vertex 	: 	POSITION;
				fixed2 texCoord : 	TEXCOORD0;
				fixed4 normal 	:	NORMAL;
				fixed4 tangent : TANGENT;
				//vertex colors
				fixed4 color : COLOR; 
			};
			struct vert2Pixel
			{
				float4 pos 						: 	SV_POSITION;
				fixed2 uvs						:	TEXCOORD0;	
				fixed3 normalDir						:	TEXCOORD1;	
				fixed3 binormalDir					:	TEXCOORD2;	
				fixed3 tangentDir					:	TEXCOORD3;	
				half3 posWorld						:	TEXCOORD4;	
				fixed3 viewDir						:	TEXCOORD5;
				fixed4 lighting					:	TEXCOORD6;	
			};
			
			fixed lambert(fixed3 N, fixed3 L)
			{
				return saturate(dot(N, L));
			}			
			fixed phong(fixed3 R, fixed3 L)
			{
				return pow(saturate(dot(R, L)), _specularPower);
			}
			
			
			//some wave functions
			fixed3 SmoothWave(fixed3 input)
			{
				//smooths the curve via cubic interpolation
				return input * input * (3.0 - 2.0 * input);
			}
			fixed3 TriangleWave(fixed3 input)
			{
				//get the decimals of input + 0.5
				//multiply by 2 and subtract 1
				//so we go 0 up to 1 down to 0 instead of jumping between 1 and 0
				return abs( frac( input + 0.5 ) * 2.0 - 1.0);
			}
			fixed3 SmoothTriangleWave(fixed3 input)
			{
				return SmoothWave( TriangleWave(input) );
			}
			
			vert2Pixel vShader(app2vert IN)
			{
				vert2Pixel OUT;
				float4x4 WorldViewProjection = UNITY_MATRIX_MVP;
				float4x4 WorldInverseTranspose = _World2Object; 
				float4x4 World = _Object2World;
				
				float4 deformedPosition = IN.vertex;
				deformedPosition = mul( World, deformedPosition  );
				float4 originalPosition  = deformedPosition;
								
				
				float3 binormal = cross(IN.normal.xyz, IN.tangent.xyz);
					
				float3 deformedPositionT = deformedPosition.xyz -(IN.tangent.xyz * 0.01);
				float3 originalPositionT  = deformedPositionT;
				float3 deformedPositionB = deformedPosition.xyz + (binormal* 0.01);
				float3 originalPositionB  = deformedPositionB;
				
				half3 windDir = normalize( _windSource.xyz );
				float Time = _Time.y*windSpeed;
				fixed variation = _branchBendVariation * IN.color.y;
				half3 pivot = mul( World,  half4(_pivot.xyz, 1)).xyz;
				
				
				//main bending
				//saturate since we don't want to bend back opposing the wind
				half3 mainDeformation = saturate( SmoothTriangleWave(windDir * Time * _mainBendSpeed ) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				half mainDeformationMask = length(originalPosition.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPosition.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending
				half3 branchDeformation = SmoothTriangleWave( (deformedPosition.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPosition.xyz +=   branchDeformation ;		
				
				//edge bending
				half3 edgeDeformation = SmoothTriangleWave(windDir * ((originalPosition.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;
				half edgeDeformationMask =  IN.color.x;
				// Smooth the mask a bit
				edgeDeformationMask *= edgeDeformationMask +.5; 	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPosition.xyz +=  edgeDeformation;
				
	
				//main bending T
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionT.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionT.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;   
				
				//branch bending T
				branchDeformation = SmoothTriangleWave( (deformedPositionT.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 	
				deformedPositionT.xyz +=   branchDeformation ;	
				 
				//edge bending T
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionT.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionT.xyz +=  edgeDeformation;
				
				//main bending B
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionB.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionB.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending B
				branchDeformation = SmoothTriangleWave( (deformedPositionB.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPositionB.xyz +=   branchDeformation ;	
				 
				//edge bending B
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionB.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionB.xyz +=   edgeDeformation;
				
				
				
				//new normals
				float3 normB =  normalize(deformedPositionB -  deformedPosition.xyz );
				float3 normT =  normalize(deformedPosition.xyz - deformedPositionT );	
				float3 normC = cross( normB, -normT );
				
				//transform the normals to object space like normal
				OUT.normalDir  = mul( -normC , float3x3(WorldInverseTranspose) );				
				OUT.binormalDir = mul( -normB , float3x3(WorldInverseTranspose) );				
				OUT.tangentDir = mul( -normT , float3x3(WorldInverseTranspose) ); 
							
				
				OUT.posWorld = deformedPosition.xyz;
				OUT.viewDir = normalize( OUT.posWorld - _WorldSpaceCameraPos);

				deformedPosition = mul(WorldInverseTranspose, float4 (deformedPosition.xyz, 1))* unity_Scale.w;
				OUT.pos = mul(WorldViewProjection, deformedPosition);
				
				OUT.uvs = IN.texCoord;		
				
				
				
				return OUT;
			}
			fixed4 pShader(vert2Pixel IN): COLOR
			{
				
				
			
				half2 normalUVs = TRANSFORM_TEX(IN.uvs, _normalMap);
				fixed4 normalD = tex2D(_normalMap, normalUVs);
				normalD.xyz = (normalD.xyz * 2) - 1;
				
				//half3 normalDir = half3(2.0 * normalSample.xy - float2(1.0), 0.0);
				//deriving the z component
				//normalDir.z = sqrt(1.0 - dot(normalDir, normalDir));
               // alternatively you can approximate deriving the z component without sqrt like so: 
				//normalDir.z = 1.0 - 0.5 * dot(normalDir, normalDir);
				
				//pull the alpha out for spec before modification
				fixed3 normalDir = normalD.xyz;	
				fixed specMap = normalD.w;
				normalDir = normalize((normalDir.x * IN.tangentDir) + (normalDir.y * IN.binormalDir) + (normalDir.z * IN.normalDir));
						
				//Fill lights
				half3 pixelToLightSource =half3(_WorldSpaceLightPos0)- (IN.posWorld*_WorldSpaceLightPos0.w);
				fixed attenuation  = lerp(1.0, 1.0/ length(pixelToLightSource), _WorldSpaceLightPos0.w);				
				fixed3 lightDirection = normalize(pixelToLightSource);
				
				fixed diffuseL = lambert(normalDir, lightDirection);				
				fixed3 diffuseTotal = fixed3(_LightColor0)* diffuseL * attenuation;
				//specular highlight
				fixed specularHighlight = phong(reflect(IN.viewDir , normalDir) ,lightDirection)*attenuation;
				
				fixed4 outColor;							
				half2 diffuseUVs = TRANSFORM_TEX(IN.uvs, _diffuseMap);
				fixed4 texSample = tex2D(_diffuseMap, diffuseUVs);
				fixed3 diffuseS = (diffuseTotal * texSample.xyz) * _diffuseColor.xyz;
				fixed3 specular = specularHighlight * _specularColor * specMap;
				outColor = fixed4( diffuseS + specular,texSample.w);
				return outColor;
			}
			
			ENDCG
		}	
		
		
		
		Pass
		{
			Tags { "LightMode" = "ForwardBase" } 
			Cull Back
			
            
			CGPROGRAM
			
			#pragma vertex vShader
			#pragma fragment pShader
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			//if you MUST compile for flash, you might have to remove some features
			//personally i'm not trying to render on a potato
			#pragma target 3.0
			
			uniform fixed3 _diffuseColor;
			uniform sampler2D _diffuseMap;
			uniform half4 _diffuseMap_ST;			
			uniform fixed4 _LightColor0; 
			uniform half _FrenselPower;
			uniform fixed4 _rimColor;
			uniform half _specularPower;
			uniform fixed3 _specularColor;
			uniform sampler2D _normalMap;
			uniform half4 _normalMap_ST;
			//vertex animation
			uniform fixed3 _windSource;			
			half windStrength;
			half windSpeed;
			half _mainBendSpeed;
			half _mainBendStrength;
			half _branchBendSpeed;
			half _branchBendSize;
			half _branchBendStrength;
			half _branchBendVariation;
			half _edgeBendSpeed;
			half _edgeBendSize;
			half _edgeBendStrength;
			uniform fixed3 _pivot;
			half _mainBendFalloff;
			
			
			
			struct app2vert {
				float4 vertex 	: 	POSITION;
				fixed2 texCoord : 	TEXCOORD0;
				fixed4 normal 	:	NORMAL;
				fixed4 tangent : TANGENT;
				//vertex colors
				fixed4 color : COLOR; 
				
				
			};
			struct vert2Pixel
			{
				float4 pos 						: 	SV_POSITION;
				fixed2 uvs						:	TEXCOORD0;
				fixed3 normalDir						:	TEXCOORD1;	
				fixed3 binormalDir					:	TEXCOORD2;	
				fixed3 tangentDir					:	TEXCOORD3;	
				half3 posWorld						:	TEXCOORD4;	
				fixed3 viewDir						:	TEXCOORD5;
				fixed3 lighting						:	TEXCOORD6;
			};
			
			fixed lambert(fixed3 N, fixed3 L)
			{
				return saturate(dot(N, L));
			}
			fixed frensel(fixed3 V, fixed3 N, half P)
			{	
				return pow(1 - saturate(dot(V,N)), P);
			}
			fixed phong(fixed3 R, fixed3 L)
			{
				return pow(saturate(dot(R, L)), _specularPower);
			}
			
			//some wave functions
			fixed3 SmoothWave(fixed3 input)
			{
				//smooths the curve via cubic interpolation
				return input * input * (3.0 - 2.0 * input);
			}
			fixed3 TriangleWave(fixed3 input)
			{
				//get the decimals of input + 0.5
				//multiply by 2 and subtract 1
				//so we go 0 up to 1 down to 0 instead of jumping between 1 and 0
				return abs( frac( input + 0.5 ) * 2.0 - 1.0);
			}
			fixed3 SmoothTriangleWave(fixed3 input)
			{
				return SmoothWave( TriangleWave(input) );
			}
			vert2Pixel vShader(app2vert IN)
			{
				vert2Pixel OUT;
				float4x4 WorldViewProjection = UNITY_MATRIX_MVP;
				float4x4 WorldInverseTranspose = _World2Object; 
				float4x4 World = _Object2World;
				
				float4 deformedPosition = IN.vertex;
				deformedPosition = mul( World, deformedPosition  );
				float4 originalPosition  = deformedPosition;
				
				float3 binormal = cross(IN.normal.xyz, IN.tangent.xyz);
					
				float3 deformedPositionT = deformedPosition.xyz -(IN.tangent.xyz * 0.01);
				float3 originalPositionT  = deformedPositionT;
				float3 deformedPositionB = deformedPosition.xyz + (binormal* 0.01);
				float3 originalPositionB  = deformedPositionB;
				
				half3 windDir = normalize( _windSource.xyz );
				float Time = _Time.y*windSpeed;
				fixed variation = _branchBendVariation * IN.color.y;
				half3 pivot = mul( World,  half4(_pivot.xyz, 1)).xyz;
				
				//main bending
				//saturate since we don't want to bend back opposing the wind
				half3 mainDeformation = saturate( SmoothTriangleWave(windDir * Time * _mainBendSpeed ) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				half mainDeformationMask = length(originalPosition.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPosition.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending
				half3 branchDeformation = SmoothTriangleWave( (deformedPosition.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPosition.xyz +=   branchDeformation ;		
				
				//edge bending
				half3 edgeDeformation = SmoothTriangleWave(windDir * ((originalPosition.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;
				half edgeDeformationMask =  IN.color.x;
				// Smooth the mask a bit
				edgeDeformationMask *= edgeDeformationMask +.5; 	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPosition.xyz +=  edgeDeformation;
				
	
				//main bending T
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionT.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionT.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;   
				
				//branch bending T
				branchDeformation = SmoothTriangleWave( (deformedPositionT.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 	
				deformedPositionT.xyz +=   branchDeformation ;	
				 
				//edge bending T
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionT.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionT.xyz +=  edgeDeformation;
				
				//main bending B
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionB.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionB.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending B
				branchDeformation = SmoothTriangleWave( (deformedPositionB.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPositionB.xyz +=   branchDeformation ;	
				 
				//edge bending B
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionB.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionB.xyz +=   edgeDeformation;
							
				//new normals
				fixed3 normB =  normalize(deformedPositionB -  deformedPosition.xyz );
				fixed3 normT =  normalize(deformedPosition.xyz - deformedPositionT );	
				fixed3 normC = cross( normB, -normT );
				
				//transform the normals to object space like normal
				OUT.normalDir  = mul(  normC , float3x3(WorldInverseTranspose) );				
				OUT.binormalDir = mul(  normB , float3x3(WorldInverseTranspose) );				
				OUT.tangentDir = mul( normT , float3x3(WorldInverseTranspose) ); 
							
				
				OUT.posWorld = deformedPosition.xyz;
				OUT.viewDir = normalize( OUT.posWorld - _WorldSpaceCameraPos);

				deformedPosition = mul(WorldInverseTranspose, float4 (deformedPosition.xyz, 1))* unity_Scale.w;
				OUT.pos = mul(WorldViewProjection, deformedPosition);
				
				OUT.uvs = IN.texCoord;		
				//vertex lights
				fixed3 vertexLighting = fixed3(0.0, 0.0, 0.0);
				#ifdef VERTEXLIGHT_ON
				 for (int index = 0; index < 4; index++)
					{    						
						half3 vertexToLightSource = half3(unity_4LightPosX0[index], unity_4LightPosY0[index], unity_4LightPosZ0[index]) - OUT.posWorld;
						fixed attenuation  = (1.0/ length(vertexToLightSource)) *.5;	
						fixed3 diffuse = unity_LightColor[index].xyz * lambert(OUT.normalDir, normalize(vertexToLightSource)) * attenuation;
						vertexLighting = vertexLighting + diffuse;
					}
				vertexLighting = saturate( vertexLighting );
				#endif
				OUT.lighting = vertexLighting ;
				
				return OUT;
			}
			
			fixed4 pShader(vert2Pixel IN): COLOR
			{
			
				half2 normalUVs = TRANSFORM_TEX(IN.uvs, _normalMap);
				fixed4 normalD = tex2D(_normalMap, normalUVs);
				normalD.xyz = (normalD.xyz * 2) - 1;
				
				fixed3 normalDir = normalD.xyz;	
				fixed specMap = normalD.w;
				normalDir = normalize((normalDir.x * IN.tangentDir) + (normalDir.y * IN.binormalDir) + (normalDir.z * IN.normalDir));
	
				fixed3 ambientL = fixed3(UNITY_LIGHTMODEL_AMBIENT);
	
				
	
				//Main Light calculation - includes directional lights
				half3 pixelToLightSource =_WorldSpaceLightPos0.xyz - (IN.posWorld*_WorldSpaceLightPos0.w);
				fixed attenuation  = lerp(1.0, 1.0/ length(pixelToLightSource), _WorldSpaceLightPos0.w);				
				fixed3 lightDirection = normalize(pixelToLightSource);
				fixed diffuseL = lambert(normalDir, lightDirection);				
				
				fixed3 diffuse = fixed3(_LightColor0)* (diffuseL )* attenuation;
				diffuse = saturate(IN.lighting + ambientL + diffuse);
		
				//specular
				fixed specularHighlight = phong(reflect(IN.viewDir , normalDir) ,lightDirection)*attenuation;
				
				fixed4 outColor;							
				half2 diffuseUVs = TRANSFORM_TEX(IN.uvs, _diffuseMap);
				fixed4 texSample = tex2D(_diffuseMap, diffuseUVs);
				fixed3 diffuseS = (diffuse * texSample.xyz) * _diffuseColor.xyz;
				fixed3 specular = (specularHighlight * _specularColor * specMap);
				//add transmission to color
				outColor = fixed4( diffuseS + specular ,texSample.w);
				return outColor;
			}
			
			ENDCG
		}	
		
		//the second pass for additional lights
		Pass
		{
			Tags { "LightMode" = "ForwardAdd" } 
			Cull Back
			Blend One One 
			
			CGPROGRAM
			#pragma vertex vShader
			#pragma fragment pShader
			#include "UnityCG.cginc"
			
			uniform fixed3 _diffuseColor;
			uniform sampler2D _diffuseMap;
			uniform half4 _diffuseMap_ST;
			uniform fixed4 _LightColor0; 		
			uniform half _specularPower;
			uniform fixed3 _specularColor;
			uniform sampler2D _normalMap;
			uniform half4 _normalMap_ST;	
			//vertex animation
			uniform fixed3 _windSource;			
			half windStrength;
			half windSpeed;
			half _mainBendSpeed;
			half _mainBendStrength;
			half _branchBendSpeed;
			half _branchBendSize;
			half _branchBendStrength;
			half _branchBendVariation;
			half _edgeBendSpeed;
			half _edgeBendSize;
			half _edgeBendStrength;
			uniform fixed3 _pivot;
			half _mainBendFalloff;
			
			
			struct app2vert {
				float4 vertex 	: 	POSITION;
				fixed2 texCoord : 	TEXCOORD0;
				fixed4 normal 	:	NORMAL;
				fixed4 tangent : TANGENT;
				//vertex colors
				fixed4 color : COLOR; 
			};
			struct vert2Pixel
			{
				float4 pos 						: 	SV_POSITION;
				fixed2 uvs						:	TEXCOORD0;	
				fixed3 normalDir						:	TEXCOORD1;	
				fixed3 binormalDir					:	TEXCOORD2;	
				fixed3 tangentDir					:	TEXCOORD3;	
				half3 posWorld						:	TEXCOORD4;	
				fixed3 viewDir						:	TEXCOORD5;
				fixed4 lighting					:	TEXCOORD6;	
			};
			
			fixed lambert(fixed3 N, fixed3 L)
			{
				return saturate(dot(N, L));
			}			
			fixed phong(fixed3 R, fixed3 L)
			{
				return pow(saturate(dot(R, L)), _specularPower);
			}
			
			
			//some wave functions
			fixed3 SmoothWave(fixed3 input)
			{
				//smooths the curve via cubic interpolation
				return input * input * (3.0 - 2.0 * input);
			}
			fixed3 TriangleWave(fixed3 input)
			{
				//get the decimals of input + 0.5
				//multiply by 2 and subtract 1
				//so we go 0 up to 1 down to 0 instead of jumping between 1 and 0
				return abs( frac( input + 0.5 ) * 2.0 - 1.0);
			}
			fixed3 SmoothTriangleWave(fixed3 input)
			{
				return SmoothWave( TriangleWave(input) );
			}
			
			vert2Pixel vShader(app2vert IN)
			{
				vert2Pixel OUT;
				float4x4 WorldViewProjection = UNITY_MATRIX_MVP;
				float4x4 WorldInverseTranspose = _World2Object; 
				float4x4 World = _Object2World;
				
				float4 deformedPosition = IN.vertex;
				deformedPosition = mul( World, deformedPosition  );
				float4 originalPosition  = deformedPosition;
								
				
				float3 binormal = cross(IN.normal.xyz, IN.tangent.xyz);
					
				float3 deformedPositionT = deformedPosition.xyz -(IN.tangent.xyz * 0.01);
				float3 originalPositionT  = deformedPositionT;
				float3 deformedPositionB = deformedPosition.xyz + (binormal* 0.01);
				float3 originalPositionB  = deformedPositionB;
				
				half3 windDir = normalize( _windSource.xyz );
				float Time = _Time.y*windSpeed;
				fixed variation = _branchBendVariation * IN.color.y;
				half3 pivot = mul( World,  half4(_pivot.xyz, 1)).xyz;
				
				
				//main bending
				//saturate since we don't want to bend back opposing the wind
				half3 mainDeformation = saturate( SmoothTriangleWave(windDir * Time * _mainBendSpeed ) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				half mainDeformationMask = length(originalPosition.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPosition.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending
				half3 branchDeformation = SmoothTriangleWave( (deformedPosition.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPosition.xyz +=   branchDeformation ;		
				
				//edge bending
				half3 edgeDeformation = SmoothTriangleWave(windDir * ((originalPosition.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;
				half edgeDeformationMask =  IN.color.x;
				// Smooth the mask a bit
				edgeDeformationMask *= edgeDeformationMask +.5; 	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPosition.xyz +=  edgeDeformation;
				
	
				//main bending T
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionT.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionT.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;   
				
				//branch bending T
				branchDeformation = SmoothTriangleWave( (deformedPositionT.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 	
				deformedPositionT.xyz +=   branchDeformation ;	
				 
				//edge bending T
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionT.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionT.xyz +=  edgeDeformation;
				
				//main bending B
				//saturate since we don't want to bend back opposing the wind
				mainDeformation = saturate( SmoothTriangleWave(Time * _mainBendSpeed * windDir) )  * windStrength;
				mainDeformation.y = 0;
				//create a mask based on distance from the object pivot point 
				mainDeformationMask = length(originalPositionB.xyz - pivot) * _mainBendFalloff;
				// Smooth bending factor similar to triangle waves
				mainDeformationMask += 1.0;  
				mainDeformationMask *= mainDeformationMask;  
				mainDeformationMask = mainDeformationMask * mainDeformationMask - mainDeformationMask;  
				// Rescale  
				deformedPositionB.xyz += mainDeformation * mainDeformationMask*  _mainBendStrength;  
				
				//branch bending B
				branchDeformation = SmoothTriangleWave( (deformedPositionB.xyz / _branchBendSize) + (_branchBendSpeed * Time) + variation)  * windStrength;
				branchDeformation.xz = 0;	
				branchDeformation *=  IN.color.z *  _branchBendStrength; 
				deformedPositionB.xyz +=   branchDeformation ;	
				 
				//edge bending B
				edgeDeformation = SmoothTriangleWave(windDir * ((originalPositionB.xyz / _edgeBendSize) + (_edgeBendSpeed * Time)) + variation)  * windStrength;
				edgeDeformation.y = 0;	
				edgeDeformation *= (edgeDeformationMask * IN.normal ) *  _edgeBendStrength; 
				
				deformedPositionB.xyz +=   edgeDeformation;
				
				
				
				//new normals
				float3 normB =  normalize(deformedPositionB -  deformedPosition.xyz );
				float3 normT =  normalize(deformedPosition.xyz - deformedPositionT );	
				float3 normC = cross( normB, -normT );
				
				//transform the normals to object space like normal
				OUT.normalDir  = mul(  normC , float3x3(WorldInverseTranspose) );				
				OUT.binormalDir = mul(  normB , float3x3(WorldInverseTranspose) );				
				OUT.tangentDir = mul( normT , float3x3(WorldInverseTranspose) ); 
							
				
				OUT.posWorld = deformedPosition.xyz;
				OUT.viewDir = normalize( OUT.posWorld - _WorldSpaceCameraPos);

				deformedPosition = mul(WorldInverseTranspose, float4 (deformedPosition.xyz, 1))* unity_Scale.w;
				OUT.pos = mul(WorldViewProjection, deformedPosition);
				
				OUT.uvs = IN.texCoord;		
				
				
				
				return OUT;
			}
			fixed4 pShader(vert2Pixel IN): COLOR
			{
				half2 normalUVs = TRANSFORM_TEX(IN.uvs, _normalMap);
				fixed4 normalD = tex2D(_normalMap, normalUVs);
				normalD.xyz = (normalD.xyz * 2) - 1;
				
				//half3 normalDir = half3(2.0 * normalSample.xy - float2(1.0), 0.0);
				//deriving the z component
				//normalDir.z = sqrt(1.0 - dot(normalDir, normalDir));
               // alternatively you can approximate deriving the z component without sqrt like so: 
				//normalDir.z = 1.0 - 0.5 * dot(normalDir, normalDir);
				
				//pull the alpha out for spec before modification
				fixed3 normalDir = normalD.xyz;	
				fixed specMap = normalD.w;
				normalDir = normalize((normalDir.x * IN.tangentDir) + (normalDir.y * IN.binormalDir) + (normalDir.z * IN.normalDir));
						
				//Fill lights
				half3 pixelToLightSource =half3(_WorldSpaceLightPos0)- (IN.posWorld*_WorldSpaceLightPos0.w);
				fixed attenuation  = lerp(1.0, 1.0/ length(pixelToLightSource), _WorldSpaceLightPos0.w);				
				fixed3 lightDirection = normalize(pixelToLightSource);
				
				fixed diffuseL = lambert(normalDir, lightDirection);				
				fixed3 diffuseTotal = fixed3(_LightColor0)* diffuseL * attenuation;
				//specular highlight
				fixed specularHighlight = phong(reflect(IN.viewDir , normalDir) ,lightDirection)*attenuation;
				
				fixed4 outColor;							
				half2 diffuseUVs = TRANSFORM_TEX(IN.uvs, _diffuseMap);
				fixed4 texSample = tex2D(_diffuseMap, diffuseUVs);
				fixed3 diffuseS = (diffuseTotal * texSample.xyz) * _diffuseColor.xyz;
				fixed3 specular = specularHighlight * _specularColor * specMap;
				outColor = fixed4( diffuseS + specular,texSample.w);
				return outColor;
			}
			
			ENDCG
		}	
		
	}
}