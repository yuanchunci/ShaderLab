using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif
using System.Collections;

namespace BlackfireStudio
{
	public class Texture3DConverter {

		/// <summary>
		/// Filename extension for a Texture3D.
		/// </summary>
		/// <value>The extension.</value>
		public static string FilenameExtension
		{ get { return ".asset"; } }

		/// <summary>
		/// Convert the specified Texture2D into a Texture3D.
		/// </summary>
		public static Texture3D Convert(Texture2D tex2D, int width, int height, int depth)
		{
			if (!ValidImport(tex2D))
			{ return null; }

			Color[]	c2D = tex2D.GetPixels();
			Color[] c3D = new Color[c2D.Length];

			for(int y = 0; y < height; ++y)
			{
				for(int x = 0; x < width * depth; ++x)
				{
					c3D[(x % width) + y * width + (x / width) * width * height] = c2D[x + y * width * depth];
				}
			}

			Texture3D tex3D = new Texture3D(width, height, depth, TextureFormat.ARGB32, false);
			tex3D.SetPixels(c3D);
			tex3D.wrapMode = TextureWrapMode.Clamp;
			tex3D.Apply();
			return tex3D;
		}

		/// <summary>
		/// Valids the import properties of the Texture2D.
		/// </summary>
		public static bool ValidImport(Texture2D tex2D)
		{
#if UNITY_EDITOR
			if (!tex2D)
			{ return false; }

			string path = AssetDatabase.GetAssetPath(tex2D);
			TextureImporter textureImporter = AssetImporter.GetAtPath(path) as TextureImporter;

			if (textureImporter.isReadable == false || textureImporter.mipmapEnabled == true || textureImporter.textureFormat != TextureImporterFormat.AutomaticTruecolor)
			{
				if (EditorUtility.DisplayDialog("Texture3D Converter", "The given Texture cannot be converted to a 3D Texture.\nChange import settings ?", "Ok", "Cancel"))
				{
					textureImporter.isReadable		= true;
					textureImporter.mipmapEnabled	= false;
					textureImporter.textureFormat	= TextureImporterFormat.AutomaticTruecolor;
					AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);
					return true;
				}
				return false;
			}
			return true;
#else
			return true;
#endif
		}
	}
}