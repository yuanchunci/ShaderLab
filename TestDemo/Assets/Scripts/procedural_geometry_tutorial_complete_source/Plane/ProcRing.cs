using UnityEngine;
using System.Collections;

/// <summary>
/// A simple procedural quad mesh, generated using the MeshBuilder class.
/// </summary>
#if UNITY_EDITOR
using UnityEditor;
#endif

public class ProcRing : ProcBase
{
	public int m_RadialSegmentCount;
	public float m_Radius;

	public override Mesh BuildMesh()
	{
		//Create a new mesh builder:
		MeshBuilder meshBuilder = new MeshBuilder();
		
		////one-segment cylinder (build two rings, one at the bottom and one at the top):
		//BuildRing(meshBuilder, m_RadialSegmentCount, Vector3.zero, m_Radius, 0.0f, false);
		//BuildRing(meshBuilder, m_RadialSegmentCount, Vector3.up * m_Height, m_Radius, 1.0f, true);
		Vector3 centerPos = Vector3.zero;
		float angleInc = (Mathf.PI * 2.0f) / m_RadialSegmentCount;
		meshBuilder.Vertices.Add(centerPos );
		meshBuilder.Normals.Add(Vector3.zero);
		meshBuilder.UVs.Add(new Vector2(0.5f,0.5f));
		meshBuilder.colors.Add(new Color(0,0,0));
		for (int i = 0; i <= m_RadialSegmentCount; i++)
		{
			float angle = angleInc * i;
			
			Vector3 unitPosition = Vector3.zero;
			unitPosition.x = Mathf.Cos(angle);
			unitPosition.z = Mathf.Sin(angle);
			
			meshBuilder.Vertices.Add(centerPos + unitPosition * m_Radius);
			meshBuilder.Normals.Add(unitPosition);
			meshBuilder.UVs.Add(new Vector2(unitPosition.x * 0.5f + 0.5f, unitPosition.z * 0.5f + 0.5f));
			meshBuilder.colors.Add(new Color((float)i / m_RadialSegmentCount,0,0));
			if (i > 0)
			{
				int baseIndex = meshBuilder.Vertices.Count - 1;
				int index0 = 0;
				int index1 = baseIndex - 1;
				int index2 = baseIndex;
				Debug.Log(string.Format("index0: {0}, index1: {1}, index2: {2}", index0, index1, index2));
				meshBuilder.AddTriangle(index0, index1, index2);
			}
//			if( i == m_RadialSegmentCount)
//			{
//				int index0 = 0;
//				int index1 = meshBuilder.Vertices.Count - 1;
//				int index2 = 1;
//				Debug.Log(string.Format("index0: {0}, index1: {1}, index2: {2}", index0, index1, index2));
//				meshBuilder.AddTriangle(index0, index1, index2);
//			}


		}
		Mesh ret = meshBuilder.CreateMesh();
#if UNITY_EDITOR
		ret.name = "Ring";
		AssetDatabase.CreateAsset(ret, "Assets/ButterFly/" + ret.name + ".asset");
		AssetDatabase.SaveAssets();
#endif
		return ret;
	}
}
