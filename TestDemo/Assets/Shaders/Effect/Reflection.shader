Shader "kokichi/Fx/Reflection" {
   Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Main Color", Color) = (1,1,1,1)
		_Cube("Reflection Map", Cube) = "" {}
		_Strength("Reflection Strength", Float) = 1
		_LightTransmissionColor ("Light Transmission Color", Color) = (1,1,1,1) 
		_TransPower ("Translucency Power", Range(1.0, 10.0)) = 3
		_TransPower (" ", Float) = 3
		_transDistortion ("Translucency Distortion", Range(0.0, 1.0)) = 1
		_transDistortion (" ", Float) = 1
		_transScale ("Translucency Scale", Range(0.0, 1.0)) = 1
		_transScale (" ", Float) = 1
		lightDirection("Light Dir", Vector) = (1,1,1,0)
   }
   SubShader {
   	  Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
      Pass {   
 		 Blend SrcAlpha OneMinusSrcAlpha
      	 
         CGPROGRAM
         #pragma vertex vert  
         #pragma fragment frag 

         #include "UnityCG.cginc"

         // User-specified uniforms
         uniform samplerCUBE _Cube;   
         uniform sampler2D _MainTex;   
         uniform fixed4 _Color;   
         uniform fixed _Strength;   
		uniform fixed4 _LightTransmissionColor; 
		half _TransPower;
		half _transScale;
		fixed _transDistortion;
		fixed4 lightDirection;
		
         struct app_data {
            fixed4 vertex : POSITION;
            fixed3 normal : NORMAL;
            fixed2 uv : TEXCOORD0;
         };
         
         struct v2f {
            fixed4 pos : SV_POSITION;
            fixed2 uv : TEXCOORD0;
            fixed3 normalDir : TEXCOORD1;
            fixed3 viewDir : TEXCOORD2;
         };
 
         v2f vert(app_data input) 
         {
            v2f output;
            fixed4x4 modelMatrix = _Object2World;
            fixed4x4 modelMatrixInverse = _World2Object; 
            output.viewDir = mul(modelMatrix, input.vertex).xyz - _WorldSpaceCameraPos;
            output.normalDir = normalize(mul(fixed4(input.normal, 0.0), modelMatrixInverse).xyz);
            output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
            output.uv = input.uv;
            return output;
         }
 
         fixed4 frag(v2f input) : COLOR
         {
         	half3 distortedLightV = -lightDirection + input.normalDir * _transDistortion;
			fixed trans = pow(saturate(dot(-distortedLightV, input.viewDir)), _TransPower);
			fixed3 transColor = trans * _LightTransmissionColor.xyz * _transScale;
			//multiply transmission by alpha
				
         	fixed4 finalColor = (tex2D(_MainTex, input.uv) + fixed4(transColor,1)) * _Color ;
            fixed3 reflectedDir = reflect(input.viewDir, normalize(input.normalDir));
            return lerp(finalColor, texCUBE(_Cube, reflectedDir), _Strength);
         }
 
         ENDCG
      }
   }
}