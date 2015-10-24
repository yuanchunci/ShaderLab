Shader "Effects/IceFront" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _ReflectionStrength ("ReflectionStrength", Range(1,20)) = 1
 _MainTex ("Base (RGB) Emission Tex (A)", 2D) = "white" {}
 _Opacity ("Material opacity", Range(-1,1)) = 0.5
 _Cube ("Reflection Cubemap", CUBE) = "" { TexGen CubeReflect }
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _FPOW ("FPOW Fresnel", Float) = 5
 _R0 ("R0 Fresnel", Float) = 0.05
 _Cutoff ("Cutoff", Range(0,1)) = 0.5
 _LightStr ("Light strength", Range(0,1)) = 1
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent+1" "RenderType"="Transperent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent+1" "RenderType"="Transperent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (gl_Normal * unity_Scale.w));
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_15;
  vec3 x2_18;
  vec3 x1_19;
  x1_19.x = dot (unity_SHAr, tmpvar_17);
  x1_19.y = dot (unity_SHAg, tmpvar_17);
  x1_19.z = dot (unity_SHAb, tmpvar_17);
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_18.x = dot (unity_SHBr, tmpvar_20);
  x2_18.y = dot (unity_SHBg, tmpvar_20);
  x2_18.z = dot (unity_SHBb, tmpvar_20);
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_16).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = ((x1_19 + x2_18) + (unity_SHC.xyz * ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y))));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _LightStr;
uniform float _Cutoff;
uniform float _Opacity;
uniform float _R0;
uniform float _FPOW;
uniform float _ReflectionStrength;
uniform vec4 _ReflectColor;
uniform vec4 _Color;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD2.xyz, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD3.xyz, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD4.xyz, normal_4);
  vec3 tmpvar_6;
  tmpvar_6 = (((mix ((tmpvar_3 * _Color), (textureCube (_Cube, (tmpvar_2 - (2.0 * (dot (tmpvar_5, tmpvar_2) * tmpvar_5)))) * tmpvar_3.w), vec4((_R0 + ((1.0 - _R0) * pow (clamp ((1.0 - dot (normal_4, normalize(xlv_TEXCOORD1))), 0.0, 1.0), _FPOW))))).xyz * _ReflectColor.xyz) * _ReflectionStrength) * _LightStr);
  float tmpvar_7;
  if ((_Cutoff > tmpvar_3.w)) {
    tmpvar_7 = (tmpvar_3.w + _Opacity);
  } else {
    tmpvar_7 = 0.0;
  };
  vec4 c_8;
  c_8.xyz = ((_Color.xyz * _LightColor0.xyz) * (max (0.0, dot (normal_4, xlv_TEXCOORD5)) * 2.0));
  c_8.w = tmpvar_7;
  c_1.w = c_8.w;
  c_1.xyz = (c_8.xyz + (_Color.xyz * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_6);
  c_1.w = tmpvar_7;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 62 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c20
add o7.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1.w, c24.x
mov r1.xyz, c12
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c21.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r3, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c21.w
dp3 r0.y, r3, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c21.w
dp3 r0.y, r3, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o2.y, r2, r3
dp3 o6.y, r3, r4
mul o5, r0, c21.w
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 112 [_MainTex_ST]
Vector 128 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbkbkifcenglghdgoegpdilnlidbhaaniabaaaaaabealaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daajaaaaeaaaabaaemacaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaa
acaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
aaaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaadaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaafaaaaaaegaobaaaaaaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaaagaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform float _LightStr;
uniform float _Cutoff;
uniform float _Opacity;
uniform float _R0;
uniform float _FPOW;
uniform float _ReflectionStrength;
uniform vec4 _ReflectColor;
uniform vec4 _Color;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD2.xyz, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD3.xyz, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD4.xyz, normal_4);
  vec3 tmpvar_6;
  tmpvar_6 = (((mix ((tmpvar_3 * _Color), (textureCube (_Cube, (tmpvar_2 - (2.0 * (dot (tmpvar_5, tmpvar_2) * tmpvar_5)))) * tmpvar_3.w), vec4((_R0 + ((1.0 - _R0) * pow (clamp ((1.0 - dot (normal_4, normalize(xlv_TEXCOORD1))), 0.0, 1.0), _FPOW))))).xyz * _ReflectColor.xyz) * _ReflectionStrength) * _LightStr);
  float tmpvar_7;
  if ((_Cutoff > tmpvar_3.w)) {
    tmpvar_7 = (tmpvar_3.w + _Opacity);
  } else {
    tmpvar_7 = 0.0;
  };
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  c_1.xyz = (_Color.xyz * ((8.0 * tmpvar_8.w) * tmpvar_8.xyz));
  c_1.w = tmpvar_7;
  c_1.xyz = (c_1.xyz + tmpvar_6);
  c_1.w = tmpvar_7;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r1.xyz, r1, c13.w, -v0
