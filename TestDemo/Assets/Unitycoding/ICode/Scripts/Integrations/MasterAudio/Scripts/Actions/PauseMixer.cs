#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Pause all sound effects in Master Audio. Does not include Playlists.")]
	[System.Serializable]
	public class PauseMixer : StateAction
	{
		public override void OnEnter()
		{
			MasterAudio.PauseMixer();
		}
	}
}
#endif