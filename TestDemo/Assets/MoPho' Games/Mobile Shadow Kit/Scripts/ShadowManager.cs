using UnityEngine;
using System.Collections;

[AddComponentMenu( "Mobile Shadow Kit/Shadow Manager" )]
public class ShadowManager : MonoBehaviour
{
	public static ShadowManager Instance;

	public int ShadowMapSize = 1024;
	public float ShadowMapCoverage = 50.0f;
	public float ShadowMapNear = -200.0f;
	public float ShadowMapFar = 400.0f;

	public float DistanceThreshold = 1.0f;
	public bool SparseUpdate = false;

	public LayerMask ShadowCastingLayers;

	[HideInInspector]
	public RenderTexture Shadowmap;

	[HideInInspector]
	public Camera ShadowCamera;

	private Matrix4x4 texMatrix;

	private Transform shadowCamTransform;
	private Transform mainCamTransform;

	private float invShadowMapSize;

	void Awake()
	{
		Instance = this;

		Shadowmap = new RenderTexture( ShadowMapSize, ShadowMapSize, 16 );
		invShadowMapSize = 1.0f / (float)ShadowMapSize;
		Shadowmap.name = "ShadowMap";
		Shadowmap.filterMode = FilterMode.Point;

		ShadowCamera = new GameObject( "__Shadowmap_" ).AddComponent<Camera>();
		ShadowCamera.transform.position = Vector3.zero;
		ShadowCamera.transform.rotation = transform.rotation;
		ShadowCamera.transform.parent = transform;
		ShadowCamera.transform.localPosition += Vector3.forward * ShadowMapNear;
		ShadowCamera.cullingMask = ShadowCastingLayers;
		ShadowCamera.isOrthoGraphic = true;
		ShadowCamera.orthographicSize = ShadowMapCoverage;
		ShadowCamera.far = ShadowMapFar;
		ShadowCamera.targetTexture = Shadowmap;
		ShadowCamera.SetReplacementShader( Shader.Find( "Hidden/RenderDepth" ), "" );
		ShadowCamera.clearFlags = CameraClearFlags.SolidColor;
		ShadowCamera.backgroundColor = EncodeDepth( 0.9999f );

		if( SparseUpdate )
		{
			ShadowCamera.Render();
			ShadowCamera.enabled = false;
		}

		texMatrix = Matrix4x4.identity;
		texMatrix[ 0, 0 ] = 0.5f;
		texMatrix[ 1, 1 ] = 0.5f;
		texMatrix[ 2, 2 ] = 0.5f;
		texMatrix[ 0, 3 ] = 0.5f;
		texMatrix[ 1, 3 ] = 0.5f;
		texMatrix[ 2, 3 ] = 0.5f;

		shadowCamTransform = ShadowCamera.transform;
	}

	void LateUpdate()
	{
		if( mainCamTransform == null )
			mainCamTransform = Camera.main.transform;

		Vector3 spos = ( mainCamTransform.position + ( shadowCamTransform.forward * ShadowMapNear ) + ( mainCamTransform.forward * ShadowMapCoverage * 0.5f ) );

		if( ( spos - shadowCamTransform.position ).sqrMagnitude > ( DistanceThreshold * DistanceThreshold ) || !SparseUpdate )
		{
			shadowCamTransform.position = spos;
			if( SparseUpdate )
				ShadowCamera.Render();
		}

		Matrix4x4 shadowMatrix = texMatrix * ShadowCamera.projectionMatrix * ShadowCamera.worldToCameraMatrix;
		Shader.SetGlobalMatrix( "_ShadowProjectionMatrix", shadowMatrix );
		Shader.SetGlobalTexture( "_ShadowMapTex", ShadowCamera.targetTexture );
		Shader.SetGlobalFloat( "_InvShadowMapTexSize", invShadowMapSize );
		Shader.SetGlobalFloat( "_ShadowMapCoverage", ShadowMapCoverage );
	}

	Color EncodeDepth( float depth )
	{
		Vector4 enc = new Vector4( 1.0f, 255.0f, 62025.0f, 160581375.0f ) * depth;
		enc = frac( enc );
		Vector4 yzww = new Vector4( enc.y, enc.y, enc.z, enc.w );
		enc -= mul( yzww, new Vector4( 1.0f / 255.0f, 1.0f / 255.0f, 1.0f / 255.0f, 0.0f ) );
		return (Color)enc;
	}

	Vector4 frac( Vector4 orig )
	{
		return new Vector4( frac( orig.x ), frac( orig.y ), frac( orig.z ), frac( orig.w ) );
	}

	float frac( float orig )
	{
		float whole = Mathf.Floor( orig );
		return orig - whole;
	}

	Vector4 mul( Vector4 lhs, Vector4 rhs )
	{
		return new Vector4( lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w );
	}
}