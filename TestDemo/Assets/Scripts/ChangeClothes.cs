using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ChangeClothes : MonoBehaviour {
	public GameObject item;
	public Transform root;
	public string slot = "juggernaut_sword";
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI()
	{
		if (GUI.Button(new Rect(10, 10, 150, 100), "I am a button"))
		{
			Transform target = root.FindChild(slot);
			if(target != null)
			{
				List<GameObject> list = SkinnedMeshTools.AddSkinnedMeshTo(item, root);
				foreach(GameObject go in list)
				{
					go.name = slot;
				}
				GameObject.Destroy(target.gameObject);
			}
			SkinnedMeshTools.ChangeCloth(slot, item, root);
		}
	}
}
