#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Add a Sound Group in Master Audio to the list of sounds that cause music ducking.")]
	[System.Serializable]
	public class AddSoundGroupToDuckList : StateAction
	{
		[Tooltip("Name of Master Audio Sound Group")]
		public FsmString soundGroupName;
		
		[Tooltip("Percentage of sound played to start unducking")]
		public FsmFloat beginUnduck;
		
		public override void OnEnter()
		{
			MasterAudio.AddSoundGroupToDuckList(soundGroupName.Value, beginUnduck.Value);
		}
	}
}
#endif