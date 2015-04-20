using UnityEngine;
using System.Collections;

public class LightmapSetting : MonoBehaviour {
	public LightProbes lightProbes;
	public LightmapData lmData;
	// Use this for initialization
	void Start () {
		LightmapSettings.lightProbes = null;
		LightmapSettings.lightmaps = null;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