dp3 r0.y, r2, c4
dp3 r0.w, -r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c13.w
dp3 r0.y, r2, c5
dp3 r0.w, -r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c13.w
dp3 r0.y, r2, c6
dp3 r0.w, -r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o2.y, r1, r2
mul o5, r0, c13.w
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o6.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 112 [unity_LightmapST]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedolmceelnfgaigfodaaoadigeddcgeghgabaaaaaabeaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceiagaaaaeaaaabaajcabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
ajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaaacaaaaaadcaaaaal
lcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaa
egambaaaaaaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaaaaaaaaadgaaaaag
bcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaa
akiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaaakiacaaaacaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaa
adaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaa
acaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaabkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
acaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaipccabaaaafaaaaaaegaobaaaaaaaaaaapgipcaaaacaaaaaa
beaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ahaaaaaaogikcaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform float _LightStr;
uniform float _Cutoff;
uniform float _Opacity;
uniform float _R0;
uniform float _FPOW;
uniform float _ReflectionStrength;
uniform vec4 _ReflectColor;
uniform vec4 _Color;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD2.xyz, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD3.xyz, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD4.xyz, normal_4);
  vec3 tmpvar_6;
  tmpvar_6 = (((mix ((tmpvar_3 * _Color), (textureCube (_Cube, (tmpvar_2 - (2.0 * (dot (tmpvar_5, tmpvar_2) * tmpvar_5)))) * tmpvar_3.w), vec4((_R0 + ((1.0 - _R0) * pow (clamp ((1.0 - dot (normal_4, normalize(xlv_TEXCOORD1))), 0.0, 1.0), _FPOW))))).xyz * _ReflectColor.xyz) * _ReflectionStrength) * _LightStr);
  float tmpvar_7;
  if ((_Cutoff > tmpvar_3.w)) {
    tmpvar_7 = (tmpvar_3.w + _Opacity);
  } else {
    tmpvar_7 = 0.0;
  };
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD5);
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_LightmapInd, xlv_TEXCOORD5);
  mat3 tmpvar_10;
  tmpvar_10[0].x = 0.816497;
  tmpvar_10[0].y = -0.408248;
  tmpvar_10[0].z = -0.408248;
  tmpvar_10[1].x = 0.0;
  tmpvar_10[1].y = 0.707107;
  tmpvar_10[1].z = -0.707107;
  tmpvar_10[2].x = 0.57735;
  tmpvar_10[2].y = 0.57735;
  tmpvar_10[2].z = 0.57735;
  c_1.xyz = (_Color.xyz * (((8.0 * tmpvar_8.w) * tmpvar_8.xyz) * dot (clamp ((tmpvar_10 * normal_4), 0.0, 1.0), ((8.0 * tmpvar_9.w) * tmpvar_9.xyz))));
  c_1.w = tmpvar_7;
  c_1.xyz = (c_1.xyz + tmpvar_6);
  c_1.w = tmpvar_7;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 36 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
