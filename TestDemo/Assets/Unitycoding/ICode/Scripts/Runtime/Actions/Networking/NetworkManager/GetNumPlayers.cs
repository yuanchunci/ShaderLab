#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkManager")]
	[Tooltip("NumPlayers is the number of active player objects across all connections on the server.This is only valid on the host / server.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkManager-numPlayers.html")]
	[System.Serializable]
	public class GetNumPlayers : NetworkManagerAction {
		[Shared]
		[Tooltip("Store the value.")]
		public FsmInt store;

		public override void OnEnter ()
		{
			base.OnEnter ();
			store.Value=manager.numPlayers;
			Finish ();
		}
	}
}
#endif