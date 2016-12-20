#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Stop current Playlist in Master Audio")] 
	[System.Serializable]
	public class StopPlaylist : StateAction
	{
		[Tooltip("Check this to perform action on all Playlist Controllers")]
		public FsmBool allPlaylistControllers;	
		[Tooltip("Name of Playlist Controller to use. Not required if you only have one.")]
		public FsmString playlistControllerName;
		
		public override void OnEnter()
		{
			if (allPlaylistControllers.Value) {
				var pcs = PlaylistController.Instances;
				
				for (var i = 0; i < pcs.Count; i++) {
					MasterAudio.StopPlaylist(pcs[i].name);
				}
			} else {
				if (string.IsNullOrEmpty(playlistControllerName.Value)) {
					MasterAudio.StopPlaylist();
				} else {
					MasterAudio.StopPlaylist(playlistControllerName.Value);
				}
			}
		}
	}
}
#endif