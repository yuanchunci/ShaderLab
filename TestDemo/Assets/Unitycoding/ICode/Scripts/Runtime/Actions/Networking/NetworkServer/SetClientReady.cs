#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkServer")]
	[Tooltip("Sets the client to be ready.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkServer.SetClientReady.html")]
	[System.Serializable]
	public class SetClientReady : StateAction {
		public FsmInt connectionId;
		public override void OnEnter ()
		{
			base.OnEnter ();
			NetworkConnection connection = NetworkServer.connections.Find (x => x.connectionId == connectionId.Value);
			if(connection != null){
				NetworkServer.SetClientReady(connection);
			}
			Finish ();
		}
	}
}
#endif