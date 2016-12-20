#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkManager")]
	[Tooltip("The network address currently in use.For clients, this is the address of the server that is connected to. For servers, this is the local address.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkManager-networkAddress.html")]
	[System.Serializable]
	public class GetNetworkAddress : NetworkManagerAction {
		[Shared]
		[Tooltip("Store the value.")]
		public FsmString store;

		public override void OnEnter ()
		{
			base.OnEnter ();
			store.Value=manager.networkAddress;
			Finish ();
		}
	}
}
#endif