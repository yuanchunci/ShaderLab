using UnityEngine;
using UnityEditor;
using System.Collections;

namespace ICode.FSMEditor{
	[InitializeOnLoad]
	public class ReviewReminderWindow : EditorWindow {
		public const string activeKey="ICodeReviewActive";
		private static double timeSiceStartup;

		static ReviewReminderWindow ()
		{
			EditorApplication.update += UpdateCheck;
		}

		public static void ShowWindow()
		{
			ReviewReminderWindow window = EditorWindow.GetWindow<ReviewReminderWindow>(true);
			#if UNITY_5_1 || UNITY_5_2
				window.titleContent=new GUIContent("Review Reminder");
			#else
				window.title="Review Reminder";
			#endif
			Vector2 size = new Vector2(320f, 120f);
			window.minSize = size;
			window.maxSize = size;
		}

		private static void UpdateCheck(){
	
			if (EditorApplication.timeSinceStartup > 5.0  && EditorApplication.timeSinceStartup < 10.0) {
				Check ();
				EditorApplication.update-=UpdateCheck;
			}
		}

		private static void Check()
		{
			bool active = EditorPrefs.GetBool (ReviewReminderWindow.activeKey, true);
			string lastCheck = EditorPrefs.GetString ("lastCheck");
			if (active && lastCheck != System.DateTime.Today.ToString ()) {
				ReviewReminderWindow.ShowWindow();
			}
		}

		private void OnGUI(){
			GUILayout.Label ("ICode",EditorStyles.boldLabel);
			GUILayout.BeginHorizontal ();
			GUILayout.Label (FsmEditorStyles.iCodeLogo);
			GUILayout.Label ("Please consider giving us a rating on the Unity Asset Store. Your vote will help us to improve this product. Thank you!",EditorStyles.wordWrappedLabel);
			GUILayout.EndHorizontal ();
			GUILayout.BeginHorizontal ();
			GUILayout.FlexibleSpace ();
			if (GUILayout.Button ("Review Now!")) {
				UnityEditorInternal.AssetStore.Open("/content/13761");
				EditorPrefs.SetBool(ReviewReminderWindow.activeKey, false);
				this.Close();
			}
			if (GUILayout.Button ("Remind me later")) {
				EditorPrefs.SetBool(ReviewReminderWindow.activeKey,true);
				EditorPrefs.SetString("lastCheck",System.DateTime.Today.ToString());
				this.Close();
			}
			if (GUILayout.Button ("Don't ask again")) {
				EditorPrefs.SetBool(ReviewReminderWindow.activeKey,false);
				this.Close();
			}
			GUILayout.EndHorizontal ();
		}
	}
}