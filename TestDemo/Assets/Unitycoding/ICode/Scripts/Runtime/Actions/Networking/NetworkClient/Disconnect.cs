#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkClient")]
	[Tooltip("Disconnect from server.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkClient.Disconnect.html")]
	[System.Serializable]
	public class Disconnect : StateAction {

		public override void OnEnter ()
		{
			base.OnEnter ();
			if (NetworkClient.allClients.Count > 0) {
				NetworkClient client= NetworkClient.allClients[0];
				client.Disconnect();
			}
			Finish ();
		}
	}
}
#endif