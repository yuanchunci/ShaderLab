using UnityEngine;
using System.Collections;

public class MotionBlurWithVelocBuffer : BasePostProcessingFX {
	public Shader writeVelocityShader;
	public float velocityScale = 1;
	public LayerMask MotionBlurLayers = ~0;
	private Camera motionVectorCamera;
	private RenderTexture velocityTex;

	void Awake()
	{
		
		// set up the motion vector camera
		motionVectorCamera = new GameObject("MotionVectorCamera").AddComponent<Camera>();
		motionVectorCamera.enabled = false;

		
//		motionVectorCamera.SetReplacementShader( writeVelocityShader, null );
		
		// disable camera
		// we'll manually render it when needed
	}
	
	void OnRenderImage( RenderTexture src, RenderTexture dest )
	{
		material.SetTexture("_VelocTex",velocityTex);
		material.SetFloat("_VelocScale",velocityScale);
		Graphics.Blit(src,dest,material);
		CleanUpTexture();
	}

	void OnPreRender() {
		CleanUpTexture();
		velocityTex = RenderTexture.GetTemporary((int)camera.pixelWidth/2,
		                                         (int)camera.pixelHeight/2, 0, RenderTextureFormat.RGFloat);
		motionVectorCamera.CopyFrom(camera);
		motionVectorCamera.backgroundColor = Color.black;
		motionVectorCamera.renderingPath = RenderingPath.Forward;
		motionVectorCamera.clearFlags = CameraClearFlags.SolidColor;
		motionVectorCamera.cullingMask = MotionBlurLayers;
		motionVectorCamera.targetTexture = velocityTex;
		motionVectorCamera.RenderWithShader( writeVelocityShader, null );
		
	}

	void CleanUpTexture ()
	{
		if(velocityTex)
		{
			RenderTexture.ReleaseTemporary(velocityTex);
			velocityTex = null;
		}
	}
}
