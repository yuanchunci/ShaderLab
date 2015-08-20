using UnityEngine;
using System.Collections;

public class ChangeShader : MonoBehaviour {
	public Shader diffuse;
	public Shader transparent;
	public Shader cutout;
	public Material mat;
	void OnGUI()
	{
		if(GUI.Button(new Rect(0,0,50,50),"diffuse"))
		{
			mat.shader = diffuse;
		}

		if(GUI.Button(new Rect(0,50,50,50),"transparent"))
		{
			mat.shader = transparent;
		}

		if(GUI.Button(new Rect(0,100,50,50),"cutout"))
		{
			mat.shader = cutout;
		}
	}

	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
