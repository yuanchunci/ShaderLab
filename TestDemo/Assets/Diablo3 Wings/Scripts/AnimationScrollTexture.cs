using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class AnimationScrollTexture : MonoBehaviour {

	public Vector2 veclocity;

	void Update()
	{
		Vector2 offset = Time.time * veclocity;
		renderer.sharedMaterial.mainTextureOffset = offset;
	}
}
