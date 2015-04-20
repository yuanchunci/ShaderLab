using UnityEngine;
using System.Collections;

public class GenerateDepthTexture : MonoBehaviour {

	public bool enable;
	// Use this for initialization
	void Start () {
		camera.depthTextureMode = DepthTextureMode.Depth;
	}

	void Update()
	{
		if(enable && camera.depthTextureMode != DepthTextureMode.Depth)
		{
			camera.depthTextureMode = DepthTextureMode.Depth;
		}else if(!enable && camera.depthTextureMode == DepthTextureMode.Depth)
		{
			camera.depthTextureMode = DepthTextureMode.None;
		}
	}
	

}
