using UnityEngine;
using UnityEngine.UI;
using System.Collections;

namespace Unitycoding{
	/// <summary>
	/// Displays a message.
	/// </summary>
	public class UIMessage : UIWindow {
		[SerializeField]
		private Transform grid; 
		[SerializeField]
		private GameObject textPrefab; 

		/// <summary>
		/// Add a message to be displayed.
		/// </summary>
		/// <param name="message">Message.</param>
		public void Add(string message){
			MessageSettings settings = new MessageSettings ();
			settings.message = message;
			Add (settings);
		}

		/// <summary>
		/// Add a message to be displayed.
		/// </summary>
		/// <param name="settings">Settings.</param>
		public void Add(MessageSettings settings){
			GameObject go = (GameObject)Instantiate (textPrefab);
			go.SetActive (true);
			go.transform.SetParent (grid, false);
			go.transform.SetAsFirstSibling ();
			Text text = go.GetComponent<Text>();
			text.text = UnityUtility.ColorString (settings.message, settings.color);
			StartCoroutine(DelayCrossFade(text,settings));

		}

		private IEnumerator DelayCrossFade(Graphic graphic, MessageSettings settings){
			yield return new WaitForSeconds(settings.delay);
			graphic.CrossFadeAlpha(0f,settings.duration,settings.ignoreTimeScale);
		}
	
	}
}