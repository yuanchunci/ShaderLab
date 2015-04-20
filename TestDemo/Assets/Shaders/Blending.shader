Shader "Simple Alpha Test" {
    Properties {
        _MainTex ("Base (RGB) Transparency (A)", 2D) = "" {}
        _Cut("Cutoff", Float) = 0
    }
    SubShader {
        Pass {
            // Only render pixels with an alpha larger than 50%
            AlphaTest Greater [_Cut]
            SetTexture [_MainTex] { combine texture }
        }
    }
}