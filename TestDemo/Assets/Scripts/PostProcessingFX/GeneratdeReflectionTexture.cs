using UnityEngine;
using System.Collections;

public class GeneratdeReflectionTexture : MonoBehaviour {
	public LayerMask casterLayer;
	public Shader shader;
	public Color backgroundColor = Color.white;
	private Camera reflectionCam;
	public int TextureSize = 512;

	public Shader stencilInterpolateShader;
	public Camera cam = null;
	public GameObject plane;
	private Mesh quadMesh;
	
	private Material stencilInterpolateMat;

	private Matrix4x4 biasMatrix;
	private RenderTexture reflectionTexture;
	private bool isActive = true;
	private bool _isActive = true;
	// Use this for initialization
	void Awake () {
		reflectionCam = gameObject.AddComponent<Camera>();
		reflectionCam.CopyFrom(Camera.main);
		reflectionCam.name = "reflectionCam";
		reflectionCam.cullingMask = casterLayer;
		reflectionCam.clearFlags = CameraClearFlags.SolidColor;
		reflectionCam.backgroundColor = backgroundColor;
		reflectionTexture = new RenderTexture(TextureSize,TextureSize, 16, RenderTextureFormat.ARGB32);
		reflectionTexture.filterMode = FilterMode.Point;
		reflectionCam.targetTexture = reflectionTexture;
		reflectionCam.SetReplacementShader(shader, null);
		reflectionCam.enabled = false;

		if(stencilInterpolateMat == null)
		{
			stencilInterpolateMat = new Material(stencilInterpolateShader);
			stencilInterpolateMat.hideFlags = HideFlags.HideAndDontSave;
		}

		biasMatrix = Matrix4x4.identity;
		biasMatrix[ 0, 0 ] = 0.5f;
		biasMatrix[ 1, 1 ] = 0.5f;
		biasMatrix[ 2, 2 ] = 0.5f;
		biasMatrix[ 0, 3 ] = 0.5f;
		biasMatrix[ 1, 3 ] = 0.5f;
		biasMatrix[ 2, 3 ] = 0.5f;

		CreateQuadMesh();
	}

	protected void CreateQuadMesh()
	{
		if (quadMesh == null)
		{
			// Create quad vertices and triangles
			Vector3[] vertices =
			{
				new Vector3(-1.0f, 1.0f, 0.0f),
				new Vector3(1.0f, 1.0f, 0.0f),
				new Vector3(-1.0f, -1.0f, 0.0f),
				new Vector3(1.0f, -1.0f, 0.0f)
			};
			
			int[] triangles =
			{
				0, 1, 2,
				2, 1, 3
			};
			
			// Create the quad mesh
			Mesh mesh = new Mesh();
			
			mesh.name = "Quad Mesh";
			mesh.vertices = vertices;
			mesh.triangles = triangles;
			mesh.uv =  new Vector2[]{
				new Vector2(0,1),
				new Vector2(1,1),
				new Vector2(0,0),
				new Vector2(1,0)
			};
			mesh.bounds = new Bounds(Vector3.zero, Vector3.one * float.MaxValue);
			
			quadMesh = mesh;
		}
	}

	void OnDestroy()
	{
		RenderTexture.DestroyImmediate(reflectionTexture);
	}

	void OnGUI()
	{
		if(reflectionTexture != null)
		{
			GUI.DrawTextureWithTexCoords(new Rect(0,20, 150,150), reflectionTexture, new Rect(0,0,1,1), false);
		}

		if(GUI.Button(new Rect(Screen.width - 150, 400, 150,100), isActive?"Disable":"Enable"))
		{
			isActive = !isActive;
		}

	}

	void LateUpdate()
	{
		if(_isActive != isActive)
		{
			_isActive = isActive;
			if(isActive)
			{
				reflectionTexture = new RenderTexture(TextureSize,TextureSize, 16, RenderTextureFormat.ARGB32);
				reflectionTexture.filterMode = FilterMode.Point;
			}else
			{
				RenderTexture.DestroyImmediate(reflectionTexture);
			}
		}
		if(isActive)
		{
			reflectionCam.cullingMask = casterLayer;
			reflectionCam.Render();
			Shader.SetGlobalTexture("_reflectionTex", reflectionCam.targetTexture);
			Shader.SetGlobalMatrix("_biasMat", biasMatrix);
		}

		if(plane != null)
		{
			Shader.SetGlobalMatrix("_World2Receiver", plane.renderer.worldToLocalMatrix);
		}
		Graphics.DrawMesh(quadMesh, Vector3.zero, Quaternion.identity, stencilInterpolateMat, 0, cam, 0, null, false, false);
	}


}
