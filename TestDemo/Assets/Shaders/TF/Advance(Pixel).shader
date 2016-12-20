Shader "kokichi/TF/Pixel Lighting" {
    Properties {
        _MainColor ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Diffuse (RGB)", 2D) = "white" {}
        _RampTex ("Diffuse Warp (RGB)", 2D) = "white" {}
        _RimColor ("Rim Color", Color) = (0.97,0.88,1,0.75)
        _RimPower ("Rim Power", Float) = 2.5
        _SpecularExponent("Specular Exp", Float) = 128
        _SpecularMask ("Specular Level (R) Gloss (G) Rim Mask (B)", 2D) = "gray" {}
    }
 
    SubShader{
        Tags { "RenderType" = "Opaque" "LIGHTMODE"="ForwardBase" }
 		Pass 
 		{
        	CGPROGRAM
        	
 			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc" 
			#include "Lighting.cginc" 
			
			struct app_data
			{
				fixed4 vertex : POSITION;
				float3 normal : NORMAL;
				fixed4 texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				fixed4 pos : SV_POSITION;
				fixed2 tex : TEXCOORD0;
				fixed3 normalDir : TEXCOORD1;
				fixed3 viewDir : TEXCOORD2;
			};
			
            fixed4 _MainColor;
			sampler2D _MainTex, _SpecularMask, _RampTex;
            fixed _SpecularExponent;
            fixed4 _RimColor;
            fixed _RimPower;
			
			v2f vert(app_data input)
			{
				v2f output;
				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				fixed4 worldPos = mul(_Object2World, input.vertex);
				
				fixed3x3 modelMatrix = _Object2World;
				fixed3x3 modelMatrixInverse = _World2Object; 
				
				fixed3 normalDir = normalize(mul(input.normal, modelMatrixInverse)); 
				fixed3 viewDir = normalize(_WorldSpaceCameraPos - worldPos.xyz);
				
				output.tex = input.texcoord.xy;
				output.normalDir = normalDir;
				output.viewDir = viewDir;
				
				return output;
				
			}
			
			fixed4 frag(v2f input) : COLOR
			{
				fixed4 finalColor;
				fixed4 color = tex2D(_MainTex, input.tex) * _MainColor;
				fixed4 specMask = tex2D(_SpecularMask, input.tex);
				
				fixed atten = 2.0;
				fixed3 normalDir = input.normalDir;
				fixed3 viewDir = input.viewDir;
				fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
				
				fixed NdotL = dot(normalDir, lightDir) * 0.5f + 0.5f;
				fixed diffuse = NdotL * atten;
				fixed3 diffuseWarp = tex2D(_RampTex, fixed2(diffuse));
				
				fixed3 H = normalize(lightDir + viewDir);
				fixed NdotH = max(0, dot(normalDir, H));
				fixed spec = pow(NdotH, _SpecularExponent) * saturate(NdotL);
				
				fixed3 rim = pow( max(0, dot(fixed3(0,1,0), normalDir)), _RimPower) * _RimColor;
				
				
				fixed3 diffuseLight = diffuseWarp * _LightColor0.rgb;
				fixed3 specLight = spec * _LightColor0.rgb * specMask.r;
				fixed3 rimLight = rim * specMask.b;
				
//				finalColor.rgb = diffuseLight;
				finalColor.rgb = color.rgb * diffuseLight;
				finalColor.rgb += specLight;
				finalColor.rgb += rimLight;
				finalColor.a = color.a;
				
				return finalColor;
			}
			
        	ENDCG
 			
 		}
           
    }
}