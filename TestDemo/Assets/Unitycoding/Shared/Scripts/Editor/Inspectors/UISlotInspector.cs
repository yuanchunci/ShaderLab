using UnityEngine;
using UnityEditor;
using UnityEditorInternal;
using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

namespace Unitycoding{
	[CustomEditor(typeof(UISlot<>),true)]
	public class UISlotInspector : Editor {
		public override void OnInspectorGUI ()
		{
			base.OnInspectorGUI ();
			if (GUILayout.Button ("Add Validation")) {
				GenericMenu menu = new GenericMenu ();
				IEnumerable<Type> types = AppDomain.CurrentDomain.GetAssemblies().SelectMany(assembly => assembly.GetTypes()) .Where(type => typeof(IValidation<>).IsAssignableFrom(type) && type.IsClass && !type.IsAbstract);		
				
				foreach (Type type in types) {
					Type mType=type;
					menu.AddItem(new GUIContent(mType.Name),false,delegate() {
						(target as MonoBehaviour).gameObject.AddComponent(mType);
					});		
				}
				menu.ShowAsContext ();
			}
		}
	}
}