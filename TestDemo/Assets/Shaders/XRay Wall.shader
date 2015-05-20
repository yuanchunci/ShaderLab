Shader "kokichi/Hidden/XRay Wall" {
	Properties {
		_behindwallColor ("Behind Wall Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}
 
	SubShader {
		Pass {
			Name "WALL"
			Cull Off
			ZWrite Off // dont write to z-buff to render xray color only
			ZTest Greater // further to camera will be render first

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
	        #pragma vertex vert
	        #pragma fragment frag
	        #include "UnityCG.cginc"
                
			fixed4	_behindwallColor;
			
			
			fixed4 vert (appdata_base v) : POSITION
	        {
	            return mul(UNITY_MATRIX_MVP, v.vertex);
	        }
                
			fixed4 frag() :COLOR {
				return fixed4(_behindwallColor);
			}
			ENDCG
		}
	 
	}
}