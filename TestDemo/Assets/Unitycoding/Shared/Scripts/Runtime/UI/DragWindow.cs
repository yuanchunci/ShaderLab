using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System.Collections;

namespace Unitycoding{
	/// <summary>
	/// Drag window handler. Attach this component to make draggable windows.
	/// </summary>
	public class DragWindow :  MonoBehaviour, IPointerDownHandler, IDragHandler  {
		private Vector2 originalLocalPointerPosition;
		private Vector3 originalPanelLocalPosition;
		private RectTransform panelRectTransform;
		private RectTransform parentRectTransform;
		
		void Awake () {
			panelRectTransform = transform.parent as RectTransform;
			parentRectTransform = panelRectTransform.parent as RectTransform;
			
		}
		
		public void OnPointerDown (PointerEventData data) {
			originalPanelLocalPosition = panelRectTransform.localPosition;
			RectTransformUtility.ScreenPointToLocalPointInRectangle (parentRectTransform, data.position, data.pressEventCamera, out originalLocalPointerPosition);
			
			panelRectTransform.SetAsLastSibling ();
		}
		
		public void OnDrag (PointerEventData data) {
			if (panelRectTransform == null || parentRectTransform == null) {
				return;
			}
			Vector2 localPointerPosition;
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle (parentRectTransform, data.position, data.pressEventCamera, out localPointerPosition)) {
				Vector3 offsetToOriginal = localPointerPosition - originalLocalPointerPosition;
				panelRectTransform.localPosition = originalPanelLocalPosition + offsetToOriginal;
			}
		}
	}
}