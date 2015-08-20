using UnityEngine;
using System.Collections;

public class MotionBlurWithVelocBuffer2 : BasePostProcessingFX {
	[Range(0,1)]
	public float weight;
	[Range(0,1)]
	public float extraMask;
	public Shader writeVelocityShader;
	public LayerMask MotionBlurLayers = ~0;
	public int renderTextureScale = 16;
	private bool isRun = true;
	private Camera motionVectorCamera;
	private RenderTexture velocityTex;
	private RenderTexture rt;
	// Use this for initialization
	void Awake () {
		motionVectorCamera = new GameObject("MotionVectorCamera").AddComponent<Camera>();
		motionVectorCamera.enabled = false;
	}

	void OnGUI()
	{
		if(GUI.Button(new Rect(0,0,50,50), "Motion " + isRun))
		{
			isRun = !isRun;

		}
	}
	
	void OnDisable()
	{
		DestroyImmediate(material);
		DestroyImmediate(rt);
	}
	
	void OnRenderImage (RenderTexture source, RenderTexture destination) {
		if (rt == null || rt.width != source.width || rt.height != source.height)
		{
			DestroyImmediate(rt);
			rt = new RenderTexture(source.width, source.height, 0);
			rt.hideFlags = HideFlags.HideAndDontSave;
			Graphics.Blit( source, rt );
		}
		material.SetFloat("_AccumOrig", 1 - weight);
		material.SetTexture("_MainText", rt);
		material.SetTexture("_VelocTex",velocityTex);
		rt.MarkRestoreExpected();
		Graphics.Blit (source, rt, material);
		Graphics.Blit (rt, destination);
		CleanUpTexture();
	}

	void OnPreRender() {
		if(!isRun) return;
		CleanUpTexture();
		velocityTex = RenderTexture.GetTemporary((int)camera.pixelWidth/renderTextureScale,
		                                         (int)camera.pixelHeight/renderTextureScale, 0, RenderTextureFormat.R8);
		Shader.SetGlobalFloat("_extraMask",extraMask);
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
