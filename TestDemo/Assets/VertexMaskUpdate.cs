using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class VertexMaskUpdate : MonoBehaviour {
	public AnimationCurve graph;
	private ParticleSystem ps;
	// Use this for initialization
	void Start () {
		ps = GetComponent<ParticleSystem>();

	}
	
	// Update is called once per frame
	void Update () {
		if(ps != null)
		{
			float value = graph.Evaluate(ps.time/ ps.duration);
			ps.renderer.sharedMaterial.SetFloat("_Alpha", value);
		}
	}
}
