#if UNITY_5_1
using UnityEngine;
using System.Collections;
using UnityEngine.Networking;

namespace ICode.Actions.UnityNetworking{
	[System.Serializable]
	public abstract class NetworkManagerAction : StateAction {
		[SharedPersistent]
		[Tooltip("GameObject with a NetworkManager component.")]
		public FsmGameObject gameObject;
		protected NetworkManager manager;

		public override void OnEnter ()
		{
			manager = gameObject.Value.GetComponent<NetworkManager> ();
		}
	}
}
#endif