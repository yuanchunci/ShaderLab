#if UNITY_EDITOR
using UnityEditor;
using UnityEngine;
using System.IO;
using System.Collections;

class FBXPostprocessor : AssetPostprocessor
{
    
//
//	private string animPath = "/CrazyNitroxen/CatWarrior/Anim";
//
//	void OnPreprocessModel()
//    {
//        ModelImporter mi = (ModelImporter)assetImporter;
//        mi.globalScale = 1;
//		
//		if (!assetPath.Contains(animPath))
//			return;
//
//		/** if you need import materials change false to true at below code */
//		mi.importMaterials = false;
//
//		/**
//		mi.animationCompression = ModelImporterAnimationCompression.Off;
//        Materials for characters are created using the GenerateMaterials script.
//		mi.materialName = ModelImporterMaterialName.BasedOnMaterialName;
//		mi.materialSearch = ModelImporterMaterialSearch.Local;
//        mi.generateMaterials = 0;
//        **/
//    }
//
//    // This method is called immediately after importing an FBX.
//    void OnPostprocessModel(GameObject go)
//    {
//		if (!assetPath.Contains(animPath))
//			return;
//
//        // Assume an animation FBX has an @ in its name,
//        // to determine if an fbx is a character or an animation.
//        if (assetPath.Contains("@"))
//        {
//            // For animation FBX's all unnecessary Objects are removed.
//            // This is not required but improves clarity when browsing assets.
//
//            // Remove SkinnedMeshRenderers and their meshes.
//            foreach (SkinnedMeshRenderer smr in go.GetComponentsInChildren<SkinnedMeshRenderer>())
//            {
//                Object.DestroyImmediate(smr.sharedMesh, true);
//                Object.DestroyImmediate(smr.gameObject, true);
//            }
//			
//			//Remove the bones (temporarily not uesd) 
//            // Remove the bones.
//			foreach (Transform o in go.GetComponentInChildren<Transform>())
//                Object.DestroyImmediate(o.gameObject, true);
//        }
//    }
}
#endif


