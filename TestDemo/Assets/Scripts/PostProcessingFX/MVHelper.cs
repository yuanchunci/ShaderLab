using UnityEngine;
using System.Collections;

public class MVHelper : MonoBehaviour
{
	private Matrix4x4 lastModelView = Matrix4x4.identity;
	void Start () {
		
	}
	void OnWillRenderObject()
	{
		if( Camera.current.name != "MotionVectorCamera" ) return;
		
		foreach (Material mat in renderer.materials)
		{
			mat.SetMatrix("_Previous_MV", lastModelView);
		}
		
		Matrix4x4 view = Camera.current.worldToCameraMatrix;
		Matrix4x4 model = calculateModelMatrix();
		
		lastModelView = view * model;
	}
	
	Matrix4x4 calculateModelMatrix()
	{
		if( renderer is SkinnedMeshRenderer )
		{
			Transform rootBone = ((SkinnedMeshRenderer)renderer).rootBone;
			return Matrix4x4.TRS( rootBone.position, rootBone.rotation, Vector3.one );
		}
		if( renderer.isPartOfStaticBatch )
		{
			return Matrix4x4.identity;
		}
		return Matrix4x4.TRS( transform.position, transform.rotation, calculateScale() );
	}
	
	Vector3 calculateScale()
	{
		Vector3 scale = Vector3.one;
		
		// the model is uniformly scaled, so we'll use localScale in the model matrix
		if( transform.localScale == Vector3.one * transform.localScale.x )
		{
			scale = transform.localScale;
		}
		
		// recursively multiply scale by each parent up the chain
		Transform parent = transform.parent;
		while( parent != null )
		{
			scale = new Vector3( scale.x * parent.localScale.x, scale.y * parent.localScale.y, scale.z * parent.localScale.z );
			parent = parent.parent;
		}
		return scale;
	}
}