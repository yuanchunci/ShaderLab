using UnityEngine;
using System.Collections;

public class AnimatorController : MonoBehaviour {
	public AnimationClip aniClip;
	private Animator animator;
	// Use this for initialization
	void Start () {
		animator = GetComponent<Animator>();
		Debug.Log("framerate " + aniClip.frameRate);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnGUI()
	{
		if (GUI.Button(new Rect(10, 120, 150, 100), "Pause"))
		{
			animator.speed = animator.speed != 0? 0 : 1;
		}
	}
}
