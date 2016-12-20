#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkManager")]
	[Tooltip("This starts a network client. It uses the networkAddress and networkPort properties as the address to connect to.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkManager.StartClient.html")]
	[System.Serializable]
	public class StartClient : NetworkManagerAction {

		public override void OnEnter ()
		{
			base.OnEnter ();
			manager.StartClient ();
			Finish ();
		}
	}
}
#endif