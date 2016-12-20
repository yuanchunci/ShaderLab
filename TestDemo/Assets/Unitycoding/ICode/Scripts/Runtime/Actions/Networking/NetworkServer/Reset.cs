#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkServer")]
	[Tooltip("Reset the NetworkServer singleton.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkServer.Reset.html")]
	[System.Serializable]
	public class Reset : StateAction {

		public override void OnEnter ()
		{
			base.OnEnter ();
			NetworkServer.Reset ();
			Finish ();
		}
	}
}
#endif