using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class NextAnimPlay : MonoBehaviour {

	
	private List<string> _animationList = new List<string>();
	private int _curID = 0;
	
	void Start () 
	{
		
		
		foreach( AnimationState state in animation)
		{
			_animationList.Add(state.name);
		
			
			Debug.Log(_animationList.Count);
		}
		
		animation.Play(_animationList[0]);
		
		
		
	}
	

	void Update () 
	{
		if(Input.GetKeyDown(KeyCode.Space))
		{
			NextPlayCall();	
		}
	}
	
	private void NextPlayCall()
	{
		_curID += 1;	
		_curID %= _animationList.Count;
        animation.Play(_animationList[_curID]);
                    
	}
	
	
}
