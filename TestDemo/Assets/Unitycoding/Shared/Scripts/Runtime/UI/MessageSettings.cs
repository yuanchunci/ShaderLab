using UnityEngine;
using UnityEngine.UI;
using System.Collections;

namespace Unitycoding{
	/// <summary>
	/// Settings for the Notification system(UIMessage).
	/// </summary>
	[System.Serializable]
	public class MessageSettings{
		/// <summary>
		/// The message to display.
		/// </summary>
		public string message = string.Empty;
		/// <summary>
		/// The color of the message text.
		/// </summary>
		public Color color = Color.white;
		/// <summary>
		/// The duration of display.
		/// </summary>
		public float duration = 2.0f;
		/// <summary>
		/// Delay fading.
		/// </summary>
		public float delay = 2.0f;
		/// <summary>
		/// Ignore TimeScale.
		/// </summary>
		public bool ignoreTimeScale = true;
		
		public MessageSettings(MessageSettings other){
			this.message=other.message;
			this.color=other.color;
			this.delay=other.delay;
			this.duration=other.duration;
			this.ignoreTimeScale=other.ignoreTimeScale;
		}
		
		public MessageSettings(){}
	}
}