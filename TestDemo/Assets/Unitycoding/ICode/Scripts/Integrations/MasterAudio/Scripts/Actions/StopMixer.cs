#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Stop all sound effects in Master Audio. Does not include Playlists.")] 
	[System.Serializable]
	public class StopMixer : StateAction
	{
		public override void OnEnter()
		{
			MasterAudio.StopMixer();
		}
	}
}
#endif