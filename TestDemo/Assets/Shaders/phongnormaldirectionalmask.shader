//Phong CG shader with Up Vector Mask


Shader "CG Shaders/Phong/Phong Directional Mask"
{
	Properties
	{
		_diffuseColor("Diffuse Color", Color) = (1,1,1,1)
		_diffuseMap("Diffuse", 2D) = "white" {}
		_specularPower ("Specular Power", Range(1.0, 50.0)) = 10
		_specularPower (" ", Float) = 10
		_specularColor("Specular Color", Color) = (1,1,1,1)
		_normalMap("Normal / Specular (A)", 2D) = "bump" {}
		//textures 2
		_diffuseMap2("Frost Diffuse", 2D) = "white" {}	
		_specularPower2 ("Frost Specular Power", Range(1.0, 50.0)) = 10		
		_specularPower2 (" ", Float) = 10
		_specularColor2("Frost Specular Color", Color) = (1,1,1,1)
		_normalMap2("Frost Normal / Spec (A)", 2D) = "bump" {}
		//blend falloff
		_blendPower2 ("Frost Blend Sharpness", Range(0.1, 5.0)) = 1
		_blendPower2 (" ", Float) = 1
		//blend Offset
		_blendOffset2 ("Frost Blend Offset", Range(0.0, 1.0)) = 0
		_blendOffset2 (" ", Float) = 0
		//blend alpha
		_blendAlpha ("Frost Blend Alpha", Range(0.0, 1.0)) = 1
		_blendAlpha (" ", Float) = 1	
		//textures 3
		_ambientColorSnow("Snow Ambient Color", Color) = (0.05,0.5,0.05,1)
		_diffuseMap3("Snow Diffuse", 2D) = "white" {}	
		_specularPower3 ("Snow Specular Power", Range(1.0, 50.0)) = 10	
		_specularPower3 (" ", Float) = 10
		_specularColor3("Snow Specular Color", Color) = (1,1,1,1)
		_normalMap3("Snow Normal / Spec (A)", 2D) = "bump" {}
		//blend falloff
		_blendPower ("Snow Blend Sharpness", Range(1.0, 10.0)) = 5
		_blendPower (" ", Float) = 5
		//blend Offset
		_blendOffset ("Snow Blend Offset", Range(0.0, 1.0)) = 0.5
		_blendOffset (" ", Float) = 0.5		
		//blendMap
		_blendMap("Blend Mask", 2D) = "black" {}	
	}
	SubShader
	{
		Pass
		{
			Tags { "LightMode" = "ForwardBase" } 
            
			CGPROGRAM
			
			#pragma vertex vShader
			#pragma fragment pShader
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase		
			#pragma target 3.0
			
			uniform fixed3 _diffuseColor;
			uniform sampler2D _diffuseMap;
			uniform half4 _diffuseMap_ST;			
			uniform fixed4 _LightColor0; 
			uniform half _specularPower;
			uniform fixed3 _specularColor;
			uniform sampler2D _normalMap;
			uniform half4 _normalMap_ST;
			//texture2
			uniform sampler2D _diffuseMap2;
			uniform half4 _diffuseMap2_ST;				
			uniform half _specularPower2;
			uniform fixed3 _specularColor2;
			uniform sampler2D _normalMap2;
			uniform half4 _normalMap2_ST;	
			//blend falloff
			uniform half _blendPower;
			//blend Offset
			uniform fixed _blendOffset;	
			//blend Alpha
			uniform fixed _blendAlpha;
			//texture3
			uniform fixed4 _ambientColorSnow;
			uniform sampler2D _diffuseMap3;
			uniform half4 _diffuseMap3_ST;				
			uniform half _specularPower3;
			uniform fixed3 _specularColor3;
			uniform sampler2D _normalMap3;
			uniform half4 _normalMap3_ST;	
			//blend falloff
			uniform half _blendPower2;			
			//blend Offset
			uniform fixed _blendOffset2;		
			//blend map
			uniform sampler2D _blendMap;
			uniform half4 _blendMap_ST;
			
			
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
				half2 uvs						:	TEXCOORD0;
				fixed3 normalDir					:	TEXCOORD1;	
				fixed3 binormalDir					:	TEXCOORD2;	
				fixed3 tangentDir					:	TEXCOORD3;	
				half3 posWorld						:	TEXCOORD4;	
				fixed3 viewDir						:	TEXCOORD5;
				fixed3 lighting						:	TEXCOORD6;
				//vertex colors
				fixed4 color						:	TEXCOORD7;
			};
			
			fixed lambert(fixed3 N, fixed3 L)
			{
				return saturate(dot(N, L));
			}
			fixed frensel(fixed3 V, fixed3 N, half P)
			{	
				return pow(1 - saturate(dot(V,N)), P);
			}
			fixed phong(fixed3 R, fixed3 L, half P)
			{
				return pow(saturate(dot(R, L)), P);
			}
			vert2Pixel vShader(app2vert IN)
			{
				vert2Pixel OUT;
				float4x4 WorldViewProjection = UNITY_MATRIX_MVP;
				float4x4 WorldInverseTranspose = _World2Object; 
				float4x4 World = _Object2World;
							
				OUT.pos = mul(WorldViewProjection, IN.vertex);
				OUT.uvs = IN.texCoord.xy;	
				
				OUT.normalDir = normalize(mul(IN.normal, WorldInverseTranspose).xyz);
				OUT.tangentDir = normalize(mul(IN.tangent, WorldInverseTranspose).xyz);
				OUT.binormalDir = normalize(cross(OUT.normalDir, OUT.tangentDir)); 
				OUT.posWorld = mul(World, IN.vertex).xyz;
				OUT.viewDir = normalize(_WorldSpaceCameraPos - OUT.posWorld);
				//pass the colors to the pixel shader
				OUT.color  = IN.color;

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
				//create the blend mask
				fixed4 blendMask = -IN.color*.5 +.5;
				
				//create an upVector Mask like with rim light
				//get a dot product mask of the normals vs the up vector
				//Up vector mask only takes vertex normals into account
				//potentially could be moved to take the base normal map into account but tends to be more inconsistant
				//i find a blend map is sufficient to get details like cracks into the mask
				half upMask = dot(fixed3(0,1,0),IN.normalDir);
				//sample the blend mask
				half2 blendUVs =  TRANSFORM_TEX(IN.uvs, _blendMap); 
				fixed4 blendSample = tex2D(_blendMap, blendUVs);
				//multiply the upMask by the blend mask and readd the blend back in, to prevent going to 0 accidently
				half upMaskMod1 = (upMask*blendSample.r)+upMask;
				//add to the blend mask to allow it to fully remove snow
				//we add in the offset to allow the blend mask to be painted out and multiply by 2 to increase the strength
				blendMask.r += ((upMaskMod1+_blendOffset)*blendMask.r)*2;
				//because ice is more visible on downwards facing areas, we reverse the blend mask
				//this keeps the upVector mask from reversing the mask on iced areas
				//slightly hacky but since all areas where the mask would be incorrect are covered by snow, no one will notice
				half upMaskMod2 = (upMask*-blendSample.r)+upMask;
				//add to the blend mask to allow it to fully remove snow
				//we add in the offset to allow the blend mask to be painted out and multiply by 2 to increase the strength
				blendMask.g += ((upMaskMod2+(_blendOffset+_blendOffset2))*blendMask.g)*2;
				//offset and power according to parameters. Saturate to contain between 1 and 0
				half upMask1 = (upMaskMod1+_blendOffset) - blendMask.r;
				//for some reason unity requires me to saturate the mask prior to Powering and saturating AGAIN :/
				//otherwise it adds the reverse in? IDK stupid
				upMask1 = saturate(upMask1);					
				upMask1 = saturate(pow(upMask1,_blendPower));
				//offset and power according to parameters. Saturate to contain between 1 and 0
				//since we want ice to extend beyond snow, we add its offset to the snow offset prior to powering
				//subtract the inverse of the green channel to allow ice to be blended out prior to powering
				half upMask2 = (upMaskMod2+(_blendOffset+_blendOffset2))- blendMask.g;
				//double saturate again... stupid
				upMask2 = saturate(upMask2);					
				upMask2 = saturate(pow(upMask2,_blendPower2));
				//multiply the frost mask by the alpha, to allow it to have some transparency
				upMask2 *= _blendAlpha;
								
				//base normals
				half2 normalUVs = TRANSFORM_TEX(IN.uvs, _normalMap);
				fixed4 normalD = tex2D(_normalMap, normalUVs);
				//unpack normals
				normalD.xyz = (normalD.xyz * 2) - 1;
				//sample the ice normal map
				half2 normalUVs2 = TRANSFORM_TEX(IN.uvs, _normalMap2);
				fixed4 normalD2 = tex2D(_normalMap2, normalUVs2);
				normalD2.xyz = (normalD2.xyz * 2) - 1;		
				//lerp between the base and the ice
				fixed4 normalSampleTotal = lerp(normalD, normalD2, upMask2);
				//sample the snow normal map
				half2 normalUVs3 = TRANSFORM_TEX(IN.uvs, _normalMap3);
				fixed4 normalD3 = tex2D(_normalMap3, normalUVs3);
				normalD3.xyz  = (normalD3.xyz * 2) - 1;	
				//lerp the third in
				normalSampleTotal = lerp(normalSampleTotal, normalD3, upMask1);
			
				//half3 normalDir = half3(2.0 * normalSample.xy - float2(1.0), 0.0);
				//deriving the z component
				//normalDir.z = sqrt(1.0 - dot(normalDir, normalDir));
               // alternatively you can approximate deriving the z component without sqrt like so:  
				//normalDir.z = 1.0 - 0.5 * dot(normalDir, normalDir);
				
				fixed3 normalDir = normalSampleTotal.xyz;	
				fixed specMap = normalD.w;
				normalDir = normalize((normalDir.x * IN.tangentDir) + (normalDir.y * IN.binormalDir) + (normalDir.z * IN.normalDir));
				
	
				fixed3 ambientL = lerp(UNITY_LIGHTMODEL_AMBIENT, _ambientColorSnow, upMask1).xyz;
				
				half3 pixelToLightSource =_WorldSpaceLightPos0.xyz - (IN.posWorld*_WorldSpaceLightPos0.w);
				fixed attenuation  = lerp(1.0, 1.0/ length(pixelToLightSource), _WorldSpaceLightPos0.w);				
				fixed3 lightDirection = normalize(pixelToLightSource);
				fixed diffuseL = lambert(normalDir, lightDirection);			
				
				//removed the rim light.
				//the second ambient color should work better for this one
				fixed3 diffuse = _LightColor0.xyz * diffuseL * attenuation;
				diffuse = saturate(IN.lighting + ambientL + diffuse);
				
				//lerp the specular Powers
				fixed specularPowerTotal = lerp(_specularPower, _specularPower2, upMask2);
				specularPowerTotal = lerp(specularPowerTotal, _specularPower3, upMask1);
				fixed specularHighlight = phong(-reflect(IN.viewDir , normalDir) ,lightDirection, specularPowerTotal);
				
				fixed4 outColor;							
				half2 diffuseUVs = TRANSFORM_TEX(IN.uvs, _diffuseMap);
				fixed3 texSample = tex2D(_diffuseMap, diffuseUVs);
				//sample the second map
				half2 diffuseUVs2 = TRANSFORM_TEX(IN.uvs, _diffuseMap2);
				fixed3 texSample2 = tex2D(_diffuseMap2, diffuseUVs2);
				//lerp between the first 2
				fixed3 texSampleTotal = lerp(texSample, texSample2, upMask2);
				//sample the third map
				half2 diffuseUVs3 = TRANSFORM_TEX(IN.uvs, _diffuseMap3);
				fixed3 texSample3 = tex2D(_diffuseMap3, diffuseUVs3);
				//lerp the 3rd map in
				texSampleTotal = lerp(texSampleTotal, texSample3, upMask1);
				
				fixed3 diffuseS = (diffuse * texSampleTotal) * _diffuseColor;
				//lerp the specular Colors
				fixed3 specularColorTotal = lerp(_specularColor, _specularColor2, upMask2);
				specularColorTotal = lerp(specularColorTotal, _specularColor3, upMask1);
				fixed3 specular = (specularHighlight * specularColorTotal * specMap);
				outColor = fixed4( diffuseS + specular,1.0);
				return outColor;
			}
			
			ENDCG
		}	
		
		Pass
		{
			Tags { "LightMode" = "ForwardAdd" } 
			Blend One One 
            
			CGPROGRAM
			
			#pragma vertex vShader
			#pragma fragment pShader
			#include "UnityCG.cginc"	
			#pragma target 3.0
			
			uniform fixed3 _diffuseColor;
			uniform sampler2D _diffuseMap;
			uniform half4 _diffuseMap_ST;			
			uniform fixed4 _LightColor0; 
			uniform half _specularPower;
			uniform fixed3 _specularColor;
			uniform sampler2D _normalMap;
			uniform half4 _normalMap_ST;
			//texture2
			uniform sampler2D _diffuseMap2;
			uniform half4 _diffuseMap2_ST;				
			uniform half _specularPower2;
			uniform fixed3 _specularColor2;
			uniform sampler2D _normalMap2;
			uniform half4 _normalMap2_ST;	
			//blend falloff
			uniform half _blendPower;
			//blend Offset
			uniform fixed _blendOffset;	
			//blend Alpha
			uniform fixed _blendAlpha;
			//texture3
			uniform fixed4 _ambientColorSnow;
			uniform sampler2D _diffuseMap3;
			uniform half4 _diffuseMap3_ST;				
			uniform half _specularPower3;
			uniform fixed3 _specularColor3;
			uniform sampler2D _normalMap3;
			uniform half4 _normalMap3_ST;	
			//blend falloff
			uniform half _blendPower2;			
			//blend Offset
			uniform fixed _blendOffset2;		
			//blend map
			uniform sampler2D _blendMap;
			uniform half4 _blendMap_ST;
			
			
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
				half2 uvs						:	TEXCOORD0;
				fixed3 normalDir					:	TEXCOORD1;	
				fixed3 binormalDir					:	TEXCOORD2;	
				fixed3 tangentDir					:	TEXCOORD3;	
				half3 posWorld						:	TEXCOORD4;	
				fixed3 viewDir						:	TEXCOORD5;
				//vertex colors
				fixed4 color						:	TEXCOORD6;
			};
			
			fixed lambert(fixed3 N, fixed3 L)
			{
				return saturate(dot(N, L));
			}
			fixed frensel(fixed3 V, fixed3 N, half P)
			{	
				return pow(1 - saturate(dot(V,N)), P);
			}
			fixed phong(fixed3 R, fixed3 L, half P)
			{
				return pow(saturate(dot(R, L)), P);
			}
			vert2Pixel vShader(app2vert IN)
			{
				vert2Pixel OUT;
				float4x4 WorldViewProjection = UNITY_MATRIX_MVP;
				float4x4 WorldInverseTranspose = _World2Object; 
				float4x4 World = _Object2World;
							
				OUT.pos = mul(WorldViewProjection, IN.vertex);
				OUT.uvs = IN.texCoord.xy;	
				
				OUT.normalDir = normalize(mul(IN.normal, WorldInverseTranspose).xyz);
				OUT.tangentDir = normalize(mul(IN.tangent, WorldInverseTranspose).xyz);
				OUT.binormalDir = normalize(cross(OUT.normalDir, OUT.tangentDir)); 
				OUT.posWorld = mul(World, IN.vertex).xyz;
				OUT.viewDir = normalize(_WorldSpaceCameraPos - OUT.posWorld);
				//pass the colors to the pixel shader
				OUT.color  = IN.color;
				
				return OUT;
			}
			
			fixed4 pShader(vert2Pixel IN): COLOR
			{
				//create the blend mask
				fixed4 blendMask = -IN.color*.5 +.5;
				
				//create an upVector Mask like with rim light
				//get a dot product mask of the normals vs the up vector
				//Up vector mask only takes vertex normals into account
				//potentially could be moved to take the base normal map into account but tends to be more inconsistant
				//i find a blend map is sufficient to get details like cracks into the mask
				half upMask = dot(fixed3(0,1,0),IN.normalDir);
				//sample the blend mask
				half2 blendUVs =  TRANSFORM_TEX(IN.uvs, _blendMap); 
				fixed4 blendSample = tex2D(_blendMap, blendUVs);
				//multiply the upMask by the blend mask and readd the blend back in, to prevent going to 0 accidently
				half upMaskMod1 = (upMask*blendSample.r)+upMask;
				//add to the blend mask to allow it to fully remove snow
				//we add in the offset to allow the blend mask to be painted out and multiply by 2 to increase the strength
				blendMask.r += ((upMaskMod1+_blendOffset)*blendMask.r)*2;
				//because ice is more visible on downwards facing areas, we reverse the blend mask
				//this keeps the upVector mask from reversing the mask on iced areas
				//slightly hacky but since all areas where the mask would be incorrect are covered by snow, no one will notice
				half upMaskMod2 = (upMask*-blendSample.r)+upMask;
				//add to the blend mask to allow it to fully remove snow
				//we add in the offset to allow the blend mask to be painted out and multiply by 2 to increase the strength
				blendMask.g += ((upMaskMod2+(_blendOffset+_blendOffset2))*blendMask.g)*2;
				//offset and power according to parameters. Saturate to contain between 1 and 0
				half upMask1 = (upMaskMod1+_blendOffset) - blendMask.r;
				//for some reason unity requires me to saturate the mask prior to Powering and saturating AGAIN :/
				//otherwise it adds the reverse in? IDK stupid
				upMask1 = saturate(upMask1);					
				upMask1 = saturate(pow(upMask1,_blendPower));
				//offset and power according to parameters. Saturate to contain between 1 and 0
				//since we want ice to extend beyond snow, we add its offset to the snow offset prior to powering
				//subtract the inverse of the green channel to allow ice to be blended out prior to powering
				half upMask2 = (upMaskMod2+(_blendOffset+_blendOffset2))- blendMask.g;
				//double saturate again... stupid
				upMask2 = saturate(upMask2);					
				upMask2 = saturate(pow(upMask2,_blendPower2));
				//multiply the frost mask by the alpha, to allow it to have some transparency
				upMask2 *= _blendAlpha;
								
				//base normals
				half2 normalUVs = TRANSFORM_TEX(IN.uvs, _normalMap);
				fixed4 normalD = tex2D(_normalMap, normalUVs);
				//unpack normals
				normalD.xyz = (normalD.xyz * 2) - 1;
				//sample the ice normal map
				half2 normalUVs2 = TRANSFORM_TEX(IN.uvs, _normalMap2);
				fixed4 normalD2 = tex2D(_normalMap2, normalUVs2);
				normalD2.xyz = (normalD2.xyz * 2) - 1;		
				//lerp between the base and the ice
				fixed4 normalSampleTotal = lerp(normalD, normalD2, upMask2);
				//sample the snow normal map
				half2 normalUVs3 = TRANSFORM_TEX(IN.uvs, _normalMap3);
				fixed4 normalD3 = tex2D(_normalMap3, normalUVs3);
				normalD3.xyz  = (normalD3.xyz * 2) - 1;	
				//lerp the third in
				normalSampleTotal = lerp(normalSampleTotal, normalD3, upMask1);
			
				//half3 normalDir = half3(2.0 * normalSample.xy - float2(1.0), 0.0);
				//deriving the z component
				//normalDir.z = sqrt(1.0 - dot(normalDir, normalDir));
               // alternatively you can approximate deriving the z component without sqrt like so:  
				//normalDir.z = 1.0 - 0.5 * dot(normalDir, normalDir);
				
				fixed3 normalDir = normalSampleTotal.xyz;	
				fixed specMap = normalD.w;
				normalDir = normalize((normalDir.x * IN.tangentDir) + (normalDir.y * IN.binormalDir) + (normalDir.z * IN.normalDir));
				
				//Fill lights
				half3 pixelToLightSource = _WorldSpaceLightPos0.xyz- (IN.posWorld*_WorldSpaceLightPos0.w);
				fixed attenuation  = lerp(1.0, 1.0/ length(pixelToLightSource), _WorldSpaceLightPos0.w);				
				fixed3 lightDirection = normalize(pixelToLightSource);
				
				fixed diffuseL = lambert(normalDir, lightDirection);				
				fixed3 diffuseTotal = _LightColor0.xyz * diffuseL * attenuation;
				
				//lerp the specular Powers
				fixed specularPowerTotal = lerp(_specularPower, _specularPower2, upMask2);
				specularPowerTotal = lerp(specularPowerTotal, _specularPower3, upMask1);
				fixed specularHighlight = phong(-reflect(IN.viewDir , normalDir) ,lightDirection, specularPowerTotal);
				
				fixed4 outColor;							
				half2 diffuseUVs = TRANSFORM_TEX(IN.uvs, _diffuseMap);
				fixed3 texSample = tex2D(_diffuseMap, diffuseUVs);
				//sample the second map
				half2 diffuseUVs2 = TRANSFORM_TEX(IN.uvs, _diffuseMap2);
				fixed3 texSample2 = tex2D(_diffuseMap2, diffuseUVs2);
				//lerp between the first 2
				fixed3 texSampleTotal = lerp(texSample, texSample2, upMask2);
				//sample the third map
				half2 diffuseUVs3 = TRANSFORM_TEX(IN.uvs, _diffuseMap3);
				fixed3 texSample3 = tex2D(_diffuseMap3, diffuseUVs3);
				//lerp the 3rd map in
				texSampleTotal = lerp(texSampleTotal, texSample3, upMask1);
				
				fixed3 diffuseS = (diffuseTotal * texSampleTotal) * _diffuseColor;
				//lerp the specular Colors
				fixed3 specularColorTotal = lerp(_specularColor, _specularColor2, upMask2);
				specularColorTotal = lerp(specularColorTotal, _specularColor3, upMask1);
				fixed3 specular = (specularHighlight * specularColorTotal * specMap);
				outColor = fixed4( diffuseS + specular,1.0);
				return outColor;
			}
			
			ENDCG
		}	
		
	}
}