mad r1.xyz, r1, c13.w, -v0
dp3 r0.y, r2, c4
dp3 r0.w, -r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c13.w
dp3 r0.y, r2, c5
dp3 r0.w, -r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c13.w
dp3 r0.y, r2, c6
dp3 r0.w, -r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o2.y, r1, r2
mul o5, r0, c13.w
dp3 o2.z, v2, r1
dp3 o2.x, r1, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o6.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 112 [unity_LightmapST]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedolmceelnfgaigfodaaoadigeddcgeghgabaaaaaabeaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefceiagaaaaeaaaabaajcabaaaafjaaaaaeegiocaaaaaaaaaaa
akaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagfaaaaaddccabaaaagaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
ajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaaacaaaaaadcaaaaal
lcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaa
egambaaaaaaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaaaaaaaaadgaaaaag
bcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaa
akiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaaakiacaaaacaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaa
adaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaa
acaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaabkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
acaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaipccabaaaafaaaaaaegaobaaaaaaaaaaapgipcaaaacaaaaaa
beaaaaaadcaaaaaldccabaaaagaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
ahaaaaaaogikcaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 unity_LightColor[8];
uniform vec4 unity_4LightAtten0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosX0;
uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (gl_Vertex.xyz - ((_World2Object * tmpvar_2).xyz * unity_Scale.w)));
  vec3 tmpvar_5;
  vec3 tmpvar_6;
  tmpvar_5 = TANGENT.xyz;
  tmpvar_6 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_7;
  tmpvar_7[0].x = tmpvar_5.x;
  tmpvar_7[0].y = tmpvar_6.x;
  tmpvar_7[0].z = gl_Normal.x;
  tmpvar_7[1].x = tmpvar_5.y;
  tmpvar_7[1].y = tmpvar_6.y;
  tmpvar_7[1].z = gl_Normal.y;
  tmpvar_7[2].x = tmpvar_5.z;
  tmpvar_7[2].y = tmpvar_6.z;
  tmpvar_7[2].z = gl_Normal.z;
  vec4 v_8;
  v_8.x = _Object2World[0].x;
  v_8.y = _Object2World[1].x;
  v_8.z = _Object2World[2].x;
  v_8.w = _Object2World[3].x;
  vec4 tmpvar_9;
  tmpvar_9.xyz = (tmpvar_7 * v_8.xyz);
  tmpvar_9.w = tmpvar_4.x;
  vec4 v_10;
  v_10.x = _Object2World[0].y;
  v_10.y = _Object2World[1].y;
  v_10.z = _Object2World[2].y;
  v_10.w = _Object2World[3].y;
  vec4 tmpvar_11;
  tmpvar_11.xyz = (tmpvar_7 * v_10.xyz);
  tmpvar_11.w = tmpvar_4.y;
  vec4 v_12;
  v_12.x = _Object2World[0].z;
  v_12.y = _Object2World[1].z;
  v_12.z = _Object2World[2].z;
  v_12.w = _Object2World[3].z;
  vec4 tmpvar_13;
  tmpvar_13.xyz = (tmpvar_7 * v_12.xyz);
  tmpvar_13.w = tmpvar_4.z;
  mat3 tmpvar_14;
  tmpvar_14[0] = _Object2World[0].xyz;
  tmpvar_14[1] = _Object2World[1].xyz;
  tmpvar_14[2] = _Object2World[2].xyz;
  vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * (gl_Normal * unity_Scale.w));
  vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_15;
  vec3 x2_18;
  vec3 x1_19;
  x1_19.x = dot (unity_SHAr, tmpvar_17);
  x1_19.y = dot (unity_SHAg, tmpvar_17);
  x1_19.z = dot (unity_SHAb, tmpvar_17);
  vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15.xyzz * tmpvar_15.yzzx);
  x2_18.x = dot (unity_SHBr, tmpvar_20);
  x2_18.y = dot (unity_SHBg, tmpvar_20);
  x2_18.z = dot (unity_SHBb, tmpvar_20);
  vec3 tmpvar_21;
  tmpvar_21 = (_Object2World * gl_Vertex).xyz;
  vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosX0 - tmpvar_21.x);
  vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosY0 - tmpvar_21.y);
  vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosZ0 - tmpvar_21.z);
  vec4 tmpvar_25;
  tmpvar_25 = (((tmpvar_22 * tmpvar_22) + (tmpvar_23 * tmpvar_23)) + (tmpvar_24 * tmpvar_24));
  vec4 tmpvar_26;
  tmpvar_26 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_22 * tmpvar_15.x) + (tmpvar_23 * tmpvar_15.y)) + (tmpvar_24 * tmpvar_15.z)) * inversesqrt(tmpvar_25))) * (1.0/((1.0 + (tmpvar_25 * unity_4LightAtten0)))));
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_7 * (((_World2Object * tmpvar_16).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD5 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD6 = (((x1_19 + x2_18) + (unity_SHC.xyz * ((tmpvar_15.x * tmpvar_15.x) - (tmpvar_15.y * tmpvar_15.y)))) + ((((unity_LightColor[0].xyz * tmpvar_26.x) + (unity_LightColor[1].xyz * tmpvar_26.y)) + (unity_LightColor[2].xyz * tmpvar_26.z)) + (unity_LightColor[3].xyz * tmpvar_26.w)));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec4 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _LightStr;
uniform float _Cutoff;
uniform float _Opacity;
uniform float _R0;
uniform float _FPOW;
uniform float _ReflectionStrength;
uniform vec4 _ReflectColor;
uniform vec4 _Color;
uniform samplerCube _Cube;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD2.w;
  tmpvar_2.y = xlv_TEXCOORD3.w;
  tmpvar_2.z = xlv_TEXCOORD4.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_4;
  normal_4.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD2.xyz, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD3.xyz, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD4.xyz, normal_4);
  vec3 tmpvar_6;
  tmpvar_6 = (((mix ((tmpvar_3 * _Color), (textureCube (_Cube, (tmpvar_2 - (2.0 * (dot (tmpvar_5, tmpvar_2) * tmpvar_5)))) * tmpvar_3.w), vec4((_R0 + ((1.0 - _R0) * pow (clamp ((1.0 - dot (normal_4, normalize(xlv_TEXCOORD1))), 0.0, 1.0), _FPOW))))).xyz * _ReflectColor.xyz) * _ReflectionStrength) * _LightStr);
  float tmpvar_7;
  if ((_Cutoff > tmpvar_3.w)) {
    tmpvar_7 = (tmpvar_3.w + _Opacity);
  } else {
    tmpvar_7 = 0.0;
  };
  vec4 c_8;
  c_8.xyz = ((_Color.xyz * _LightColor0.xyz) * (max (0.0, dot (normal_4, xlv_TEXCOORD5)) * 2.0));
  c_8.w = tmpvar_7;
  c_1.w = c_8.w;
  c_1.xyz = (c_8.xyz + (_Color.xyz * xlv_TEXCOORD6));
  c_1.xyz = (c_1.xyz + tmpvar_6);
  c_1.w = tmpvar_7;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_3_0
; 93 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o7.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1.w, c32.x
mov r1.xyz, c12
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c29.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r3, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3, r0, c29.w
dp3 r0.y, r3, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4, r0, c29.w
dp3 r0.y, r3, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o2.y, r2, r3
dp3 o6.y, r3, r4
mul o5, r0, c29.w
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o6.z, v2, r4
dp3 o6.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 112 [_MainTex_ST]
Vector 128 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlmnjhgoohbofhalegjepglonkffpgpomabaaaaaageaoaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaamaaaaeaaaabaacaadaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadiaaaaajhcaabaaa
aaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaabaaaaaahcccabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaa
acaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
aaaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaadaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaafaaaaaaegaobaaaaaaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahcccabaaaagaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaahaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_ReflectionStrength]
Float 4 [_FPOW]
Float 5 [_R0]
Float 6 [_Opacity]
Float 7 [_Cutoff]
Float 8 [_LightStr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
"ps_3_0
; 45 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c9, 0.00000000, 2.00000000, -1.00000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r2.xy, r0.wyzw, c9.y, c9.z
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
dp3 r0.y, v1, v1
rsq r0.y, r0.y
add_pp r0.x, -r0, c9.w
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
mul r1.xyz, r0.y, v1
dp3_pp r0.x, r2, r1
add_pp_sat r1.w, -r0.x, c9
pow_pp r0, r1.w, c4.x
dp3_pp r0.w, r2, v5
dp3_pp r3.x, r2, v2
dp3_pp r3.y, r2, v3
dp3_pp r3.z, r2, v4
mov_pp r0.z, r0.x
mov r0.y, c5.x
add r0.x, c9.w, -r0.y
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r2.w, r3, r1
mul r4.xyz, r3, r2.w
texld r3, v0, s0
mad r1.xyz, -r4, c9.y, r1
mul r3.xyz, r3, c1
texld r1.xyz, r1, s2
mad_pp r1.xyz, r3.w, r1, -r3
mad r0.x, r0, r0.z, c5
mad_pp r0.xyz, r0.x, r1, r3
mul r0.xyz, r0, c2
mul r0.xyz, r0, c3.x
mul r3.xyz, r0, c8.x
mov_pp r0.xyz, c1
mul_pp r1.xyz, v6, c1
max_pp r0.w, r0, c9.x
mul_pp r0.xyz, c0, r0
mul_pp r0.xyz, r0.w, r0
mad_pp r0.xyz, r0, c9.y, r1
add r1.x, r3.w, c6
add r0.w, -r3, c7.x
cmp r0.w, -r0, c9.x, r1.x
add_pp oC0.xyz, r0, r3
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Vector 48 [_Color]
Vector 64 [_ReflectColor]
Float 80 [_ReflectionStrength]
Float 88 [_FPOW]
Float 92 [_R0]
Float 96 [_Opacity]
Float 100 [_Cutoff]
Float 104 [_LightStr]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhebjdhieegmooppekcikimbniaodklhaabaaaaaadeahaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoeafaaaaeaaaaaaahjabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaa
aaaaaaaadkbabaaaaeaaaaaadgaaaaafecaabaaaaaaaaaaadkbabaaaafaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
abaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaacaaaaaaegbcbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaacaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegbcbaaaagaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaaacaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaafaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaadiaaaaajocaabaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaahaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhcaabaaaabaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegacbaaaabaaaaaadbaaaaaibcaabaaaaaaaaaaa
dkaabaaaacaaaaaabkiacaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaaaaaaaaaa
dkaabaaaacaaaaaaakiacaaaaaaaaaaaagaaaaaaabaaaaahiccabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_ReflectColor]
Float 2 [_ReflectionStrength]
Float 3 [_FPOW]
Float 4 [_R0]
Float 5 [_Opacity]
Float 6 [_Cutoff]
Float 7 [_LightStr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_3_0
; 40 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c8, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c9, 8.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c8.z, c8.w
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
dp3 r0.y, v1, v1
rsq r0.y, r0.y
add_pp r0.x, -r0, c8.y
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
mul r2.xyz, r0.y, v1
dp3_pp r0.x, r1, r2
add_pp_sat r0.w, -r0.x, c8.y
pow_pp r3, r0.w, c3.x
dp3_pp r0.x, r1, v2
dp3_pp r0.y, r1, v3
dp3_pp r0.z, r1, v4
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r1.w, r0, r1
mul r2.xyz, r0, r1.w
texld r0, v0, s0
mad r1.xyz, -r2, c8.z, r1
mov r1.w, c4.x
mul r0.xyz, r0, c0
texld r1.xyz, r1, s2
mad_pp r1.xyz, r0.w, r1, -r0
mov_pp r2.x, r3
add r1.w, c8.y, -r1
mad r1.w, r1, r2.x, c4.x
mad_pp r0.xyz, r1.w, r1, r0
texld r1, v5, s3
mul_pp r1.xyz, r1.w, r1
add r1.w, r0, c5.x
mul r0.xyz, r0, c1
mul r0.xyz, r0, c2.x
add r0.w, -r0, c6.x
cmp r0.w, -r0, c8.x, r1
mul r0.xyz, r0, c7.x
mul_pp r1.xyz, r1, c0
mad_pp oC0.xyz, r1, c9.x, r0
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 160
Vector 48 [_Color]
Vector 64 [_ReflectColor]
Float 80 [_ReflectionStrength]
Float 88 [_FPOW]
Float 92 [_R0]
Float 96 [_Opacity]
Float 100 [_Cutoff]
Float 104 [_LightStr]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlbmegnfdmiigoffknockiffloegmhnblabaaaaaaomagaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleafaaaaeaaaaaaagnabaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fidaaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaad
dcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
baaaaaahecaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaadgaaaaaf
bcaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaa
aeaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegacbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaaaacaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpcpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
afaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdcaaaaak
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaafaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaakgikcaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaagaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaadcaaaaakhccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaadkaabaaaacaaaaaa
bkiacaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaaaaaaaaaadkaabaaaacaaaaaa
akiacaaaaaaaaaaaagaaaaaaabaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_ReflectColor]
Float 2 [_ReflectionStrength]
Float 3 [_FPOW]
Float 4 [_R0]
Float 5 [_Opacity]
Float 6 [_Cutoff]
Float 7 [_LightStr]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_3_0
; 47 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_2d s4
def c8, 0.00000000, 2.00000000, -1.00000000, 8.00000000
def c9, -0.40824828, -0.70710677, 0.57735026, 1.00000000
def c10, -0.40824831, 0.70710677, 0.57735026, 0
def c11, 0.81649655, 0.00000000, 0.57735026, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
texld r0.yw, v0.zwzw, s1
mad_pp r2.xy, r0.wyzw, c8.y, c8.z
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
dp3 r0.y, v1, v1
rsq r0.y, r0.y
add_pp r0.x, -r0, c9.w
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
mul r1.xyz, r0.y, v1
dp3_pp r0.x, r2, r1
add_pp_sat r1.w, -r0.x, c9
pow_pp r0, r1.w, c3.x
dp3_pp r3.x, r2, v2
dp3_pp r3.y, r2, v3
dp3_pp r3.z, r2, v4
mov_pp r0.z, r0.x
mov r0.y, c4.x
add r0.x, c9.w, -r0.y
mov r1.x, v2.w
mov r1.z, v4.w
mov r1.y, v3.w
dp3 r2.w, r3, r1
mul r4.xyz, r3, r2.w
texld r3, v0, s0
mad r1.xyz, -r4, c8.y, r1
mul r3.xyz, r3, c0
texld r1.xyz, r1, s2
mad_pp r1.xyz, r3.w, r1, -r3
mad r0.x, r0, r0.z, c4
mad_pp r0.xyz, r0.x, r1, r3
mul r1.xyz, r0, c1
texld r0, v5, s4
mul r1.xyz, r1, c2.x
mul_pp r0.xyz, r0.w, r0
dp3_pp_sat r3.z, r2, c9
dp3_pp_sat r3.x, r2, c11
dp3_pp_sat r3.y, r2, c10
mul_pp r2.xyz, r0, r3
texld r0, v5, s3
mul_pp r0.xyz, r0.w, r0
dp3_pp r1.w, r2, c8.w
mul_pp r0.xyz, r0, r1.w
mul r1.xyz, r1, c7.x
mul_pp r0.xyz, r0, c0
add r1.w, r3, c5.x
add r0.w, -r3, c6.x
cmp r0.w, -r0, c8.x, r1
mad_pp oC0.xyz, r0, c8.w, r1
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_Cube] CUBE 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 48 [_Color]
Vector 64 [_ReflectColor]
Float 80 [_ReflectionStrength]
Float 88 [_FPOW]
Float 92 [_R0]
Float 96 [_Opacity]
Float 100 [_Cutoff]
Float 104 [_LightStr]
BindCB  "$Globals" 0
"ps_4_0
eefiecedioobckcmcjkdmbfmdgobfjnpkhonbegaabaaaaaabeaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmagaaaaeaaaaaaalhabaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafidaaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagcbaaaaddcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafbcaabaaa
aaaaaaaadkbabaaaadaaaaaadgaaaaafccaabaaaaaaaaaaadkbabaaaaeaaaaaa
dgaaaaafecaabaaaaaaaaaaadkbabaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
abaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaacaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
acaaaaaaegbcbaaaafaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaacaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egacbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaaaacaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaafaaaaaa
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
dkiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaiadpdcaaaaakicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaakgikcaaaaaaaaaaa
agaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaagaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaadaaaaaapgapbaaaaaaaaaaa
apcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaa
igaabaaaabaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaaegacbaaaabaaaaaabacaaaakecaabaaaadaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaagaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaa
dkaabaaaacaaaaaabkiacaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaaaaaaaaaa
dkaabaaaacaaaaaaakiacaaaaaaaaaaaagaaaaaaabaaaaahiccabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent+1" "RenderType"="Transperent" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Cutoff;
uniform float _Opacity;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  float tmpvar_4;
  if ((_Cutoff > tmpvar_2.w)) {
    tmpvar_4 = (tmpvar_2.w + _Opacity);
  } else {
    tmpvar_4 = 0.0;
  };
  vec4 c_5;
  c_5.xyz = ((_Color.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_3, normalize(xlv_TEXCOORD1))) * texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2))).w) * 2.0));
  c_5.w = tmpvar_4;
  c_1.xyz = c_5.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
