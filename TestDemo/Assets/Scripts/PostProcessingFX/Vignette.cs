using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class Vignette : BasePostProcessingFX {
	[Range(0,6)]
	public float _VignettePower;
	private RenderTexture rt;


	void OnDisable()
	{
		DestroyImmediate(material);
		DestroyImmediate(rt);
	}
	
	void OnRenderImage (RenderTexture source, RenderTexture destination) {
		material.SetFloat("_VignettePower", _VignettePower);
		Graphics.Blit (source, destination, material);
	}
}
