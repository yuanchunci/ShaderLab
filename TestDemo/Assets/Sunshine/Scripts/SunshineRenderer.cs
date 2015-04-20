using UnityEngine;
using System.Collections;

/// <summary>
/// Gives granular control over a particular Renderer's shadow receieving.
/// This only works in Unity 4.1 or above since it requires Per-Material Keywords.
/// </summary>
[RequireComponent(typeof(Renderer))]
public class SunshineRenderer : MonoBehaviour
{
#if UNITY_4_1 || UNITY_4_2 || UNITY_4_3 || UNITY_4_4 || UNITY_4_5 || UNITY_4_6 || UNITY_4_7 || UNITY_4_8 || UNITY_4_9
	private bool _receiveShadows = true;
	private bool isDirty = true;
	private static readonly string[] disabledKeywords = new string[] { "SUNSHINE_DISABLED" };
	Material[] originalSharedMaterials;
	void Update()
	{
		bool newReceiveShadows = renderer.receiveShadows;
		if(_receiveShadows != newReceiveShadows)
		{
			_receiveShadows = newReceiveShadows;
			isDirty = true;
		}
		if(isDirty)
		{
			if(newReceiveShadows)
			{
				if(originalSharedMaterials != null)
					renderer.materials = originalSharedMaterials;
			}
			else
			{
				originalSharedMaterials = renderer.sharedMaterials;
				foreach(var mat in renderer.materials)
					mat.shaderKeywords = disabledKeywords;
			}
			isDirty = false;
		}
	}
#endif

}
