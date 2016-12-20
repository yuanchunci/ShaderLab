using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;

namespace ICode.UnityGUI{
	#if UNITY_4_6 || UNITY_4_7 || UNITY_5_0 || UNITY_5_1
	[AddComponentMenu("UI/Effects/Gradient",14)]
	public class Gradient : BaseVertexEffect {
		public Color32 topColor = Color.white;
		public Color32 bottomColor = Color.black;
		
		public override void ModifyVertices(List<UIVertex> vertexList) {
			if (!IsActive()) {
				return;
			}
			
			int count = vertexList.Count;
			float bottomY = vertexList[0].position.y;
			float topY = vertexList[0].position.y;
			
			for (int i = 1; i < count; i++) {
				float y = vertexList[i].position.y;
				if (y > topY) {
					topY = y;
				}
				else if (y < bottomY) {
					bottomY = y;
				}
			}
			
			float uiElementHeight = topY - bottomY;
			
			for (int i = 0; i < count; i++) {
				UIVertex uiVertex = vertexList[i];
				uiVertex.color = Color32.Lerp(bottomColor, topColor, (uiVertex.position.y - bottomY) / uiElementHeight);
				vertexList[i] = uiVertex;
			}
		}
	}
	#else
	[AddComponentMenu("UI/Effects/Gradient",14)]
	public class Gradient : BaseMeshEffect
	{
		public Color32 topColor = Color.white;
		public Color32 bottomColor = Color.black;
		
		public override void ModifyMesh(Mesh aMesh)
		{
			if (!IsActive()) {
				return;
			}
			
			Vector3[] vertexList = aMesh.vertices;
			int count = vertexList.Length;
			float bottomY = vertexList[0].y;
			float topY = vertexList[0].y;
			
			for (int i = 1; i < count; i++) {
				float y = vertexList[i].y;
				if (y > topY) {
					topY = y;
				}
				else if (y < bottomY) {
					bottomY = y;
				}
			}
			
			float uiElementHeight = topY - bottomY;
			
			Color[] colors = aMesh.colors;
			for (int i = 0; i < count; i++)
			{
				colors[i] = Color32.Lerp(bottomColor, topColor, (vertexList[i].y - bottomY) / uiElementHeight);
			}
			aMesh.colors = colors;
		}
	}
	#endif
}