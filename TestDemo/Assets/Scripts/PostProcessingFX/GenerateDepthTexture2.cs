using UnityEngine;
using System.Collections;

public class GenerateDepthTexture2 : MonoBehaviour {
	public LayerMask casterLayer;
	public Shader shader;
	public float Near;
	public float Far;
	public float Size;
	public int TextureSize = 512;
	[Range(0,0.1f)]
	public float Bias;
	[Range(0,1)]
	public float Strength;
	private Matrix4x4 biasMatrix;
	private Camera depthCamera;
	private RenderTexture depthTexture;
	private BlurOptimized blur;
	// Use this for initialization
	void Awake () {
		GameObject go = new GameObject("depthCamera");
		depthCamera = go.AddComponent<Camera>();
//		gameObject.AddComponent<BlurOptimized>().shader = Shader.Find("Hidden/FastBlur");
//		blur = gameObject.GetComponent<BlurOptimized>();
		depthCamera.transform.position = Vector3.zero;
		depthCamera.transform.rotation = transform.rotation;
		depthCamera.transform.localPosition += transform.forward * Near;
		depthCamera.transform.parent = transform;
		depthCamera.isOrthoGraphic = true;
		
		depthCamera.clearFlags = CameraClearFlags.SolidColor;
		depthCamera.backgroundColor = Color.white;
		depthTexture = new RenderTexture(TextureSize,TextureSize, 16, RenderTextureFormat.ARGB32);
		depthTexture.filterMode = FilterMode.Point;
		depthCamera.targetTexture = depthTexture;
		depthCamera.SetReplacementShader(shader, null);
		depthCamera.enabled = false;
		biasMatrix = Matrix4x4.identity;
		biasMatrix[ 0, 0 ] = 0.5f;
		biasMatrix[ 1, 1 ] = 0.5f;
		biasMatrix[ 2, 2 ] = 0.5f;
		biasMatrix[ 0, 3 ] = 0.5f;
		biasMatrix[ 1, 3 ] = 0.5f;
		biasMatrix[ 2, 3 ] = 0.5f;
	}

	void OnDestroy()
	{
		RenderTexture.DestroyImmediate(depthTexture);
	}

	void OnGUI()
	{
		if(depthTexture != null)
		{
			GUI.DrawTextureWithTexCoords(new Rect(0,20, 150,150), depthTexture, new Rect(0,0,1,1), false);
		}

		if(GUI.Button(new Rect(Screen.width - 150, 0, 150,100), "HARD"))
		{
			Shader.EnableKeyword("HARD_SHADOW");
			Shader.DisableKeyword("SOFT_SHADOW_2x2");
			Shader.DisableKeyword("SOFT_SHADOW_4Samples");
			Shader.DisableKeyword("SOFT_SHADOW_4x4");
		}

		if(GUI.Button(new Rect(Screen.width - 150, 100, 150,100), "SOFT_2x2"))
		{
			Shader.DisableKeyword("HARD_SHADOW");
			Shader.EnableKeyword("SOFT_SHADOW_2x2");
			Shader.DisableKeyword("SOFT_SHADOW_4Samples");
			Shader.DisableKeyword("SOFT_SHADOW_4x4");
		}

		if(GUI.Button(new Rect(Screen.width - 150, 200, 150,100), "SOFT_4Samples"))
		{
			Shader.DisableKeyword("HARD_SHADOW");
			Shader.DisableKeyword("SOFT_SHADOW_2x2");
			Shader.EnableKeyword("SOFT_SHADOW_4Samples");
			Shader.DisableKeyword("SOFT_SHADOW_4x4");
		}

		if(GUI.Button(new Rect(Screen.width - 150, 300, 150,100), "SOFT_4x4"))
		{
			Shader.DisableKeyword("HARD_SHADOW");
			Shader.DisableKeyword("SOFT_SHADOW_2x2");
			Shader.DisableKeyword("SOFT_SHADOW_4Samples");
			Shader.EnableKeyword("SOFT_SHADOW_4x4");
		}
	}

	void LateUpdate()
	{
		depthCamera.cullingMask = casterLayer;
		depthCamera.orthographicSize = Size;
		depthCamera.farClipPlane = Far;

		depthCamera.Render();

//		RenderTexture temp = RenderTexture.GetTemporary(depthTexture.width, depthTexture.height, 16, RenderTextureFormat.ARGB32);
//		blur.CallOnRenderImage(depthTexture, temp);
//		Graphics.Blit(temp, depthTexture);
//		RenderTexture.ReleaseTemporary(temp);

		Matrix4x4 depthProjectionMatrix = depthCamera.projectionMatrix;
		Matrix4x4 depthViewMatrix = depthCamera.worldToCameraMatrix;
		Matrix4x4 depthVP = depthProjectionMatrix * depthViewMatrix ;
		Matrix4x4 depthVPBias = biasMatrix * depthVP;
		Shader.SetGlobalMatrix("_depthVPBias", depthVPBias);
		Shader.SetGlobalMatrix("_depthV", depthViewMatrix);
		Shader.SetGlobalTexture("_kkShadowMap", depthCamera.targetTexture);
		Shader.SetGlobalFloat("_bias", Bias);
		Shader.SetGlobalFloat("_strength", 1 - Strength);
		Shader.SetGlobalFloat("_texmapScale", 1f/TextureSize);
		Shader.SetGlobalFloat("_farplaneScale", 1/Far);
//		Debug.Log("farplane " + depthCamera.farClipPlane);

	}

	void aOnRenderImage (RenderTexture source, RenderTexture destination) {


//			depthTexture.hideFlags = HideFlags.HideAndDontSave;
//		Graphics.Blit( source, depthTexture );
//		Graphics.Blit (depthTexture, destination);
//		RenderTexture.ReleaseTemporary(depthTexture);
	}

	Color EncodeFloatRGBA( float v )
	{
		Vector4 kEncodeMul = new Vector4(1.0f, 255.0f, 65025.0f, 16581375.0f);
		float kEncodeBit = 1.0f/255.0f;
		Vector4 enc = kEncodeMul * v;
		enc = frac (enc);
		enc = new Vector4(enc.y, enc.z, enc.w, enc.w);
		enc -= enc * kEncodeBit;
		return enc;
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
