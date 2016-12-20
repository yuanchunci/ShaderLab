#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkServer")]
	[Tooltip("This shuts down the server and disconnects all clients.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkServer.Shutdown.html")]
	[System.Serializable]
	public class Shutdown : StateAction {

		public override void OnEnter ()
		{
			base.OnEnter ();
			NetworkServer.Shutdown ();
			Finish ();
		}
	}
}
#endif