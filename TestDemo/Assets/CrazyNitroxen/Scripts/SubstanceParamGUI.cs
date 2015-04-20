using UnityEngine;
using System;
using System.Collections;

public class SubstanceParamGUI : MonoBehaviour
{

    #region Public Fields
    public Rect mainGuiRect;
    public Vector2 scrollVal;
    public GameObject lightcapTransform;
    public Texture2D logo;
    public Rect logoRect;
    
    public float logoSidePadding;
    #endregion

    #region Private Fields
    private ProceduralPropertyDescription[] curProperties;
    private ProceduralMaterial lightcapSubstance;
    #endregion


    // Use this for initialization
    void Start()
    {
        logoRect = new Rect(Screen.width - logo.width - logoSidePadding, Screen.height - logo.height - logoSidePadding, logo.width, logo.height);
    

        if (!lightcapTransform)
        {
            lightcapTransform = GameObject.FindGameObjectWithTag("Substance");
            getProcedualPropertices();
            
        }
        else
        {
            getProcedualPropertices();
        }

    }

    void OnGUI()
    {
        mainGuiRect = new Rect(mainGuiRect.x, mainGuiRect.y, Screen.width * 0.25f, Screen.height);
        if (lightcapSubstance)
        {
            GUI.Window(0, mainGuiRect, VehiclePropertiesGUI, "LightCap handler");
        }
        else
        {
         
        }

        //place Logo
        GUI.Label(logoRect, logo);
    }

    void VehiclePropertiesGUI(int guiID)
    {
        //start GUI Layout
        scrollVal = GUILayout.BeginScrollView(scrollVal);


        //loop through properties
        int i = 0;
        while (i < curProperties.Length)
        {
            ProceduralPropertyDescription curProperty = curProperties[i];

			ProceduralPropertyType curtype = curProperties[i].type;


            //create some slider for the floats
            if (curtype == ProceduralPropertyType.Float)
            {
                if (curProperty.hasRange)
                {
                    GUILayout.Label(curProperty.name);
                    float curFloat = lightcapSubstance.GetProceduralFloat(curProperty.name);
                    float oldFloat = curFloat;
                    curFloat = GUILayout.HorizontalSlider(curFloat, curProperty.minimum, curProperty.maximum);
                    if (curFloat != oldFloat)
                    {
                        lightcapSubstance.SetProceduralFloat(curProperty.name, curFloat);
                    }

                }
            }
            else if (curtype == ProceduralPropertyType.Color4)
            {
                GUILayout.Label(curProperty.name);
                Color curColor = lightcapSubstance.GetProceduralColor(curProperty.name);
                Color oldColor = curColor;


                //get the last rectangle for this picker
                //Rect curRect = GUILayoutUtility.GetLastRect();


                if (curColor != oldColor)
                {
                    lightcapSubstance.SetProceduralColor(curProperty.name, curColor);
                }
            }
            else if (curtype == ProceduralPropertyType.Enum)
            {
                GUILayout.Label(curProperty.name);
                int enumVal = lightcapSubstance.GetProceduralEnum(curProperty.name);
                int oldEnumVal = enumVal;
                string[] enumOptions = curProperty.enumOptions;
                enumVal = GUILayout.SelectionGrid(enumVal, enumOptions, 1);
                if (enumVal != oldEnumVal)
                {
                    lightcapSubstance.SetProceduralEnum(curProperty.name, enumVal);
                }
            }

            i++;
        }


        //rebuild the substance material
        lightcapSubstance.RebuildTextures();

        GUILayout.EndScrollView();
    }

    void getProcedualPropertices( )
    {
        
        lightcapSubstance = lightcapTransform.renderer.sharedMaterial as ProceduralMaterial;
        curProperties = lightcapSubstance.GetProceduralPropertyDescriptions();
  
    }

}
