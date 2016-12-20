#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkServer")]
	[Tooltip("This destroys all the player objects associated with a NetworkConnections on a server..")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkServer.DestroyPlayersForConnection.html")]
	[System.Serializable]
	public class DestroyPlayersForConnection : StateAction {
		[Tooltip("Connection id.")]
		public FsmInt connectionId;

		public override void OnEnter ()
		{
			base.OnEnter ();
			NetworkConnection connection=NetworkServer.connections.Find (x => x.connectionId == connectionId.Value);
			if(connection != null){
				NetworkServer.DestroyPlayersForConnection(connection);
			}
			Finish ();
		}
	}
}
#endif