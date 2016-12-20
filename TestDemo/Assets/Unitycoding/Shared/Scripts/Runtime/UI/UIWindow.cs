using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

namespace Unitycoding{
	/// <summary>
	/// Base class for UI windows.
	/// </summary>
	[RequireComponent(typeof(CanvasGroup))]
	public class UIWindow : MonoBehaviour {
		[SerializeField]
		private new string name;
		/// <summary>
		/// Gets or sets the name.
		/// </summary>
		/// <value>The name.</value>
		public string Name{
			get{return name;}
			set{name=value;}
		}

		[Header("Appearing")]
		/// <summary>
		/// Draw on top.
		/// </summary>
		public bool focus=true;
		/// <summary>
		/// Enable/Disable transition scaling
		/// </summary>
		public bool scalingTransitions=true;
		/// <summary>
		/// The appear speed.
		/// </summary>
		public float appearSpeed = 10f;
		/// <summary>
		/// The key to turn this window on/off
		/// </summary>
		public KeyCode toggleKey=KeyCode.None;
		/// <summary>
		/// The AudioClip that will be played when this window opens.
		/// </summary>
		public AudioClip openSound;
		/// <summary>
		/// The AudioClip that will be played when this window closes.
		/// </summary>
		public AudioClip closeSound;
		/// <summary>
		/// Events that will be invoked when this window opens.
		/// </summary>
		public UIWindowEvent onOpen;
		/// <summary>
		/// Events that will be invoked when this window closes.
		/// </summary>
		public UIWindowEvent onClose;
		/// <summary>
		/// The RectTransform of the window.
		/// </summary>
		protected RectTransform rectTransform;
		/// <summary>
		/// The canvas group of the window.
		/// </summary>
		protected CanvasGroup canvasGroup;
		/// <summary>
		/// The target alpha value of the canvas group.
		/// </summary>
		protected float mTarget = 0f;

		private float mCurrent = 0f;
		/// <summary>
		/// Gets a value indicating whether this window is open.
		/// </summary>
		/// <value><c>true</c> if this instance is open; otherwise, <c>false</c>.</value>
		public bool IsOpen { 
			get { 
				return mTarget == 1f; 
			} 
		}

		/// <summary>
		/// This method is called when the object becomes enabled and active.
		/// </summary>
		protected virtual void OnEnable(){
			rectTransform = GetComponent<RectTransform> ();
			canvasGroup = GetComponent<CanvasGroup> ();
			windowCache = new Dictionary<string, UIWindow> ();
			mTarget = canvasGroup.alpha;

		}

		/// <summary>
		/// Awake is called when the script instance is being loaded.
		/// </summary>
		protected virtual void Awake(){}
		/// <summary>
		/// Start is called on the frame when a script is enabled just before any of the Update methods is called the first time.
		/// </summary>
		protected virtual void Start(){}
		/// <summary>
		/// Update is called every frame, if the MonoBehaviour is enabled.
		/// </summary>
		protected virtual void Update(){
			if (Input.GetKeyDown (toggleKey) && !(EventSystem.current != null && EventSystem.current.currentSelectedGameObject != null && EventSystem.current.currentSelectedGameObject.GetComponent<InputField>() != null)) {
				Toggle();
			}
			if (mCurrent != mTarget) {
				mCurrent = Mathf.Lerp (mCurrent, mTarget, Time.deltaTime * appearSpeed);
				if (Mathf.Abs (mCurrent - mTarget) < 0.001f) {
					mCurrent = mTarget;
				}
				canvasGroup.alpha= mCurrent * mCurrent;
				if (scalingTransitions) {
					Vector3 size = Vector3.one * (1.5f - mCurrent * 0.5f);
					rectTransform.localScale = size;
				}
			}
		}

		/// <summary>
		/// Open this window.
		/// </summary>
		public virtual void Open(){
			mTarget = 1f;
			canvasGroup.interactable = true;
			canvasGroup.blocksRaycasts = true;
			if (focus) {
				rectTransform.SetAsLastSibling ();
			}
			UnityUtility.PlaySound (openSound, 1.0f);
			if (onOpen != null) {
				onOpen.Invoke();
			}
		}

		/// <summary>
		/// Toggle this window.
		/// </summary>
		public virtual void Toggle(){
			if (mTarget == 0f) {
				Open ();
			} else {
				Close();
			}

		}

		/// <summary>
		/// Close this window.
		/// </summary>
		public virtual void Close(){
			mTarget = 0f;
			if (canvasGroup != null) {
				canvasGroup.interactable = false;
				canvasGroup.blocksRaycasts = false;
			}
			UnityUtility.PlaySound (closeSound, 1.0f);
			if (onClose != null) {
				onClose.Invoke();
			}
		}

		/// <summary>
		/// The window cache.
		/// </summary>
		protected static Dictionary<string,UIWindow> windowCache;
		/// <summary>
		/// Get an UIWindow by name.
		/// </summary>
		/// <param name="name">Name.</param>
		/// <typeparam name="T">The 1st type parameter.</typeparam>
		public static T Get<T>(string name) where T: UIWindow{
			UIWindow current = null;
			if(!windowCache.TryGetValue (name, out current)){;
				T[] windows = FindObjectsOfType<T> ();
				for (int i = 0; i < windows.Length; i++) {
					T window=windows[i];
					if(window.Name == name){
						current=window;
					}
					if(!windowCache.ContainsKey(window.Name)){
						windowCache.Add(window.Name,window);
					}
				}
			}
			return (T)current;
		}

		/// <summary>
		/// Get UIWindows by names
		/// </summary>
		/// <param name="names">Names.</param>
		/// <typeparam name="T">The 1st type parameter.</typeparam>
		public static T[] Get<T>(params string[] names) where T: UIWindow{
			List<T> list = new List<T> ();
			for (int i=0; i<names.Length; i++) {
				T window=Get<T>(names[i]);
				if(window != null){
					list.Add(window);
				}
			}
			return list.ToArray ();
		}

		[System.Serializable]
		public class UIWindowEvent:UnityEvent{}
	}
}