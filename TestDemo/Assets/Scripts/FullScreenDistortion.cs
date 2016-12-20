using UnityEngine;
using System.Collections;

public class FullScreenDistortion : MonoBehaviour {
	public Material mat;
	public int widthCount = 35;
	public int heightCount = 25;
	public float width = 2;
	public float height = 2;
	public Vector3 startPos = new Vector3(-1,-1,0);
	private MeshBuilder meshBuilder;
	private Mesh mesh;
	// Use this for initialization
	void Start () {
		Debug.Log(">>>>>>>>> start game");
		meshBuilder = new MeshBuilder();
		for(int i = 0; i <= heightCount; ++i)
		{
			float v = i * 1.0f / heightCount;
			for(int j = 0; j <= widthCount; ++j)
			{
				float u = j * 1.0f / widthCount;
				float x = u * width;
				float y = v * height;
				Vector3 offset = new Vector3(startPos.x + x,startPos.y + y,0);
				Vector2 uv = new Vector2(u, v);
				bool isBuildTriangle = i > 0 && j > 0;
				meshBuilder.Vertices.Add(offset);
				meshBuilder.UVs.Add(uv);
				
				if (isBuildTriangle)
				{
					int baseIndex = meshBuilder.Vertices.Count - 1;
					
					int index0 = baseIndex;
					int index1 = baseIndex - 1;
					int index2 = baseIndex - widthCount - 1;
					int index3 = baseIndex - widthCount - 2;
					
					meshBuilder.AddTriangle(index0, index2, index1);
					meshBuilder.AddTriangle(index2, index3, index1);
				}
			}
		}

		mesh = meshBuilder.CreateMesh();

	}
	
	// Update is called once per frame
	void Update () {
		if(mesh != null )
		{
			Graphics.DrawMesh(mesh, Vector3.zero, Quaternion.identity, mat, 0, null, 0, null, false, false);
		}
	}
}
