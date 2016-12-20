#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Pause all sound effects and Playlists in Master Audio.")] 
	[System.Serializable]
	public class PauseEverything : StateAction
	{
		public override void OnEnter()
		{
			MasterAudio.PauseEverything();
		}
	}
}
#endif