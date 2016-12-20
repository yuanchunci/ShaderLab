using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using System.Collections;


namespace Unitycoding{
	/// <summary>
	/// Notification window
	/// </summary>
	public class UINotification : UIWindow {
		protected static UINotification instance;
		[SerializeField]
		private Text text;

		protected override void OnEnable(){
			base.OnEnable ();
			instance = this;
		}

		/// <summary>
		/// Show a notification
		/// </summary>
		/// <param name="settings">Settings.</param>
		/// <param name="onClose">On close.</param>
		public static void Show(MessageSettings settings, UnityAction onClose){
			Show (settings.message, settings.color, onClose);
		}

		/// <summary>
		/// Show a notification
		/// </summary>
		/// <param name="text">Text.</param>
		/// <param name="color">Color.</param>
		public static void Show(string text, Color color){
			Show (text, color, null);
		}

		/// <summary>
		/// Show a notification
		/// </summary>
		/// <param name="text">Text.</param>
		/// <param name="color">Color.</param>
		/// <param name="onClose">On close.</param>
		public static void Show(string text, Color color, UnityAction onClose){
			if (instance != null) {
				instance.text.text = UnityUtility.ColorString (text, color);
				instance.Open();
				if(onClose != null){
					instance.onClose.AddListener(onClose);
				}

			}
		}
	}
}