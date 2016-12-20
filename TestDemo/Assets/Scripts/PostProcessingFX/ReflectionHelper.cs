using UnityEngine;
using System.Collections;

public class ReflectionHelper : MonoBehaviour {

	void OnWillRenderObject()
	{
//		if( Camera.current.name != "reflectionCam" ) return;
		foreach (Material mat in renderer.materials)
		{
			mat.SetTexture("_MainTex", mat.GetTexture("_basetexture"));
//			mat
		}
	
	}


}
