/*
 * Name: AnimationSpeedEditor.cs
 * Version: 0.6
 * Author:  Yilmaz Kiymaz (@VoxelBoy)
 * Purpose: Adjust the playback speed of animations through the Inspector
 * License: CC by-sa 3.0 - http://creativecommons.org/licenses/by-sa/3.0/
 * Contact: VoxelBoy on Unity Forums
 */

using UnityEngine;
using UnityEditor;

[CustomEditor (typeof(Animation))] //We're targeting the Animation component
public class AnimationSpeedEditor : Editor {
	
	bool foldout = true; //Foldout Animation speed controls

	public override void OnInspectorGUI() {
		DrawDefaultInspector(); //Draw the default view for Animation component
		
		Animation anim = (Animation) target; //Our target is an Animation component so cast to proper type
		
		//Make sure that there's an OverrideAnimationSpeeds component on the gameObject of the Animation component
		OverrideAnimationSpeeds overrideAnim = anim.GetComponent<OverrideAnimationSpeeds>();
		if(overrideAnim == null) return; //If not, don't override the Inspector view
		
		overrideAnim.CheckArrayConsistency(); //Make sure the override arrays have been instantiated and are of the right size
		
		EditorGUILayout.Space(); //Put a little space between default Animation component controls and our custom controls
		foldout = EditorGUILayout.Foldout(foldout, "Animation speeds"); //Foldout

		if(foldout) { //If foldout field is toggled
			//Indent the controls horizontally
			EditorGUI.indentLevel = 2;
			EditorGUILayout.BeginHorizontal();
			EditorGUILayout.Space(); EditorGUILayout.Space();
			EditorGUILayout.BeginVertical();
			
				overrideAnim.animSpeedRange = EditorGUILayout.FloatField("Speed Range", overrideAnim.animSpeedRange); //-/+ range of animation speed
				EditorGUILayout.Space(); //Leave a little space
				for(int i=0; i<anim.GetClipCount(); i++) { //Draw 
					string animName = overrideAnim.GetAnimationName(i); //Get animation name stored in OverrideAnimationSpeeds component
					float animSpeed = overrideAnim.GetAnimationSpeed(i); //Get animation speed stored in OverrideAnimationSpeeds component
					EditorGUILayout.LabelField(animName, ""); //Show animation name
					float newSpeed = EditorGUILayout.Slider(animSpeed, -overrideAnim.animSpeedRange, overrideAnim.animSpeedRange); //Show slider for animation speed
					if(!Mathf.Approximately(newSpeed, animSpeed)) { //If animation speed has changed, assign the new value to the OverrideAnimationSpeeds component
						overrideAnim.OverrideAnimationSpeed(animName, newSpeed);
					}
				}
			
			//Close the indenting group
			EditorGUILayout.EndVertical();
			EditorGUILayout.EndHorizontal();
		}
		EditorGUILayout.Space(); //Leave some vertical space at the bottom
	}
}
