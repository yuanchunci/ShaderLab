using UnityEngine;
using System.Collections;

//[ExecuteInEditMode]
public class GrayScaleFx : BasePostProcessingFX {
	[Range(0,1)]
	public float weight;

	
	void OnRenderImage (RenderTexture source, RenderTexture destination) {
		material.SetFloat("_W", weight);
		Graphics.Blit (source, destination, material);
	}
}