mul r2.xyz, r1, v1.w
dp4 r3.z, c16, r0
mov r0, c9
dp4 r3.y, c16, r0
mov r1, c8
dp4 r3.x, c16, r1
mad r0.xyz, r3, c17.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
mad o1.zw, v3.xyxy, c19.xyxy, c19
mad o1.xy, v3, c18, c18.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_BumpMap_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkhbndccoildjpnmjdlbpknnphhddckanabaaaaaaneafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
faaeaaaaeaaaabaabeabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _World2Object;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (_World2Object * _WorldSpaceLightPos0).xyz);
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Cutoff;
uniform float _Opacity;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  float tmpvar_4;
  if ((_Cutoff > tmpvar_2.w)) {
    tmpvar_4 = (tmpvar_2.w + _Opacity);
  } else {
    tmpvar_4 = 0.0;
  };
  vec4 c_5;
  c_5.xyz = ((_Color.xyz * _LightColor0.xyz) * (max (0.0, dot (normal_3, xlv_TEXCOORD1)) * 2.0));
  c_5.w = tmpvar_4;
  c_1.xyz = c_5.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [_MainTex_ST]
Vector 10 [_BumpMap_ST]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c6
dp4 r3.z, c8, r0
mul r2.xyz, r1, v1.w
mov r0, c5
mov r1, c4
dp4 r3.y, c8, r0
dp4 r3.x, c8, r1
dp3 o2.y, r3, r2
dp3 o2.z, v2, r3
dp3 o2.x, r3, v1
mad o1.zw, v3.xyxy, c10.xyxy, c10
mad o1.xy, v3, c9, c9.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 144
Vector 112 [_MainTex_ST]
Vector 128 [_BumpMap_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhcpenjmbkhcicjlifmbjajdfokcbbkakabaaaaaafeaeaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoiacaaaaeaaaabaalkaaaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
beaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Cutoff;
uniform float _Opacity;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  float tmpvar_4;
  if ((_Cutoff > tmpvar_2.w)) {
    tmpvar_4 = (tmpvar_2.w + _Opacity);
  } else {
    tmpvar_4 = 0.0;
  };
  vec4 c_5;
  c_5.xyz = ((_Color.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_3, normalize(xlv_TEXCOORD1))) * ((float((xlv_TEXCOORD2.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz))).w)) * 2.0));
  c_5.w = tmpvar_4;
  c_1.xyz = c_5.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
