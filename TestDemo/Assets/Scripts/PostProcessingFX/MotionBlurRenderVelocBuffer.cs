using UnityEngine;
using System.Collections;

public class MotionBlurRenderVelocBuffer : MonoBehaviour {
	// the shader used to render motion vectors
	public Shader MotionVelocShader;
	public LayerMask MotionBlurLayers = ~0;
	private Camera motionVectorCamera;

	void Awake()
	{
		
		// set up the motion vector camera
		motionVectorCamera = new GameObject("MotionVectorCamera").AddComponent<Camera>();
		motionVectorCamera.transform.parent = transform;
		motionVectorCamera.transform.localPosition = Vector3.zero;
		motionVectorCamera.transform.localRotation = Quaternion.identity;
		motionVectorCamera.backgroundColor = new Color( 0f, 0f, 0f, 0f );
		motionVectorCamera.renderingPath = RenderingPath.Forward;
		motionVectorCamera.cullingMask = MotionBlurLayers;
		
		motionVectorCamera.SetReplacementShader( MotionVelocShader, null );
		
		// disable camera
		// we'll manually render it when needed
		motionVectorCamera.enabled = false;
	}


	void OnRenderImage( RenderTexture src, RenderTexture dest )
	{
		motionVectorCamera.fieldOfView = camera.fieldOfView;
		motionVectorCamera.nearClipPlane = camera.nearClipPlane;
		motionVectorCamera.farClipPlane = camera.farClipPlane;

		// get temporary render texture for motion vectors
		RenderTexture motionVectors = RenderTexture.GetTemporary( src.width / 2, src.height / 2, 0, RenderTextureFormat.ARGBFloat );
		
		// render motion vector camera
		motionVectorCamera.targetTexture = motionVectors;
		motionVectorCamera.Render();

		Graphics.Blit( src, dest );

		RenderTexture.ReleaseTemporary( motionVectors );
	}
}
