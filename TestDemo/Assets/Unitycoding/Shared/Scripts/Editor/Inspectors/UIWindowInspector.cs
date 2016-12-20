using System.Linq;
using UnityEngine;
using UnityEditor;
using UnityEngine.UI;
using UnityEditor.AnimatedValues;
using System.Collections;
using UnityEngine.Events;
using UnityEditorInternal;
using System;
using System.Reflection;

namespace Unitycoding{
	[CustomEditor(typeof(UIWindow),true)]
	public class UIWindowInspector : Editor {
		private SerializedProperty dynamicContainer;
		private SerializedProperty slotPrefab;
		private SerializedProperty grid;
		private AnimBool showDynamicContainer;

		public virtual void OnEnable(){
			dynamicContainer = serializedObject.FindProperty ("dynamicContainer");

			if (dynamicContainer != null) {
				slotPrefab = serializedObject.FindProperty ("slotPrefab");
				grid = serializedObject.FindProperty ("grid");
				if (grid.objectReferenceValue == null) {
					GridLayoutGroup group=((MonoBehaviour)target).gameObject.GetComponentInChildren<GridLayoutGroup>();
					if(group != null){
						serializedObject.Update();
						grid.objectReferenceValue=group.transform;
						serializedObject.ApplyModifiedProperties();
					}
				}
				this.showDynamicContainer = new AnimBool (dynamicContainer.boolValue);
				this.showDynamicContainer.valueChanged.AddListener (new UnityAction (this.Repaint));
			}
		}
		
		public override void OnInspectorGUI ()
		{
			serializedObject.Update ();
			DrawBaseProperties ();
			DrawChildPropertiesExcluding<UIWindow> (serializedObject, "dynamicContainer","slotPrefab","grid");
			serializedObject.ApplyModifiedProperties ();
		}

		public virtual void OnDisable(){
			if (this.showDynamicContainer != null) {
				this.showDynamicContainer.valueChanged.RemoveListener (new UnityAction (this.Repaint));
			}
		}

		protected virtual void DrawBaseProperties(){

			DrawBasePropertiesExcluding<UIWindow> (serializedObject, "");

			if (dynamicContainer != null) {
				EditorGUILayout.PropertyField (dynamicContainer);
				showDynamicContainer.target = dynamicContainer.boolValue;
				if (EditorGUILayout.BeginFadeGroup (this.showDynamicContainer.faded)) {
					EditorGUI.indentLevel = EditorGUI.indentLevel + 1;
					EditorGUILayout.PropertyField (this.grid);
					EditorGUILayout.PropertyField (this.slotPrefab);
					EditorGUI.indentLevel = EditorGUI.indentLevel - 1;
				}
				EditorGUILayout.EndFadeGroup ();
			}
		}
		
		protected void DrawChildPropertiesExcluding<T>(SerializedObject obj, params string[] propertyToExclude)
		{
			SerializedProperty iterator = obj.GetIterator();
			bool flag = true;
			while (iterator.NextVisible(flag))
			{
				flag = false;
				
				if (!propertyToExclude.Contains<string>(iterator.name) && typeof(T).GetField(iterator.name,BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) == null && iterator.name !="m_Script")
				{
					EditorGUILayout.PropertyField(iterator, true, new GUILayoutOption[0]);
				}
			}
		}
		
		protected void DrawBasePropertiesExcluding<T>(SerializedObject obj, params string[] propertyToExclude)
		{
			SerializedProperty iterator = obj.GetIterator();
			bool flag = true;
			while (iterator.NextVisible(flag))
			{
				flag = false;
				if (!propertyToExclude.Contains<string>(iterator.name) && (typeof(T).GetField(iterator.name,BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) != null || iterator.name =="m_Script"))
				{
					EditorGUILayout.PropertyField(iterator, true, new GUILayoutOption[0]);
				}
			}
		}
	}
	
}
