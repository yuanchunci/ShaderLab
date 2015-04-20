Shader "kokichi/Hidden/XRay Wall" {
	Properties {
		_behindwallColor ("Behind Wall Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}
 
	SubShader {
		Pass {
			Name "WALl"
			Cull Off
			ZWrite Off // dont write to z-buff to render xray color only
			ZTest Greater // further to camera will be render first

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it does not contain a surface program or both vertex and fragment programs.
#pragma exclude_renderers gles
			#pragma fragment frag
			fixed4	_behindwallColor;
			struct v2f
			{
				fixed4 color: COLOR;
			}; 
			
			fixed4 frag(v2f i) :COLOR {
				return fixed4(_behindwallColor);
			}
			ENDCG
		}
	 
	}
}