using UnityEngine;
using UnityEditor;
using System.Collections;
using System.Collections.Generic;

public class DotaMaterialEditor : MaterialEditor {

	private ColorSpace	mColorSpace = ColorSpace.Uninitialized;

	public override void OnInspectorGUI()
	{
		base.OnInspectorGUI ();
		if (!isVisible)
			return;

		OnColorSpaceChange();
	}

	private void OnColorSpaceChange()
	{
		Material material = target as Material;
		if (PlayerSettings.colorSpace != mColorSpace)
		{
			mColorSpace = PlayerSettings.colorSpace;
			switch (PlayerSettings.colorSpace)
			{
			case ColorSpace.Gamma:
				material.EnableKeyword("_GAMMA_SPACE");
				material.DisableKeyword("_LINEAR_SPACE");
				EditorUtility.SetDirty(target);
				break;
			case ColorSpace.Linear:
				material.EnableKeyword("_LINEAR_SPACE");
               	material.DisableKeyword("_GAMMA_SPACE");
				EditorUtility.SetDirty(target);
				break;
			default:
				Debug.LogError("Color Space is Uninitialized.");
				break;
			}
		}
	}
}
