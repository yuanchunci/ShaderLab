using UnityEngine;
using System.Collections;

public class CameraFollower : MonoBehaviour {
	public Vector3 distance;
	public float smooth;
	public Vector3 eulerAngles;
	public Transform target;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

		if(target != null)
		{
			float deltaTime = Time.deltaTime;
			transform.position = Vector3.Lerp(transform.position, distance + target.position, deltaTime * smooth);
			transform.eulerAngles = Vector3.Lerp(transform.eulerAngles, eulerAngles, deltaTime * smooth);
		}

	}
}
