#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[Category("UnityNetworking/NetworkServer")]
	[Tooltip("Sends a variable to client by id.")]
	[System.Serializable]
	public class SendToClient : StateAction {
		public FsmInt connectionId;
		public FsmInt msgType;
		[ParameterType]
		[Tooltip("Variable to send.")]
		public FsmVariable variable;

		public override void OnEnter ()
		{
			base.OnEnter ();
			FsmVariableMessage message = new FsmVariableMessage (variable);
			NetworkServer.SendToClient (connectionId.Value,(short)msgType.Value, message);
			Finish ();
		}

	}
}
#endif