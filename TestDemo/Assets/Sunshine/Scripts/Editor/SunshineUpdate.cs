using UnityEngine;
using UnityEditor;
using System.Collections;
using System.IO;

[InitializeOnLoad]
public class SunshineUpdate
{
    static SunshineUpdate()
    {
			EditorApplication.update += FinishedLoading;
	}
	static void FinishedLoading()
	{
		const string legacyConfigurationPath = "Assets/Sunshine/Configuration.asset";
		SunshineProjectPreferences oldPreferences = File.Exists(legacyConfigurationPath) ? AssetDatabase.LoadMainAssetAtPath(legacyConfigurationPath) as SunshineProjectPreferences : null;
		if(oldPreferences)
		{
			Debug.Log("Sunshine: Migrating Project settings from old version");
			SunshineProjectPreferences.Instance.UseCustomShadows = oldPreferences.UseCustomShadows;
			SunshineProjectPreferences.Instance.ForwardShadersInstalled = oldPreferences.ForwardShadersInstalled;
			SunshineProjectPreferences.Instance.ManualShaderInstallation = oldPreferences.ManualShaderInstallation;
			SunshineProjectPreferences.Instance.SaveIfDirty();
			AssetDatabase.DeleteAsset(legacyConfigurationPath);
		}
		
		if(SunshineProjectPreferences.Instance.Version != Sunshine.Version)
			SunshineProjectPreferences.Instance.Version = Sunshine.Version;
		
		EditorApplication.update -= FinishedLoading;
	}
}