mul r2.xyz, r1, v1.w
dp4 r3.z, c16, r0
mov r0, c9
dp4 r3.y, c16, r0
mov r1, c8
dp4 r3.x, c16, r1
mad r0.xyz, r3, c17.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 o3.w, r0, c15
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
mad o1.zw, v3.xyxy, c19.xyxy, c19
mad o1.xy, v3, c18, c18.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_BumpMap_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjfcijknmgohicnhnebbpaonjbggeahjpabaaaaaaneafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
faaeaaaaeaaaabaabeabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Cutoff;
uniform float _Opacity;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  float tmpvar_4;
  if ((_Cutoff > tmpvar_2.w)) {
    tmpvar_4 = (tmpvar_2.w + _Opacity);
  } else {
    tmpvar_4 = 0.0;
  };
  vec4 c_5;
  c_5.xyz = ((_Color.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_3, normalize(xlv_TEXCOORD1))) * (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD2, xlv_TEXCOORD2))).w * textureCube (_LightTexture0, xlv_TEXCOORD2).w)) * 2.0));
  c_5.w = tmpvar_4;
  c_1.xyz = c_5.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_3_0
; 28 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
mul r2.xyz, r1, v1.w
dp4 r3.z, c16, r0
mov r0, c9
dp4 r3.y, c16, r0
mov r1, c8
dp4 r3.x, c16, r1
mad r0.xyz, r3, c17.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
mad o1.zw, v3.xyxy, c19.xyxy, c19
mad o1.xy, v3, c18, c18.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_BumpMap_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkhbndccoildjpnmjdlbpknnphhddckanabaaaaaaneafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
faaeaaaaeaaaabaabeabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _BumpMap_ST;
uniform vec4 _MainTex_ST;
uniform mat4 _LightMatrix0;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.xy = ((gl_MultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.zw = ((gl_MultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  vec3 tmpvar_2;
  vec3 tmpvar_3;
  tmpvar_2 = TANGENT.xyz;
  tmpvar_3 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_4;
  tmpvar_4[0].x = tmpvar_2.x;
  tmpvar_4[0].y = tmpvar_3.x;
  tmpvar_4[0].z = gl_Normal.x;
  tmpvar_4[1].x = tmpvar_2.y;
  tmpvar_4[1].y = tmpvar_3.y;
  tmpvar_4[1].z = gl_Normal.y;
  tmpvar_4[2].x = tmpvar_2.z;
  tmpvar_4[2].y = tmpvar_3.z;
  tmpvar_4[2].z = gl_Normal.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_4 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD1;
varying vec4 xlv_TEXCOORD0;
uniform float _Cutoff;
uniform float _Opacity;
uniform vec4 _Color;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_BumpMap, xlv_TEXCOORD0.zw).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  float tmpvar_4;
  if ((_Cutoff > tmpvar_2.w)) {
    tmpvar_4 = (tmpvar_2.w + _Opacity);
  } else {
    tmpvar_4 = 0.0;
  };
  vec4 c_5;
  c_5.xyz = ((_Color.xyz * _LightColor0.xyz) * ((max (0.0, dot (normal_3, xlv_TEXCOORD1)) * texture2D (_LightTexture0, xlv_TEXCOORD2).w) * 2.0));
  c_5.w = tmpvar_4;
  c_1.xyz = c_5.xyz;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mov r0, c10
dp4 r3.z, c16, r0
mov r0, c9
dp4 r3.y, c16, r0
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r3.x, c16, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r3, r2
dp3 o2.z, v2, r3
dp3 o2.x, r3, v1
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Matrix 48 [_LightMatrix0]
Vector 176 [_MainTex_ST]
Vector 192 [_BumpMap_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedndnemdbhfhhabeejccejkphcmmcmcdnbabaaaaaakiafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ceaeaaaaeaaaabaaajabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaaaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaa
kgikcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaapgipcaaaabaaaaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaak
dccabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaa
aaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Opacity]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_3_0
; 21 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.00000000, 2.00000000, -1.00000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c4.y, c4.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v1
add_pp r0.z, -r0, c4.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.y, r0, r1
dp3 r0.x, v2, v2
mov_pp r1.xyz, c1
max_pp r0.y, r0, c4.x
texld r0.x, r0.x, s2
mul_pp r1.xyz, c0, r1
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
texld r0.w, v0, s0
add r1.x, r0.w, c2
add r0.w, -r0, c3.x
cmp r0.w, -r0, c4.x, r1.x
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 160 [_Opacity]
Float 164 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedchekmllbkmimbpolblnoomjbmgmhgejcabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbeadaaaaeaaaaaaamfaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
abaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaa
diaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaa
ahaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadbaaaaaibcaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
akaaaaaaaaaaaaaiccaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
akaaaaaaabaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Opacity]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_3_0
; 16 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c4, 0.00000000, 2.00000000, -1.00000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c4.y, c4.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c4.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.x, r0, v1
mov_pp r1.xyz, c1
mul_pp r1.xyz, c0, r1
max_pp r0.x, r0, c4
mul_pp r0.xyz, r0.x, r1
texld r0.w, v0, s0
add r1.x, r0.w, c2
add r0.w, -r0, c3.x
cmp r0.w, -r0, c4.x, r1.x
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 144
Vector 16 [_LightColor0]
Vector 48 [_Color]
Float 96 [_Opacity]
Float 100 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaolagpmkbaabjieaahjlmdghdlkocckeabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaacaaaaeaaaaaaajiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadbaaaaaibcaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaaaaaaaaaiccaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaaabaaaaahiccabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Opacity]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_3_0
; 26 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 2.00000000, -1.00000000, 1.00000000
def c5, 0.50000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c4.y, c4.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
add_pp r0.z, -r0, c4.w
rsq_pp r0.z, r0.z
mul_pp r1.xyz, r0.w, v1
rcp_pp r0.z, r0.z
dp3_pp r0.x, r0, r1
max_pp r0.y, r0.x, c4.x
rcp r0.z, v2.w
mad r1.xy, v2, r0.z, c5.x
texld r0.w, r1, s2
dp3 r0.x, v2, v2
cmp r0.z, -v2, c4.x, c4.w
mul_pp r0.z, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.z, r0
mov_pp r1.xyz, c1
mul_pp r1.xyz, c0, r1
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
texld r0.w, v0, s0
add r1.x, r0.w, c2
add r0.w, -r0, c3.x
cmp r0.w, -r0, c4.x, r1.x
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 160 [_Opacity]
Float 164 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecednjonkgghlnaejooaachdmbapdmbghmmnabaaaaaapiaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaiaeaaaaeaaaaaaaacabaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aoaaaaahgcaabaaaaaaaaaaaagbbbaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
gcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadbaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaa
adaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaakgakbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaaibcaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaaaaaaaaiccaabaaa
aaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaaabaaaaahiccabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Opacity]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"ps_3_0
; 22 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c4, 0.00000000, 2.00000000, -1.00000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r0.xy, r0.wyzw, c4.y, c4.z
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
dp3_pp r0.w, v1, v1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, v1
add_pp r0.z, -r0, c4.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.x, r0, r1
max_pp r1.x, r0, c4
dp3 r0.x, v2, v2
texld r0.x, r0.x, s2
texld r0.w, v2, s3
mul r0.w, r0.x, r0
mul_pp r1.x, r1, r0.w
mov_pp r0.xyz, c1
mul_pp r0.xyz, c0, r0
mul_pp r0.xyz, r1.x, r0
texld r0.w, v0, s0
add r1.x, r0.w, c2
add r0.w, -r0, c3.x
cmp r0.w, -r0, c4.x, r1.x
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 160 [_Opacity]
Float 164 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedajepjfdlgmkkbjphmoiicgaofbdppalkabaaaaaagaaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaadaaaaeaaaaaaanmaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dbaaaaaibcaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaa
aaaaaaaiccaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaa
abaaaaahiccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Opacity]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_3_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.00000000, 2.00000000, -1.00000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c4.y, c4.z
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c4.w
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
mov_pp r0.xyz, c1
dp3_pp r1.x, r1, v1
texld r0.w, v2, s2
max_pp r1.x, r1, c4
mul_pp r1.x, r1, r0.w
mul_pp r0.xyz, c0, r0
mul_pp r0.xyz, r1.x, r0
texld r0.w, v0, s0
add r1.x, r0.w, c2
add r0.w, -r0, c3.x
cmp r0.w, -r0, c4.x, r1.x
mul_pp oC0.xyz, r0, c4.y
mov_pp oC0.w, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 208
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 160 [_Opacity]
Float 164 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfejlammggkpfcdfpdbdeoblkhfknekmjabaaaaaajmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckmacaaaaeaaaaaaaklaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaapgapbaaaabaaaaaadiaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaai
bcaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaaaaaaaaai
ccaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaaakaaaaaaabaaaaah
iccabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
}
 }
}
Fallback "Reflective/Bumped Diffuse"
}