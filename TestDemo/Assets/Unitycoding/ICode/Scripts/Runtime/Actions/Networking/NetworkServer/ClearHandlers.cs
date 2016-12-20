﻿#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkServer")]
	[Tooltip("Clear all registered callback handlers.")]
	[HelpUrl("http://docs.unity3d.com/ScriptReference/Networking.NetworkServer.ClearHandlers.html")]
	[System.Serializable]
	public class ClearHandlers : StateAction {

		public override void OnEnter ()
		{
			base.OnEnter ();
			NetworkServer.Reset ();
			Finish ();
		}
	}
}
#endif