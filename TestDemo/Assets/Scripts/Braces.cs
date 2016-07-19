using System.Collections.Generic;
using UnityEngine;
using System.Collections;

public class Braces : MonoBehaviour {
	public string[] inputs;
	public string test = "{}[]";
	// Use this for initialization
	void Start () {
		Debug.Log(IsValidBrace (test));
	}
	
	// Update is called once per frame
	void Update () {
	
	}



	public bool IsValidBrace(string input)
	{
		List<char> openList = new List<char> ();
		int index = 0;
		for (;index < input.Length; ++index) {
			if(IsOpenBrace(input[index]))
			{
				openList.Add(input[index]);
			}else if (IsCloseBrace(input[index]))
			{
				if(openList.Count == 0)
					break;
				else
				{
					char lastOpenBrace = openList[openList.Count - 1];
					if(pairs[lastOpenBrace] == input[index])
					{
						openList.RemoveAt(openList.Count - 1);
					}else
					{
						break;
					}
				}
			}
		}
		return index == input.Length;
	}

	private bool IsOpenBrace(char s)
	{
		return pairs.ContainsKey (s);
	}

	private bool IsCloseBrace(char s)
	{
		return pairs.ContainsValue (s);
	}

	Dictionary<char, char> pairs = new Dictionary<char, char> (){
		{'{','}'},
		{'[', ']'},
		{'(', ')'}
	};
}
