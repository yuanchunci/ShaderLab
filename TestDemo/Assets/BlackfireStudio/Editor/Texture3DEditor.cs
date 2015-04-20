using UnityEngine;
using UnityEditor;
using BlackfireStudio;
using System.Collections;

public class Texture3DEditor : EditorWindow {

	static private Texture3DEditor mWindow;

	private Texture2D	mTexture2D	= null;
	private Texture3D	mTexture3D	= null;
	private int			miWidth		= 0;
	private int			miHeight	= 0;
	private int			miDepth		= 0;
	private string		msPath		= "";
	private string		msFullPath	= "";
	private string		msName		= "";

	private Vector2		mvScrollView	= Vector2.zero;

	static private float	mfFieldWidth	= 50.0f;
	static private float	mfLabelWidth	= 50.0f;
	static private float	mfMinWidth		= 221.0f;
	static private float	mfMinHeight		= 260.0f;


	[MenuItem("Window/Texture 3D Editor", false, 2015)]
	static void Init()
	{
		mWindow = (Texture3DEditor)EditorWindow.GetWindow(typeof(Texture3DEditor));
		mWindow.title = "Texture3D Editor";
		mWindow.minSize = new Vector2(mfMinWidth, mfMinHeight);
	}

	void OnGUI()
	{
		mvScrollView = EditorGUILayout.BeginScrollView(mvScrollView);
		
		EditorGUI.BeginChangeCheck();
		mTexture2D = EditorGUILayout.ObjectField(new GUIContent("Input Texture2D", msFullPath), mTexture2D, typeof(Texture2D), false) as Texture2D;
		if (EditorGUI.EndChangeCheck())
		{ Reset(); }

		EditorGUILayout.Space();

		mTexture3D = EditorGUILayout.ObjectField(new GUIContent("Output Texture3D"), mTexture3D, typeof(Texture3D), false) as Texture3D;;

		EditorGUIUtility.fieldWidth = mfFieldWidth;
		EditorGUIUtility.labelWidth = Screen.width - mfLabelWidth - 20.0f;
		miWidth = EditorGUILayout.IntField("Width", miWidth);
		miHeight = EditorGUILayout.IntField("Height", miHeight);
		miDepth = EditorGUILayout.IntField("Depth", miDepth);

		EditorGUILayout.Space();

		EditorGUILayout.BeginHorizontal();
		GUILayout.FlexibleSpace();
		if (GUILayout.Button("Reset"))
		{ Reset(); }
		if (GUILayout.Button("Convert"))
		{ Convert(); }
		EditorGUILayout.EndHorizontal();

		EditorGUILayout.EndScrollView();
	}

	private void Convert()
	{
		string path = msPath + msName + BlackfireStudio.Texture3DConverter.FilenameExtension;
		if (AssetDatabase.LoadAssetAtPath(path, typeof(Texture3D)) != null)
		{
			if (EditorUtility.DisplayDialog("Texture3D Editor", "The given Texture already exists.\nDo you want to replace it ?", "Ok", "Cancel"))
			{ Create(path); }
		}
		else
		{ Create(path); }

	}

	private void Create(string path)
	{
		mTexture3D = BlackfireStudio.Texture3DConverter.Convert(mTexture2D, miWidth, miHeight, miDepth);
		if (mTexture3D != null)
		{
			AssetDatabase.CreateAsset(mTexture3D, path);
			EditorGUIUtility.PingObject(mTexture3D);
		}
		else
		{ EditorUtility.DisplayDialog("Texture3D Editor", "Failed to create given Texture.", "Ok"); }
	}

	private void Reset()
	{
		miWidth		= mTexture2D ? mTexture2D.height						: 0;
		miHeight	= mTexture2D ? mTexture2D.height						: 0;
		miDepth		= mTexture2D ? mTexture2D.width / mTexture2D.height		: 0;
		msName		= mTexture2D ? mTexture2D.name							: "";
		msFullPath	= mTexture2D ? AssetDatabase.GetAssetPath(mTexture2D)	: "";
		msPath		= mTexture2D ? msFullPath.Split(new string[] { msName }, System.StringSplitOptions.RemoveEmptyEntries)[0] : "";
		mTexture3D	= null;
	}
}
