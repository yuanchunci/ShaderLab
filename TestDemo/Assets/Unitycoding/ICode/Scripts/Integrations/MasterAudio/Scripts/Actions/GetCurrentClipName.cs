#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Get the name of the currently playing Audio Clip in a Playlist in Master Audio")]
	[System.Serializable]
	public class GetCurrentClipName : StateAction
	{	
		[Tooltip("Name of Playlist Controller to use. Not required if you only have one.")]
		public FsmString playlistControllerName;
		[Shared]
		[Tooltip("Name of Variable to store the current clip name in.")]
		public FsmString store;

		public override void OnEnter()
		{
			PlaylistController controller = null;
			
			if (!string.IsNullOrEmpty(playlistControllerName.Value)) {
				controller = PlaylistController.InstanceByName(playlistControllerName.Value);
			} else {
				controller = MasterAudio.OnlyPlaylistController;
			}
			
			var clip = controller.CurrentPlaylistClip;
			
			store.Value = clip == null ? string.Empty : clip.name;
		}
	}
}
#endif