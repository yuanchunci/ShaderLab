﻿#if MASTER_AUDIO
using UnityEngine;

namespace ICode.Actions{
	[Category("MasterAudio")]  
	[Tooltip("Unmute all Audio in a Bus in Master Audio")] 
	[System.Serializable]
	public class UnmuteBus : StateAction
	{
		[Tooltip("Check this to perform action on all Buses")]
		public FsmBool allBuses;	
		
		[Tooltip("Name of Master Audio Bus")]
		public FsmString busName;
		
		public override void OnEnter()
		{
			if (!allBuses.Value && string.IsNullOrEmpty(busName.Value)) {
				Debug.LogError("You must either check 'All Buses' or enter the Bus Name");
				return;
			}
			
			if (allBuses.Value) {
				var busNames = MasterAudio.RuntimeBusNames;
				for (var i = 0; i < busNames.Count; i++) {
					MasterAudio.UnmuteBus(busNames[i]);
				}
			} else {
				MasterAudio.UnmuteBus(busName.Value);
			}
		}
	}
}
#endif