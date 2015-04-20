using UnityEngine;
using System.Collections;

//[ExecuteInEditMode]
public class MotionBlur : BasePostProcessingFX {
	[Range(0,1)]
	public float weight;
	private RenderTexture rt;


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
		rt.MarkRestoreExpected();
		Graphics.Blit (source, rt, material);
		Graphics.Blit (rt, destination);
	}
}
