#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkManager")]
	[Tooltip("This creates a UMatch matchmaker for the NetworkManager.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkManager.StartMatchMaker.html")]
	[System.Serializable]
	public class StartMatchMaker : NetworkManagerAction {

		public override void OnEnter ()
		{
			base.OnEnter ();
			manager.StartMatchMaker ();
			Finish ();
		}
	}
}
#endif