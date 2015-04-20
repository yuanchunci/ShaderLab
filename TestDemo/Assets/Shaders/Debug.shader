Shader "Custom/Debug" {
Properties {
 _basetexture ("Diffuse (RGB) Alpha (A)", 2D) = "white" {}
 _normalmap ("Normal (RGB)", 2D) = "bump" {}
 _maskmap1 ("Mask 1 (RGBA)", 2D) = "black" {}
 _maskmap2 ("Mask 2 (RGBA)", 2D) = "black" {}
 _ambientscale ("Ambient Scale", Float) = 1
 _rimlightcolor ("Rim Light Color", Color) = (1,1,1,1)
 _rimlightscale ("Rim Light Scale", Float) = 1
 _rimlightblendtofull ("Rim Light Blend To Full", Range(0,1)) = 0
 _specularcolor ("Specular Color", Color) = (1,1,1,1)
 _specularexponent ("Specular Exponent", Float) = 1
 _specularscale ("Specular Scale", Float) = 1
 _specularblendtofull ("Specular Blend To Full", Range(0,1)) = 0
 _selfillumblendtofull ("Self-Illumination Blend To Full", Range(0,1)) = 0

}
SubShader { 
 LOD 400
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform float _selfillumblendtofull;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_10;
  tmpvar_10 = (max (tmpvar_3.w, _selfillumblendtofull) * tmpvar_5.xyz);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 rimlight_11;
  vec3 fresnel_12;
  float attenuation_13;
  vec4 color_14;
  color_14 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(normalize(xlv_TEXCOORD6));
  float tmpvar_16;
  tmpvar_16 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_17;
  tmpvar_17 = (_LightColor0.xyz * 2.0);
  attenuation_13 = 1.0;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_13 = tmpvar_16;
  };
  float tmpvar_18;
  tmpvar_18 = ((tmpvar_16 * 0.5) + 0.5);
  float tmpvar_19;
  tmpvar_19 = pow ((1.0 - clamp (dot (normal_6, tmpvar_15), 0.0, 1.0)), 5.0);
  fresnel_12.xy = vec2(tmpvar_19);
  fresnel_12.z = (1.0 - tmpvar_19);
  vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = clamp (dot (normal_6, tmpvar_15), 0.0, 1.0);
  vec3 tmpvar_21;
  tmpvar_21 = fresnel_12;
  vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_7;
  vec3 x2_23;
  vec3 x1_24;
  x1_24.x = dot (unity_SHAr, tmpvar_22);
  x1_24.y = dot (unity_SHAg, tmpvar_22);
  x1_24.z = dot (unity_SHAb, tmpvar_22);
  vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_23.x = dot (unity_SHBr, tmpvar_25);
  x2_23.y = dot (unity_SHBg, tmpvar_25);
  x2_23.z = dot (unity_SHBb, tmpvar_25);
  vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_5.xyz * (((vec3(tmpvar_18) * tmpvar_17) * attenuation_13) + (((x1_24 + x2_23) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))) * _ambientscale)));
  vec3 tmpvar_27;
  tmpvar_27 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_18) - xlv_TEXCOORD4)), tmpvar_15)), (tmpvar_4.w * _specularexponent))) * tmpvar_17) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_26 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_21.z) * tmpvar_16)) * attenuation_13);
  color_14.xyz = (tmpvar_26 + tmpvar_27);
  color_14.xyz = mix (color_14.xyz, tmpvar_27, tmpvar_3.zzz);
  vec4 v_28;
  v_28.x = unity_MatrixV[0].y;
  v_28.y = unity_MatrixV[1].y;
  v_28.z = unity_MatrixV[2].y;
  v_28.w = unity_MatrixV[3].y;
  vec4 tmpvar_29;
  tmpvar_29.w = 0.0;
  tmpvar_29.xyz = tmpvar_7;
  vec3 tmpvar_30;
  tmpvar_30 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_21.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_28, tmpvar_29), 0.0, 1.0));
  rimlight_11 = tmpvar_30;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_11 = tmpvar_30;
  };
  color_14.xyz = (color_14.xyz + rimlight_11);
  color_14.w = 1.0;
  c_1.w = color_14.w;
  c_1.xyz = (color_14.xyz + (tmpvar_5.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + tmpvar_10);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_basetexture_ST]
"vs_3_0
; 44 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c16, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c16.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c14.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
mul o4, r0, c14.w
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o6.xyz, c16.y
mad o1.xy, v3, c15, c15.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedkkmdeokakkfbhjilpjkpdhhfnobboceiabaaaaaaaaajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
bmahaaaaeaaaabaamhabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaa
ogikcaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaahaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadgaaaaaihccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaabaaaaaahbccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
baaaaaaheccabaaaahaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD0;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * tmpvar_2.xyz));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
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
Vector 15 [_basetexture_ST]
"vs_3_0
; 32 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c16.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c13.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c13.w
mad o1.xy, v3, c15, c15.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 160 [unity_LightmapST]
Vector 176 [_basetexture_ST]
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
eefiecedhojfakahdcjongjakkdnfjdohojeanggabaaaaaahaahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefclmafaaaaeaaaabaagpabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaadaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaa
akiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
dgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaa
bkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaacaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
acaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaacaaaaaaanaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_1 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = (tmpvar_7 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD7 = o_15;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform float _selfillumblendtofull;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_9;
  tmpvar_9 = pow (textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8)))).xyz, vec3(2.2, 2.2, 2.2));
  vec3 tmpvar_10;
  tmpvar_10 = (max (tmpvar_3.w, _selfillumblendtofull) * tmpvar_5.xyz);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 rimlight_12;
  vec3 fresnel_13;
  float attenuation_14;
  vec4 color_15;
  color_15 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(normalize(xlv_TEXCOORD6));
  float tmpvar_17;
  tmpvar_17 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_18;
  tmpvar_18 = (_LightColor0.xyz * 2.0);
  attenuation_14 = tmpvar_11.x;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_14 = (tmpvar_11.x * tmpvar_17);
  };
  float tmpvar_19;
  tmpvar_19 = ((tmpvar_17 * 0.5) + 0.5);
  float tmpvar_20;
  tmpvar_20 = pow ((1.0 - clamp (dot (normal_6, tmpvar_16), 0.0, 1.0)), 5.0);
  fresnel_13.xy = vec2(tmpvar_20);
  fresnel_13.z = (1.0 - tmpvar_20);
  vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = clamp (dot (normal_6, tmpvar_16), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = mix (fresnel_13, texture2D (_fresnelwarp, tmpvar_21).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_13 = tmpvar_22;
  vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_7;
  vec3 x2_24;
  vec3 x1_25;
  x1_25.x = dot (unity_SHAr, tmpvar_23);
  x1_25.y = dot (unity_SHAg, tmpvar_23);
  x1_25.z = dot (unity_SHAb, tmpvar_23);
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_24.x = dot (unity_SHBr, tmpvar_26);
  x2_24.y = dot (unity_SHBg, tmpvar_26);
  x2_24.z = dot (unity_SHBb, tmpvar_26);
  vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_5.xyz * (((vec3(tmpvar_19) * tmpvar_18) * attenuation_14) + (((x1_25 + x2_24) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))) * _ambientscale)));
  vec3 tmpvar_28;
  tmpvar_28 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_19) - xlv_TEXCOORD4)), tmpvar_16)), (tmpvar_4.w * _specularexponent))) * tmpvar_18) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_27 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_22.z) * tmpvar_17)) * attenuation_14);
  color_15.xyz = (tmpvar_27 + tmpvar_28);
  color_15.xyz = mix (color_15.xyz, tmpvar_28, tmpvar_3.zzz);
  vec4 v_29;
  v_29.x = unity_MatrixV[0].y;
  v_29.y = unity_MatrixV[1].y;
  v_29.z = unity_MatrixV[2].y;
  v_29.w = unity_MatrixV[3].y;
  vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = tmpvar_7;
  vec3 tmpvar_31;
  tmpvar_31 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_22.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_29, tmpvar_30), 0.0, 1.0));
  rimlight_12 = tmpvar_31;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = (tmpvar_31 * tmpvar_11.x);
  };
  color_15.xyz = (color_15.xyz + rimlight_12);
  color_15.xyz = (color_15.xyz + mix (((tmpvar_9 * _envmapintensity) * tmpvar_4.x), ((tmpvar_9 * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness)));
  color_15.w = 1.0;
  c_1.w = color_15.w;
  c_1.xyz = (color_15.xyz + (tmpvar_5.xyz * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + tmpvar_10);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_Scale]
Vector 17 [_basetexture_ST]
"vs_3_0
; 49 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c18.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c16.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c16.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c16.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.z
mul r1.y, r1, c13.x
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mad o8.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o8.zw, r0
mov o6.xyz, c18.y
mad o1.xy, v3, c17, c17.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedagmljfjapphobemmlkbaholegddgcnpgabaaaaaalaajaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleahaaaaeaaaabaa
onabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaa
aoaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaal
lcaabaaaacaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaaabaaaaaa
egaibaaaacaaaaaadgaaaaaficaabaaaadaaaaaaakaabaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aeaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaa
diaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaadgaaaaag
bcaabaaaafaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaafaaaaaa
akiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaafaaaaaaakiacaaaadaaaaaa
aoaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
baaaaaahbcaabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaafaaaaaabaaaaaah
ecaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaafaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaadaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaa
adaaaaaabkaabaaaacaaaaaadgaaaaagbcaabaaaafaaaaaabkiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaafaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaafaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaafaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaafaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaadaaaaaapgipcaaa
adaaaaaabeaaaaaadgaaaaagbcaabaaaadaaaaaackiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaahaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaai
hccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaah
bccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
ahaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaaiaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 o_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_1 * 0.5);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD4 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = o_14;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  vec4 c_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_3;
  normal_3.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_1.xyz = (tmpvar_2.xyz * max (min (vec3(1.0, 1.0, 1.0), ((tmpvar_4.x * 2.0) * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz)), tmpvar_4.xxx));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * tmpvar_2.xyz));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_basetexture_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c18.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c15.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp4 r1.w, v0, c3
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c15.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c15.w
dp3 r0.y, r1, c6
dp4 r1.z, v0, c2
dp3 r0.w, -r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c18.y
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c15.w
mov r0.x, r2
mul r0.y, r2, c13.x
mad o6.xy, r2.z, c14.zwzw, r0
mov o0, r1
mov o6.zw, r1
mad o1.xy, v3, c17, c17.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Vector 224 [unity_LightmapST]
Vector 240 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedeibnombfgbiglfaflfddcfcmelkmahmcabaaaaaacaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcfeagaaaaeaaaabaajfabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
abaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaaegaibaaaacaaaaaadcaaaaal
lcaabaaaabaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaabaaaaaa
egambaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaag
bcaabaaaaeaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaa
akiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaacaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaa
acaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaaeaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
acaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform float _selfillumblendtofull;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec3 tmpvar_10;
  tmpvar_10 = (max (tmpvar_3.w, _selfillumblendtofull) * tmpvar_5);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 tmpvar_11;
  tmpvar_11 = tmpvar_4;
  vec3 rimlight_12;
  vec3 fresnel_13;
  float attenuation_14;
  vec4 color_15;
  color_15 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(normalize(xlv_TEXCOORD6));
  float tmpvar_17;
  tmpvar_17 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_18;
  tmpvar_18 = (_LightColor0.xyz * 2.0);
  attenuation_14 = 1.0;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_14 = tmpvar_17;
  };
  float tmpvar_19;
  tmpvar_19 = ((tmpvar_17 * 0.5) + 0.5);
  float tmpvar_20;
  tmpvar_20 = pow ((1.0 - clamp (dot (normal_6, tmpvar_16), 0.0, 1.0)), 5.0);
  fresnel_13.xy = vec2(tmpvar_20);
  fresnel_13.z = (1.0 - tmpvar_20);
  vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = clamp (dot (normal_6, tmpvar_16), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = mix (fresnel_13, texture2D (_fresnelwarp, tmpvar_21).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_13 = tmpvar_22;
  vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_7;
  vec3 x2_24;
  vec3 x1_25;
  x1_25.x = dot (unity_SHAr, tmpvar_23);
  x1_25.y = dot (unity_SHAg, tmpvar_23);
  x1_25.z = dot (unity_SHAb, tmpvar_23);
  vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_24.x = dot (unity_SHBr, tmpvar_26);
  x2_24.y = dot (unity_SHBg, tmpvar_26);
  x2_24.z = dot (unity_SHBb, tmpvar_26);
  vec3 tmpvar_27;
  tmpvar_27 = (tmpvar_5 * (((vec3(tmpvar_19) * tmpvar_18) * attenuation_14) + (((x1_25 + x2_24) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))) * _ambientscale)));
  tmpvar_11.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_28;
  tmpvar_28 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_19) - xlv_TEXCOORD4)), tmpvar_16)), (tmpvar_4.w * _specularexponent))) * tmpvar_18) * _specularscale) * max (tmpvar_11.x, _specularblendtofull)) * ((mix ((tmpvar_27 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_22.z) * tmpvar_17)) * attenuation_14);
  color_15.xyz = (tmpvar_27 + tmpvar_28);
  color_15.xyz = mix (color_15.xyz, tmpvar_28, tmpvar_3.zzz);
  vec4 v_29;
  v_29.x = unity_MatrixV[0].y;
  v_29.y = unity_MatrixV[1].y;
  v_29.z = unity_MatrixV[2].y;
  v_29.w = unity_MatrixV[3].y;
  vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = tmpvar_7;
  vec3 tmpvar_31;
  tmpvar_31 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_22.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_29, tmpvar_30), 0.0, 1.0));
  rimlight_12 = tmpvar_31;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = tmpvar_31;
  };
  color_15.xyz = (color_15.xyz + rimlight_12);
  color_15.xyz = (color_15.xyz + mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_11.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness)));
  color_15.w = 1.0;
  color_15.xyz = pow (color_15.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.w = color_15.w;
  c_1.xyz = (color_15.xyz + (tmpvar_5 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + tmpvar_10);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_basetexture_ST]
"vs_3_0
; 44 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c16, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c16.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c14.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
mul o4, r0, c14.w
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mov o6.xyz, c16.y
mad o1.xy, v3, c15, c15.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedkkmdeokakkfbhjilpjkpdhhfnobboceiabaaaaaaaaajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
bmahaaaaeaaaabaamhabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaa
ogikcaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaahaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadgaaaaaihccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaabaaaaaahbccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
baaaaaaheccabaaaahaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD0;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_3;
  normal_3.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * tmpvar_2));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
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
Vector 15 [_basetexture_ST]
"vs_3_0
; 32 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c16.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c13.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c13.w
mad o1.xy, v3, c15, c15.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 160 [unity_LightmapST]
Vector 176 [_basetexture_ST]
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
eefiecedhojfakahdcjongjakkdnfjdohojeanggabaaaaaahaahaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefclmafaaaaeaaaabaagpabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaag
ccaabaaaadaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaa
akiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
adaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
dgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaaadaaaaaa
bkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaaacaaaaaa
anaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaa
egbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
abaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaa
acaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaacaaaaaaanaaaaaa
dgaaaaagecaabaaaabaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 o_15;
  vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_1 * 0.5);
  vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_7 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD6 = (tmpvar_7 * (((_World2Object * tmpvar_14).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD7 = o_15;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD7;
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform float _selfillumblendtofull;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _ShadowMapTexture;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec3 tmpvar_10;
  tmpvar_10 = (max (tmpvar_3.w, _selfillumblendtofull) * tmpvar_5);
  vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD7);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  vec4 tmpvar_12;
  tmpvar_12 = tmpvar_4;
  vec3 rimlight_13;
  vec3 fresnel_14;
  float attenuation_15;
  vec4 color_16;
  color_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(normalize(xlv_TEXCOORD6));
  float tmpvar_18;
  tmpvar_18 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_19;
  tmpvar_19 = (_LightColor0.xyz * 2.0);
  attenuation_15 = tmpvar_11.x;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_15 = (tmpvar_11.x * tmpvar_18);
  };
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_18 * 0.5) + 0.5);
  float tmpvar_21;
  tmpvar_21 = pow ((1.0 - clamp (dot (normal_6, tmpvar_17), 0.0, 1.0)), 5.0);
  fresnel_14.xy = vec2(tmpvar_21);
  fresnel_14.z = (1.0 - tmpvar_21);
  vec2 tmpvar_22;
  tmpvar_22.y = 0.0;
  tmpvar_22.x = clamp (dot (normal_6, tmpvar_17), 0.0, 1.0);
  vec3 tmpvar_23;
  tmpvar_23 = mix (fresnel_14, texture2D (_fresnelwarp, tmpvar_22).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_14 = tmpvar_23;
  vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_7;
  vec3 x2_25;
  vec3 x1_26;
  x1_26.x = dot (unity_SHAr, tmpvar_24);
  x1_26.y = dot (unity_SHAg, tmpvar_24);
  x1_26.z = dot (unity_SHAb, tmpvar_24);
  vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_25.x = dot (unity_SHBr, tmpvar_27);
  x2_25.y = dot (unity_SHBg, tmpvar_27);
  x2_25.z = dot (unity_SHBb, tmpvar_27);
  vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_5 * (((vec3(tmpvar_20) * tmpvar_19) * attenuation_15) + (((x1_26 + x2_25) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y)))) * _ambientscale)));
  tmpvar_12.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_29;
  tmpvar_29 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_20) - xlv_TEXCOORD4)), tmpvar_17)), (tmpvar_4.w * _specularexponent))) * tmpvar_19) * _specularscale) * max (tmpvar_12.x, _specularblendtofull)) * ((mix ((tmpvar_28 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_23.z) * tmpvar_18)) * attenuation_15);
  color_16.xyz = (tmpvar_28 + tmpvar_29);
  color_16.xyz = mix (color_16.xyz, tmpvar_29, tmpvar_3.zzz);
  vec4 v_30;
  v_30.x = unity_MatrixV[0].y;
  v_30.y = unity_MatrixV[1].y;
  v_30.z = unity_MatrixV[2].y;
  v_30.w = unity_MatrixV[3].y;
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = tmpvar_7;
  vec3 tmpvar_32;
  tmpvar_32 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_23.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_30, tmpvar_31), 0.0, 1.0));
  rimlight_13 = tmpvar_32;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_13 = (tmpvar_32 * tmpvar_11.x);
  };
  color_16.xyz = (color_16.xyz + rimlight_13);
  color_16.xyz = (color_16.xyz + mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_12.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness)));
  color_16.w = 1.0;
  color_16.xyz = pow (color_16.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.w = color_16.w;
  c_1.xyz = (color_16.xyz + (tmpvar_5 * xlv_TEXCOORD5));
  c_1.xyz = (c_1.xyz + tmpvar_10);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_Scale]
Vector 17 [_basetexture_ST]
"vs_3_0
; 49 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
dcl_texcoord7 o8
def c18, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c18.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c16.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c16.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c16.w
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.z
mul r1.y, r1, c13.x
dp3 o5.y, r2, r4
dp3 o7.y, r2, r3
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o7.z, v2, r3
dp3 o7.x, v1, r3
mad o8.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o8.zw, r0
mov o6.xyz, c18.y
mad o1.xy, v3, c17, c17.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedagmljfjapphobemmlkbaholegddgcnpgabaaaaaalaajaaaaadaaaaaa
cmaaaaaapeaaaaaapeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheopiaaaaaaajaaaaaa
aiaaaaaaoaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaomaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaomaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaomaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaomaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaaomaaaaaaahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcleahaaaaeaaaabaa
onabaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaagfaaaaadpccabaaa
aiaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaa
aoaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
abaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaaegacbaaaacaaaaaadcaaaaal
lcaabaaaacaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaaabaaaaaa
egaibaaaacaaaaaadgaaaaaficaabaaaadaaaaaaakaabaaaacaaaaaadiaaaaah
hcaabaaaaeaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aeaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaa
diaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgbpbaaaabaaaaaadgaaaaag
bcaabaaaafaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaafaaaaaa
akiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaafaaaaaaakiacaaaadaaaaaa
aoaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
baaaaaahbcaabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaafaaaaaabaaaaaah
ecaabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaafaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaadaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaa
adaaaaaabkaabaaaacaaaaaadgaaaaagbcaabaaaafaaaaaabkiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaafaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaafaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaafaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaafaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaadaaaaaapgipcaaa
adaaaaaabeaaaaaadgaaaaagbcaabaaaadaaaaaackiacaaaadaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaahaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaai
hccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabaaaaaah
bccabaaaahaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
ahaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaaiaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaiaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _ProjectionParams;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
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
  vec4 o_14;
  vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_1 * 0.5);
  vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_9 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_11 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_13 * unity_Scale.w);
  xlv_TEXCOORD4 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD5 = o_14;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD5;
varying vec2 xlv_TEXCOORD4;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_3;
  normal_3.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_3.z = sqrt((1.0 - clamp (dot (normal_3.xy, normal_3.xy), 0.0, 1.0)));
  vec4 tmpvar_4;
  tmpvar_4 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD5);
  c_1.xyz = (tmpvar_2 * max (min (vec3(1.0, 1.0, 1.0), ((tmpvar_4.x * 2.0) * texture2D (unity_Lightmap, xlv_TEXCOORD4).xyz)), tmpvar_4.xxx));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * tmpvar_2));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_basetexture_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c18.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c15.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp4 r1.w, v0, c3
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c15.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c15.w
dp3 r0.y, r1, c6
dp4 r1.z, v0, c2
dp3 r0.w, -r2, c6
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c18.y
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c15.w
mov r0.x, r2
mul r0.y, r2, c13.x
mad o6.xy, r2.z, c14.zwzw, r0
mov o0, r1
mov o6.zw, r1
mad o1.xy, v3, c17, c17.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Vector 224 [unity_LightmapST]
Vector 240 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedeibnombfgbiglfaflfddcfcmelkmahmcabaaaaaacaaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcfeagaaaaeaaaabaajfabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacafaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaacaaaaaafgafbaiaebaaaaaa
abaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaiaebaaaaaaabaaaaaaegaibaaaacaaaaaadcaaaaal
lcaabaaaabaaaaaaegiicaaaacaaaaaaaoaaaaaakgakbaiaebaaaaaaabaaaaaa
egambaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
adaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaag
bcaabaaaaeaaaaaaakiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaa
akiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaacaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaaficaabaaa
acaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaacaaaaaa
amaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaacaaaaaaanaaaaaadgaaaaag
ecaabaaaaeaaaaaabkiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaacaaaaaackiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
acaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_selfillumblendtofull]
Float 18 [_specularexponent]
Float 19 [_specularblendtofull]
Vector 20 [_specularcolor]
Float 21 [_specularscale]
Float 22 [_maskenvbymetalness]
Float 23 [_envmapintensity]
Float 24 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
"ps_3_0
; 110 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c25, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c26, 5.00000000, 0.50000000, 2.20000005, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0, s3
mad_pp r0.xy, r0.wyzw, c25.x, c25.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c25
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r5.w, r0, v2
dp3_pp r4.w, r0, v3
dp3_pp r3.w, r0, v1
mul_pp r0.w, r5, r5
mov r3.y, r4.w
mov r3.x, r5.w
mov r3.z, c25
mul_pp r1, r3.wxyy, r3.xyyw
dp4 r2.z, r3.wxyz, c7
dp4 r2.y, r3.wxyz, c6
dp4 r2.x, r3.wxyz, c5
dp4 r3.z, r1, c10
dp4 r3.y, r1, c9
dp4 r3.x, r1, c8
mad_pp r0.w, r3, r3, -r0
add_pp r2.xyz, r2, r3
mul r1.xyz, r0.w, c11
dp3_pp_sat r6.w, r0, v4
add_pp r1.xyz, r2, r1
mul_pp r2.xyz, r1, c13.x
mov_pp r1.xyz, c12
abs_pp r1.w, -c4
mul_pp r3.xyz, c25.x, r1
mad_pp r0.w, r6, c26.y, c26.y
mul_pp r1.xyz, r0.w, r3
cmp_pp r2.w, -r1, c25.z, r6
mad_pp r1.xyz, r1, r2.w, r2
texld r2.xyz, v0, s2
mul_pp r4.xyz, r2, r1
texld r8.zw, v0, s0
add_pp r6.xyz, r8.z, r4
dp3_pp r1.x, v6, v6
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, v6
texld r1, v0, s1
add_pp r7.xyz, -r6, c20
mad_pp r7.xyz, r1.z, r7, r6
dp3_pp r7.w, r5, r5
rsq_pp r7.w, r7.w
mul_pp r5.xyz, r7.w, r5
dp3_pp_sat r6.x, r0, r5
mov_pp r6.y, c25.w
add_pp r1.z, -r6.x, c25
texld r9.xz, r6, s5
mul_pp r6.xyz, r0, r0.w
pow_pp r0, r1.z, c26.x
mad_pp r6.xyz, r6, c25.x, -v4
mov_pp r8.x, r0
dp3_pp r0.y, r6, r6
rsq_pp r0.x, r0.y
mul_pp r0.xyz, r0.x, r6
dp3_pp r0.x, r5, r0
add_pp r8.y, -r8.x, c25.z
max_pp r1.z, r0.x, c25.w
mul_pp r1.w, r1, c18.x
pow_pp r0, r1.z, r1.w
add_pp r6.xy, r9.xzzw, -r8
mad_pp r1.zw, r6.xyxy, c24.x, r8.xyxy
mov_pp r0.w, r0.x
mul_pp r6.xyz, r3, r0.w
mul_pp r5.xyz, r1.w, r7
mul_pp r0.xyz, r6.w, r5
mov_pp r5.z, r4.w
mov_pp r5.x, r3.w
mov_pp r5.y, r5.w
mov r3.x, v1.w
mov r3.z, v3.w
mov r3.y, v2.w
dp3_pp r0.w, r5, r3
mul_pp r7.xyz, r5, r0.w
mad_pp r3.xyz, -r7, c25.x, r3
texld r3.xyz, r3, s4
max_pp r0.w, r1.x, c19.x
mul_pp r6.xyz, r6, c21.x
mul_pp r6.xyz, r6, r0.w
mul_pp r6.xyz, r6, r0
pow r0, r3.x, c26.z
mad_pp r6.xyz, r2.w, r6, r4
mov r3.x, r0
pow r0, r3.z, c26.z
mad_pp r6.xyz, r8.z, -r4, r6
pow r4, r3.y, c26.z
max_pp r0.w, r1.y, c15.x
mul_pp r0.w, r0, r1.z
mov r3.z, r0
mov r3.y, r4
mul_pp r0.xyz, r3, c23.x
mul_pp r3.xyz, r1.x, r0
mad_pp r0.xyz, r8.z, r0, -r3
mad_pp r1.xyz, r0, c22.x, r3
mul_pp r0.w, r0, c14.x
mul_pp r0.xyz, r0.w, c16
dp3_pp_sat r0.w, r5, c1
mad_pp r0.xyz, r0, r0.w, r6
add_pp r0.xyz, r0, r1
mad_pp r1.xyz, r2, v5, r0
max_pp r0.x, r8.w, c17
mad_pp oC0.xyz, r0.x, r2, r1
mov_pp oC0.w, c25.z
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 2
SetTexture 1 [_maskmap2] 2D 3
SetTexture 2 [_basetexture] 2D 0
SetTexture 3 [_normalmap] 2D 1
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 48 [_ambientscale]
Float 52 [_rimlightscale]
Float 56 [_rimlightblendtofull]
Vector 64 [_rimlightcolor] 3
Float 76 [_selfillumblendtofull]
Float 80 [_specularexponent]
Float 84 [_specularblendtofull]
Vector 96 [_specularcolor] 3
Float 108 [_specularscale]
Float 112 [_maskenvbymetalness]
Float 116 [_envmapintensity]
Float 120 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedmehjfbkgjdbeofknlmbphebdindgkgobabaaaaaagaaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbaanaaaaeaaaaaaaeeadaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaadgaaaaafccaabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaahaaaaaa
egbcbaaaahaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaidcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaakgikcaaaaaaaaaaaahaaaaaaegaabaaaaaaaaaaa
egaabaaaaeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaah
ecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaa
egbcbaaaadaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaa
adaaaaaaegakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaagaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaa
cmaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagiacaaaaaaaaaaaadaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajhcaabaaaafaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaaaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaadjaaaaaiicaabaaaaaaaaaaadkiacaaaabaaaaaaaaaaaaaaabeaaaaa
aaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajhcaabaaaaeaaaaaaegacbaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaahaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaaiaaaaaa
egacbaaaahaaaaaaegacbaaaaeaaaaaakgakbaaaagaaaaaaaaaaaaajhcaabaaa
ajaaaaaaegacbaiaebaaaaaaaiaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaakaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaaiaaaaaakgakbaaaakaaaaaaegacbaaaajaaaaaaegacbaaa
aiaaaaaadiaaaaahhcaabaaaaiaaaaaafgafbaaaaaaaaaaaegacbaaaaiaaaaaa
diaaaaahhcaabaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaaiaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
cpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
dkaabaaaakaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaafaaaaaafgafbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaa
deaaaaaiccaabaaaaaaaaaaaakaabaaaakaaaaaabkiacaaaaaaaaaaaafaaaaaa
diaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaaiaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaahaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakocaabaaa
aaaaaaaaagajbaaaabaaaaaapgapbaaaaaaaaaaaagajbaiaebaaaaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaakgakbaaaagaaaaaafgaobaaaaaaaaaaaagajbaaa
acaaaaaadeaaaaaibcaabaaaabaaaaaabkaabaaaakaaaaaackiacaaaaaaaaaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dgaaaaagbcaabaaaacaaaaaabkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaa
acaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaaacaaaaaabkiacaaa
acaaaaaaahaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaacaaaaaadgaaaaaf
ccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaadkbabaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaadiaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaamnmmameamnmmameamnmmamea
aaaaaaaabjaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaakaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaakgakbaaaagaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaai
icaabaaaaaaaaaaadkaabaaaagaaaaaadkiacaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaahaaaaaaegbcbaaaagaaaaaaegacbaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaahaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
"ps_3_0
; 3 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
texld r0.w, v0, s0
texld r0.xyz, v0, s1
max_pp r0.w, r0, c0.x
mad_pp oC0.xyz, r0.w, r0, r0
mov_pp oC0.w, c1.x
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
ConstBuffer "$Globals" 192
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedajoidplllekfemoomlajgeibkbpnaoidabaaaaaadeacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaa
eaaaaaaaefaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadeaaaaaibcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_selfillumblendtofull]
Float 18 [_specularexponent]
Float 19 [_specularblendtofull]
Vector 20 [_specularcolor]
Float 21 [_specularscale]
Float 22 [_maskenvbymetalness]
Float 23 [_envmapintensity]
Float 24 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_ShadowMapTexture] 2D 5
SetTexture 6 [_fresnelwarp] 2D 6
"ps_3_0
; 114 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
def c25, 2.00000000, -1.00000000, 1.00000000, 0.50000000
def c26, 0.00000000, 5.00000000, 2.20000005, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7
texld r0.yw, v0, s3
mad_pp r0.xy, r0.wyzw, c25.x, c25.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c25
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r7.w, r0, v2
dp3_pp r3.w, r0, v1
dp3_pp r5.w, r0, v3
mul_pp r0.w, r7, r7
mov r1.x, r3.w
mov r1.y, r7.w
mov r1.z, r5.w
mov r1.w, c25.z
mul_pp r2, r1.xyzz, r1.yzzx
dp4 r3.z, r1, c7
dp4 r3.y, r1, c6
dp4 r3.x, r1, c5
dp3_pp_sat r6.w, r0, v4
texldp r8.x, v7, s5
texld r8.zw, v0, s0
dp4 r1.z, r2, c10
dp4 r1.y, r2, c9
dp4 r1.x, r2, c8
mad_pp r0.w, r3, r3, -r0
mul r2.xyz, r0.w, c11
add_pp r1.xyz, r3, r1
add_pp r1.xyz, r1, r2
mul_pp r2.xyz, r1, c13.x
mov_pp r1.xyz, c12
mad_pp r0.w, r6, c25, c25
mul_pp r3.xyz, c25.x, r1
mul_pp r1.xyz, r0.w, r3
mul_pp r1.w, r6, r8.x
abs_pp r2.w, -c4
cmp_pp r4.w, -r2, r8.x, r1
mad_pp r1.xyz, r1, r4.w, r2
texld r2.xyz, v0, s2
mul_pp r4.xyz, r2, r1
add_pp r6.xyz, r8.z, r4
dp3_pp r1.x, v6, v6
rsq_pp r1.x, r1.x
mul_pp r5.xyz, r1.x, v6
dp3_pp r8.y, r5, r5
texld r1, v0, s1
add_pp r7.xyz, -r6, c20
mad_pp r7.xyz, r1.z, r7, r6
rsq_pp r8.y, r8.y
mul_pp r6.xyz, r8.y, r5
dp3_pp_sat r5.x, r0, r6
mov_pp r5.y, c26.x
add_pp r1.z, -r5.x, c25
texld r9.xz, r5, s6
mul_pp r5.xyz, r0.w, r0
pow_pp r0, r1.z, c26.y
mad_pp r5.xyz, r5, c25.x, -v4
mov_pp r9.y, r0.x
dp3_pp r0.y, r5, r5
rsq_pp r0.x, r0.y
mul_pp r0.xyz, r0.x, r5
dp3_pp r0.x, r0, r6
add_pp r9.w, -r9.y, c25.z
max_pp r1.z, r0.x, c26.x
mul_pp r1.w, r1, c18.x
pow_pp r0, r1.z, r1.w
mov_pp r0.w, r0.x
mul_pp r3.xyz, r3, r0.w
add_pp r5.xy, r9.xzzw, -r9.ywzw
mad_pp r1.zw, r5.xyxy, c24.x, r9.xyyw
mul_pp r5.xyz, r7, r1.w
mul_pp r0.xyz, r6.w, r5
max_pp r0.w, r1.x, c19.x
mul_pp r3.xyz, r3, c21.x
mul_pp r3.xyz, r3, r0.w
mul_pp r5.xyz, r3, r0
mad_pp r5.xyz, r4.w, r5, r4
mov_pp r3.x, r7.w
mov_pp r3.y, r5.w
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r3.wxyw, r0
mul_pp r6.xyz, r3.wxyw, r0.w
mad_pp r0.xyz, -r6, c25.x, r0
max_pp r0.w, r1.y, c15.x
texld r7.xyz, r0, s4
mul_pp r1.y, r1.z, r0.w
pow r0, r7.x, c26.z
mul_pp r0.y, r1, c14.x
mad_pp r5.xyz, r8.z, -r4, r5
pow r4, r7.y, c26.z
mul_pp r6.xyz, r0.y, c16
mov r7.x, r0
pow r0, r7.z, c26.z
dp3_pp_sat r0.w, r3.wxyw, c1
mov r7.y, r4
mul_pp r3.xyz, r6, r0.w
mov r7.z, r0
mul_pp r0.xyz, r7, c23.x
mul_pp r1.xyz, r1.x, r0
mad_pp r0.xyz, r8.z, r0, -r1
mul_pp r4.xyz, r8.x, r3
mad_pp r0.xyz, r0, c22.x, r1
cmp_pp r3.xyz, -r2.w, r3, r4
add_pp r1.xyz, r5, r3
add_pp r0.xyz, r1, r0
mad_pp r1.xyz, r2, v5, r0
max_pp r0.x, r8.w, c17
mad_pp oC0.xyz, r0.x, r2, r1
mov_pp oC0.w, c25.z
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 3
SetTexture 1 [_maskmap2] 2D 4
SetTexture 2 [_basetexture] 2D 1
SetTexture 3 [_normalmap] 2D 2
SetTexture 4 [_envmap] CUBE 5
SetTexture 5 [_ShadowMapTexture] 2D 0
SetTexture 6 [_fresnelwarp] 2D 6
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 140 [_selfillumblendtofull]
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedmmdcgcdamfcldhjjmpeenfhoghgminioabaaaaaafaapaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoianaaaaeaaaaaaahkadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagcbaaaadlcbabaaa
aiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaadgaaaaafccaabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaahaaaaaa
egbcbaaaahaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaa
agaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaidcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaaaaaaaaa
egaabaaaaeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaah
ecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaa
egbcbaaaadaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaa
adaaaaaaegakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaagaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaa
cmaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagiacaaaaaaaaaaaahaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaaaoaaaaahdcaabaaaafaaaaaaegbabaaa
aiaaaaaapgbpbaaaaiaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaafaaaaaa
eghobaaaafaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaafaaaaaadjaaaaaiicaabaaaabaaaaaadkiacaaaabaaaaaa
aaaaaaaaabeaaaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaafaaaaaadcaaaaajicaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajocaabaaaafaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
agaaaaaapgapbaaaacaaaaaajgahbaaaafaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaacaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaeaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaajhcaabaaaaiaaaaaaegacbaaa
ahaaaaaaegacbaaaaeaaaaaakgakbaaaagaaaaaaaaaaaaajhcaabaaaajaaaaaa
egacbaiaebaaaaaaaiaaaaaaegiccaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaa
akaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaaj
hcaabaaaaiaaaaaakgakbaaaakaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaa
diaaaaahhcaabaaaaiaaaaaafgafbaaaaaaaaaaaegacbaaaaiaaaaaadiaaaaah
hcaabaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaaiaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaa
akaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaajgahbaaaafaaaaaafgafbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaadeaaaaai
ccaabaaaaaaaaaaaakaabaaaakaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaaiaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaa
ahaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadcaaaaakocaabaaaaaaaaaaa
agajbaaaabaaaaaapgapbaaaaaaaaaaaagajbaiaebaaaaaaacaaaaaadcaaaaaj
ocaabaaaaaaaaaaakgakbaaaagaaaaaafgaobaaaaaaaaaaaagajbaaaacaaaaaa
deaaaaaibcaabaaaabaaaaaabkaabaaaakaaaaaackiacaaaaaaaaaaaahaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaai
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaadgaaaaag
bcaabaaaacaaaaaabkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaaacaaaaaa
bkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaaacaaaaaabkiacaaaacaaaaaa
ahaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaafaaaaaaegacbaaaabaaaaaadhaaaaajhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaah
hcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaafbcaabaaa
abaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaa
dgaaaaafecaabaaaabaaaaaadkbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaadaaaaaa
pgapbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaafaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaamnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaabaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaa
aaaaaaaaalaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaakaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaagaaaaaa
egacbaiaebaaaaaaacaaaaaadeaaaaaiicaabaaaaaaaaaaadkaabaaaagaaaaaa
dkiacaaaaaaaaaaaaiaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaa
alaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
ahaaaaaaegbcbaaaagaaaaaaegacbaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 4 [_ShadowMapTexture] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_3_0
; 8 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s4
dcl_2d s5
def c1, 2.00000000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
texld r0.w, v0, s0
texldp r0.x, v5, s4
texld r1.xyz, v4, s5
mul_pp r1.xyz, r0.x, r1
mul_pp r1.xyz, r1, c1.x
min_pp r2.xyz, r1, c1.y
texld r1.xyz, v0, s1
max_pp r0.y, r0.w, c0.x
mul_pp r0.yzw, r1.xxyz, r0.y
max_pp r2.xyz, r2, r0.x
mad_pp oC0.xyz, r1, r2, r0.yzww
mov_pp oC0.w, c1.z
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 2
SetTexture 1 [_basetexture] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 256
Float 140 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecednnnafglphebgejcmfaefhfpoakebfihaabaaaaaajiadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaacaaaaeaaaaaaajiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaddaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadeaaaaah
hcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadeaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_selfillumblendtofull]
Float 18 [_specularexponent]
Float 19 [_specularblendtofull]
Vector 20 [_specularcolor]
Float 21 [_specularscale]
Float 22 [_maskenvbymetalness]
Float 23 [_envmapintensity]
Float 24 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
"ps_3_0
; 125 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c25, 2.20000005, 2.00000000, -1.00000000, 1.00000000
def c26, 0.00000000, 5.00000000, 0.50000000, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0, s3
mad_pp r3.xy, r0.wyzw, c25.y, c25.z
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c25.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r4.w, r3, v2
dp3_pp_sat r3.w, r3, v4
dp3_pp r5.w, r3, v3
dp3_pp r2.w, r3, v1
mul_pp r1.w, r4, r4
mov r2.x, r4.w
mov r2.y, r5.w
mov r2.z, c25.w
mul_pp r0, r2.wxyy, r2.xyyw
dp4 r1.z, r2.wxyz, c7
dp4 r1.y, r2.wxyz, c6
dp4 r1.x, r2.wxyz, c5
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
add_pp r1.xyz, r1, r2
mad_pp r1.w, r2, r2, -r1
mul r0.xyz, r1.w, c11
add_pp r0.xyz, r1, r0
mul_pp r1.xyz, r0, c13.x
mov_pp r0.xyz, c12
abs_pp r0.w, -c4
mul_pp r5.xyz, c25.y, r0
mad_pp r7.w, r3, c26.z, c26.z
texld r2.xyz, v0, s2
mul_pp r0.xyz, r7.w, r5
cmp_pp r6.w, -r0, c25, r3
mad_pp r4.xyz, r0, r6.w, r1
pow r1, r2.x, c25.x
mov r2.x, r1
pow r0, r2.y, c25.x
mov r2.y, r0
pow r0, r2.z, c25.x
dp3_pp r1.x, v6, v6
rsq_pp r0.x, r1.x
mul_pp r1.xyz, r0.x, v6
mov r2.z, r0
dp3_pp r0.x, r1, r1
mul_pp r6.xyz, r2, r4
rsq_pp r0.w, r0.x
mul_pp r4.xyz, r0.w, r1
texld r1, v0, s1
dp3_pp_sat r8.x, r3, r4
texld r8.zw, v0, s0
add_pp r0.xyz, r8.z, r6
add_pp r7.xyz, -r0, c20
mad_pp r7.xyz, r1.z, r7, r0
add_pp r1.z, -r8.x, c25.w
pow_pp r0, r1.z, c26.y
mov_pp r8.y, c26.x
texld r9.xz, r8, s5
mov_pp r8.x, r0
mul_pp r3.xyz, r3, r7.w
mad_pp r0.xyz, r3, c25.y, -v4
add_pp r8.y, -r8.x, c25.w
add_pp r3.xy, r9.xzzw, -r8
mad_pp r8.xy, r3, c24.x, r8
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.x, r4, r0
mul_pp r3.xyz, r8.y, r7
mul_pp r4.xyz, r3.w, r3
pow r3, r1.x, c25.x
mov_pp r3.y, r4.w
mov_pp r3.z, r5.w
max_pp r1.z, r0.x, c26.x
mul_pp r1.w, r1, c18.x
pow_pp r0, r1.z, r1.w
mul_pp r0.xyz, r5, r0.x
mov r0.w, r3.x
mov_pp r3.x, r2.w
max_pp r1.x, r0.w, c19
mul_pp r0.xyz, r0, c21.x
mul_pp r0.xyz, r0, r1.x
mul_pp r0.xyz, r0, r4
mad_pp r0.xyz, r6.w, r0, r6
mov r5.x, v1.w
mov r5.z, v3.w
mov r5.y, v2.w
dp3_pp r1.z, r3, r5
mul_pp r7.xyz, r3, r1.z
mad_pp r4.xyz, -r7, c25.y, r5
texld r4.xyz, r4, s4
mul_pp r4.xyz, r4, c23.x
max_pp r1.w, r1.y, c15.x
mul_pp r1.xyz, r0.w, r4
mad_pp r4.xyz, r8.z, r4, -r1
mul_pp r0.w, r1, r8.x
mul_pp r0.w, r0, c14.x
mad_pp r4.xyz, r4, c22.x, r1
mul_pp r1.xyz, r0.w, c16
dp3_pp_sat r0.w, r3, c1
mad_pp r0.xyz, r8.z, -r6, r0
mad_pp r0.xyz, r1, r0.w, r0
add_pp r1.xyz, r0, r4
pow r0, r1.x, c26.w
mov r1.x, r0
pow r0, r1.z, c26.w
pow r3, r1.y, c26.w
mov r1.z, r0
mov r1.y, r3
mad_pp r1.xyz, r2, v5, r1
max_pp r0.x, r8.w, c17
mad_pp oC0.xyz, r0.x, r2, r1
mov_pp oC0.w, c25
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 2
SetTexture 1 [_maskmap2] 2D 3
SetTexture 2 [_basetexture] 2D 0
SetTexture 3 [_normalmap] 2D 1
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 48 [_ambientscale]
Float 52 [_rimlightscale]
Float 56 [_rimlightblendtofull]
Vector 64 [_rimlightcolor] 3
Float 76 [_selfillumblendtofull]
Float 80 [_specularexponent]
Float 84 [_specularblendtofull]
Vector 96 [_specularcolor] 3
Float 108 [_specularscale]
Float 112 [_maskenvbymetalness]
Float 116 [_envmapintensity]
Float 120 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecednhfngallldgkjfnlkfnelclgmcllnlokabaaaaaapeaoaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckeanaaaaeaaaaaaagjadaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaa
ahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaadgaaaaafccaabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaahaaaaaa
egbcbaaaahaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaidcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaakgikcaaaaaaaaaaaahaaaaaaegaabaaaaaaaaaaa
egaabaaaaeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaah
ecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaa
egbcbaaaadaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaa
adaaaaaaegakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaagaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaa
cmaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagiacaaaaaaaaaaaadaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajhcaabaaaafaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaaaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaadjaaaaaiicaabaaaaaaaaaaadkiacaaaabaaaaaaaaaaaaaaabeaaaaa
aaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajhcaabaaaaeaaaaaaegacbaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaaagaaaaaaegacbaaa
agaaaaaadiaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaamnmmamea
mnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaa
efaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaajhcaabaaaaiaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
kgakbaaaahaaaaaaaaaaaaajhcaabaaaajaaaaaaegacbaiaebaaaaaaaiaaaaaa
egiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaakaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaiaaaaaakgakbaaa
akaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaadiaaaaahhcaabaaaaiaaaaaa
fgafbaaaaaaaaaaaegacbaaaaiaaaaaadiaaaaahhcaabaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaaiaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiecaabaaaaaaaaaaadkaabaaaakaaaaaaakiacaaaaaaaaaaa
afaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaafaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaaaaaaaaaagaaaaaacpaaaaafccaabaaaaaaaaaaaakaabaaa
akaaaaaadeaaaaaiecaabaaaaaaaaaaabkaabaaaakaaaaaackiacaaaaaaaaaaa
adaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaa
diaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmameabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaaiccaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaiaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaafaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
egacbaaaafaaaaaadcaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaapgapbaaa
aaaaaaaaagajbaiaebaaaaaaaeaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaa
ahaaaaaafgaobaaaaaaaaaaaagajbaaaaeaaaaaadgaaaaagbcaabaaaabaaaaaa
bkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaaabaaaaaabkiacaaaacaaaaaa
agaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaah
bcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaacaaaaaaagaabaaaabaaaaaafgaobaaaaaaaaaaadgaaaaaf
bcaabaaaabaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaabaaaaaadkbabaaaaeaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaa
adaaaaaapgapbaiaebaaaaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaakgakbaaaahaaaaaaegacbaiaebaaaaaaacaaaaaa
deaaaaaibcaabaaaaaaaaaaadkaabaaaahaaaaaadkiacaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaacpaaaaafocaabaaaaaaaaaaafgaobaaaaaaaaaaadiaaaaakocaabaaa
aaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaacplkoidocplkoidocplkoido
bjaaaaafocaabaaaaaaaaaaafgaobaaaaaaaaaaadcaaaaajocaabaaaaaaaaaaa
agajbaaaagaaaaaaagbjbaaaagaaaaaafgaobaaaaaaaaaaadcaaaaajhccabaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaagaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
"ps_3_0
; 15 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c1, 2.20000005, 0.00000000, 0, 0
dcl_texcoord0 v0.xy
texld r1.xyz, v0, s1
pow r0, r1.x, c1.x
pow r2, r1.y, c1.x
mov r1.x, r0
pow r0, r1.z, c1.x
texld r0.w, v0, s0
mov r1.y, r2
mov r1.z, r0
max_pp r0.x, r0.w, c0
mad_pp oC0.xyz, r0.x, r1, r1
mov_pp oC0.w, c1.y
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
ConstBuffer "$Globals" 192
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpmddcnbjncnaejbabbnjepneinjccoicabaaaaaaieacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeabaaaa
eaaaaaaafjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadeaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_selfillumblendtofull]
Float 18 [_specularexponent]
Float 19 [_specularblendtofull]
Vector 20 [_specularcolor]
Float 21 [_specularscale]
Float 22 [_maskenvbymetalness]
Float 23 [_envmapintensity]
Float 24 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_ShadowMapTexture] 2D 5
SetTexture 6 [_fresnelwarp] 2D 6
"ps_3_0
; 130 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
def c25, 2.20000005, 2.00000000, -1.00000000, 1.00000000
def c26, 0.50000000, 0.00000000, 5.00000000, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
dcl_texcoord7 v7
texld r0.yw, v0, s3
mad_pp r6.xy, r0.wyzw, c25.y, c25.z
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c25.w
rsq_pp r0.x, r0.x
rcp_pp r6.z, r0.x
dp3_pp r5.w, r6, v1
dp3_pp r7.w, r6, v2
dp3_pp r4.w, r6, v3
dp3_pp_sat r9.w, r6, v4
mov r0.x, r5.w
mov r0.y, r7.w
mov r0.z, r4.w
mov r0.w, c25
mul_pp r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c7
dp4 r2.y, r0, c6
dp4 r2.x, r0, c5
mul_pp r0.x, r7.w, r7.w
mad_pp r0.w, r5, r5, -r0.x
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
add_pp r0.xyz, r2, r0
mov_pp r2.xyz, c12
mul_pp r5.xyz, c25.y, r2
mul r1.xyz, r0.w, c11
add_pp r0.xyz, r0, r1
mad_pp r6.w, r9, c26.x, c26.x
mul_pp r4.xyz, r6.w, r5
texld r1.xyz, v0, s2
mul_pp r3.xyz, r0, c13.x
texld r2.zw, v0, s0
pow r0, r1.x, c25.x
texldp r2.x, v7, s5
mul_pp r0.y, r9.w, r2.x
abs_pp r2.y, -c4.w
cmp_pp r8.w, -r2.y, r2.x, r0.y
mad_pp r7.xyz, r4, r8.w, r3
pow r3, r1.y, c25.x
mov r4.x, r0
dp3_pp r0.x, v6, v6
rsq_pp r1.x, r0.x
pow r0, r1.z, c25.x
mul_pp r1.xyz, r1.x, v6
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r8.xyz, r0.x, r1
texld r1, v0, s1
mov r4.y, r3
mov r4.z, r0
dp3_pp_sat r3.x, r6, r8
mul_pp r7.xyz, r4, r7
add_pp r0.xyz, r2.z, r7
add_pp r9.xyz, -r0, c20
mad_pp r9.xyz, r1.z, r9, r0
add_pp r3.y, -r3.x, c25.w
pow_pp r0, r3.y, c26.z
mov_pp r3.y, c26
texld r3.xz, r3, s6
mov_pp r3.y, r0.x
mul_pp r0.xyz, r6.w, r6
add_pp r3.w, -r3.y, c25
add_pp r6.xy, r3.xzzw, -r3.ywzw
mad_pp r6.xw, r6.yyzx, c24.x, r3.wyzy
mul_pp r3.xyz, r9, r6.x
mad_pp r0.xyz, r0, c25.y, -v4
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.x, r0, r8
mul_pp r6.xyz, r9.w, r3
mul_pp r0.y, r1.w, c18.x
max_pp r0.x, r0, c26.y
pow_pp r3, r0.x, r0.y
pow r0, r1.x, c25.x
mov r0.w, r0.x
mov_pp r0.y, r3.x
mul_pp r0.xyz, r5, r0.y
mov_pp r5.x, r7.w
mov_pp r5.y, r4.w
max_pp r1.x, r0.w, c19
mul_pp r0.xyz, r0, c21.x
mul_pp r0.xyz, r0, r1.x
mul_pp r0.xyz, r0, r6
mad_pp r0.xyz, r8.w, r0, r7
mad_pp r3.xyz, r2.z, -r7, r0
max_pp r0.x, r1.y, c15
mul_pp r1.w, r6, r0.x
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3_pp r0.y, r5.wxyw, r1
mul_pp r0.xyz, r5.wxyw, r0.y
mad_pp r0.xyz, -r0, c25.y, r1
mul_pp r1.w, r1, c14.x
mul_pp r1.xyz, r1.w, c16
dp3_pp_sat r1.w, r5.wxyw, c1
mul_pp r1.xyz, r1, r1.w
mul_pp r6.xyz, r2.x, r1
texld r0.xyz, r0, s4
mul_pp r0.xyz, r0, c23.x
mul_pp r5.xyz, r0.w, r0
mad_pp r0.xyz, r2.z, r0, -r5
cmp_pp r1.xyz, -r2.y, r1, r6
mad_pp r2.xyz, r0, c22.x, r5
add_pp r0.xyz, r3, r1
add_pp r2.xyz, r0, r2
pow r0, r2.x, c26.w
pow r1, r2.z, c26.w
mov r2.x, r0
pow r0, r2.y, c26.w
mov r2.z, r1
mov r2.y, r0
mad_pp r1.xyz, r4, v5, r2
max_pp r0.x, r2.w, c17
mad_pp oC0.xyz, r0.x, r4, r1
mov_pp oC0.w, c25
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 3
SetTexture 1 [_maskmap2] 2D 4
SetTexture 2 [_basetexture] 2D 1
SetTexture 3 [_normalmap] 2D 2
SetTexture 4 [_envmap] CUBE 5
SetTexture 5 [_ShadowMapTexture] 2D 0
SetTexture 6 [_fresnelwarp] 2D 6
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 140 [_selfillumblendtofull]
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedgijlbfpoeilbpdiannclaooaedgcjdmhabaaaaaaoeapaaaaadaaaaaa
cmaaaaaacmabaaaagaabaaaaejfdeheopiaaaaaaajaaaaaaaiaaaaaaoaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaomaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaomaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaomaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaomaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaomaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaomaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaomaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaaomaaaaaa
ahaaaaaaaaaaaaaaadaaaaaaaiaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchmaoaaaaeaaaaaaajpadaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagcbaaaadlcbabaaa
aiaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaadgaaaaafccaabaaa
aaaaaaaaabeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaahaaaaaa
egbcbaaaahaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaakgakbaaaaaaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaa
aaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaa
agaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaaeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaidcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaaaaaaaaa
egaabaaaaeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaah
ecaabaaaadaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaa
adaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaa
egbcbaaaadaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaa
adaaaaaaegakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaagaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
ckaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaa
cmaaaaaakgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaa
egacbaaaaeaaaaaaagiacaaaaaaaaaaaahaaaaaabacaaaahecaabaaaaaaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaaaoaaaaahdcaabaaaafaaaaaaegbabaaa
aiaaaaaapgbpbaaaaiaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaafaaaaaa
eghobaaaafaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaafaaaaaadjaaaaaiicaabaaaabaaaaaadkiacaaaabaaaaaa
aaaaaaaaabeaaaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaafaaaaaadcaaaaajicaabaaaacaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajocaabaaaafaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
agaaaaaapgapbaaaacaaaaaajgahbaaaafaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaacaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaeaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaa
diaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaamnmmameamnmmamea
mnmmameaaaaaaaaabjaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaaefaaaaaj
pcaabaaaahaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaaiaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaakgakbaaa
ahaaaaaaaaaaaaajhcaabaaaajaaaaaaegacbaiaebaaaaaaaiaaaaaaegiccaaa
aaaaaaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaiaaaaaakgakbaaaakaaaaaa
egacbaaaajaaaaaaegacbaaaaiaaaaaadiaaaaahhcaabaaaaiaaaaaafgafbaaa
aaaaaaaaegacbaaaaiaaaaaadiaaaaahhcaabaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaaiaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaadkaabaaaakaaaaaaakiacaaaaaaaaaaaajaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaajgahbaaa
afaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaacpaaaaafccaabaaaaaaaaaaaakaabaaaakaaaaaa
deaaaaaiecaabaaaaaaaaaaabkaabaaaakaaaaaackiacaaaaaaaaaaaahaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaai
hcaabaaaacaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaadiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaamnmmameabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaiaaaaaaegacbaaa
abaaaaaadiaaaaahocaabaaaafaaaaaapgapbaaaaaaaaaaaagajbaaaabaaaaaa
dcaaaaajhcaabaaaaeaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaajgahbaaa
afaaaaaadcaaaaakocaabaaaaaaaaaaaagajbaaaabaaaaaapgapbaaaaaaaaaaa
agajbaiaebaaaaaaaeaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaahaaaaaa
fgaobaaaaaaaaaaaagajbaaaaeaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaa
acaaaaaaafaaaaaadgaaaaagccaabaaaabaaaaaabkiacaaaacaaaaaaagaaaaaa
dgaaaaagecaabaaaabaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaahbcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
afaaaaaaegacbaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaacaaaaaa
dgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
dkbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaiaebaaaaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
fgifcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaa
ahaaaaaaegacbaiaebaaaaaaacaaaaaadeaaaaaibcaabaaaaaaaaaaadkaabaaa
ahaaaaaadkiacaaaaaaaaaaaaiaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaa
aaaaaaaaalaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaacpaaaaafocaabaaaaaaaaaaa
fgaobaaaaaaaaaaadiaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaa
aaaaaaaacplkoidocplkoidocplkoidobjaaaaafocaabaaaaaaaaaaafgaobaaa
aaaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaagaaaaaaagbjbaaaagaaaaaa
fgaobaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaa
agaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"ps_3_0
; 20 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
def c1, 2.20000005, 2.00000000, 1.00000000, 0.00000000
dcl_texcoord0 v0.xy
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
texld r2.xyz, v0, s1
pow r4, r2.y, c1.x
texld r0.w, v0, s0
texldp r0.x, v5, s3
texld r1.xyz, v4, s4
mul_pp r1.xyz, r0.x, r1
mul_pp r1.xyz, r1, c1.y
min_pp r3.xyz, r1, c1.z
pow r1, r2.x, c1.x
mov r2.x, r1
pow r1, r2.z, c1.x
mov r2.z, r1
mov r2.y, r4
max_pp r0.y, r0.w, c0.x
mul_pp r1.xyz, r2, r0.y
max_pp r0.xyz, r3, r0.x
mad_pp oC0.xyz, r2, r0, r1
mov_pp oC0.w, c1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 2
SetTexture 1 [_basetexture] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 256
Float 140 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmjeigogipohjdmeconnneklcigmimabfabaaaaaaoiadaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaacaaaaeaaaaaaakmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaddaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadeaaaaah
hcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadeaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
cpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaamnmmameamnmmameamnmmameaaaaaaaaabjaaaaaf
hcaabaaaabaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Geometry" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_9;
  tmpvar_9 = pow (textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8)))).xyz, vec3(2.2, 2.2, 2.2));
  float atten_10;
  atten_10 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))).w;
  vec3 environment_11;
  vec3 rimlight_12;
  vec3 sphericalharmonics_13;
  vec3 fresnel_14;
  float attenuation_15;
  vec4 color_16;
  color_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(normalize(xlv_TEXCOORD4));
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_19;
  tmpvar_19 = clamp (dot (normal_6, tmpvar_17), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (_LightColor0.xyz * 2.0);
  attenuation_15 = atten_10;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_15 = (atten_10 * tmpvar_19);
  };
  float tmpvar_21;
  tmpvar_21 = ((tmpvar_19 * 0.5) + 0.5);
  float tmpvar_22;
  tmpvar_22 = pow ((1.0 - clamp (dot (normal_6, tmpvar_18), 0.0, 1.0)), 5.0);
  fresnel_14.xy = vec2(tmpvar_22);
  fresnel_14.z = (1.0 - tmpvar_22);
  vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_24;
  tmpvar_24 = mix (fresnel_14, texture2D (_fresnelwarp, tmpvar_23).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_14 = tmpvar_24;
  vec3 tmpvar_25;
  tmpvar_25 = ((vec3(tmpvar_21) * tmpvar_20) * attenuation_15);
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_7;
  vec3 x2_27;
  vec3 x1_28;
  x1_28.x = dot (unity_SHAr, tmpvar_26);
  x1_28.y = dot (unity_SHAg, tmpvar_26);
  x1_28.z = dot (unity_SHAb, tmpvar_26);
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_27.x = dot (unity_SHBr, tmpvar_29);
  x2_27.y = dot (unity_SHBg, tmpvar_29);
  x2_27.z = dot (unity_SHBb, tmpvar_29);
  sphericalharmonics_13 = ((x1_28 + x2_27) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_13 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * (tmpvar_25 + (sphericalharmonics_13 * _ambientscale)));
  vec3 tmpvar_31;
  tmpvar_31 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_21) - tmpvar_17)), tmpvar_18)), (tmpvar_4.w * _specularexponent))) * tmpvar_20) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_30 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_24.z) * tmpvar_19)) * attenuation_15);
  color_16.xyz = (tmpvar_30 + tmpvar_31);
  color_16.xyz = mix (color_16.xyz, tmpvar_31, tmpvar_3.zzz);
  vec4 v_32;
  v_32.x = unity_MatrixV[0].y;
  v_32.y = unity_MatrixV[1].y;
  v_32.z = unity_MatrixV[2].y;
  v_32.w = unity_MatrixV[3].y;
  vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_7;
  vec3 tmpvar_34;
  tmpvar_34 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_24.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_32, tmpvar_33), 0.0, 1.0));
  rimlight_12 = tmpvar_34;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = (tmpvar_34 * atten_10);
  };
  color_16.xyz = (color_16.xyz + rimlight_12);
  vec3 tmpvar_35;
  tmpvar_35 = mix (((tmpvar_9 * _envmapintensity) * tmpvar_4.x), ((tmpvar_9 * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_11 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_11 = (tmpvar_35 * attenuation_15);
  };
  color_16.xyz = (color_16.xyz + environment_11);
  color_16.w = 1.0;
  c_1.xyz = color_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 51 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c20.x
mov r1.xyz, c16
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r4.x, c17, r1
mul r2.xyz, v1.w, r2
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mad r0.xyz, r4, c18.w, -v0
dp3 o5.y, r2, r0
dp3 o5.z, v2, r0
dp3 o5.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.y, r2, c4
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o2, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o3, r1, c18.w
dp3 r1.y, r2, c6
dp3 r1.w, -r3, c6
dp3 r1.x, v1, c6
dp3 r1.z, v2, c6
dp3 o6.y, r2, r3
mul o4, r1, c18.w
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.z, r0, c14
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedfkcgeiepfiahgailadcibjjkljlpghbhabaaaaaadmakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fiaiaaaaeaaaabaabgacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_9;
  tmpvar_9 = pow (textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8)))).xyz, vec3(2.2, 2.2, 2.2));
  vec3 environment_10;
  vec3 rimlight_11;
  vec3 sphericalharmonics_12;
  vec3 fresnel_13;
  float attenuation_14;
  vec4 color_15;
  color_15 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_17;
  tmpvar_17 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_18;
  tmpvar_18 = (_LightColor0.xyz * 2.0);
  attenuation_14 = 1.0;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_14 = tmpvar_17;
  };
  float tmpvar_19;
  tmpvar_19 = ((tmpvar_17 * 0.5) + 0.5);
  float tmpvar_20;
  tmpvar_20 = pow ((1.0 - clamp (dot (normal_6, tmpvar_16), 0.0, 1.0)), 5.0);
  fresnel_13.xy = vec2(tmpvar_20);
  fresnel_13.z = (1.0 - tmpvar_20);
  vec2 tmpvar_21;
  tmpvar_21.y = 0.0;
  tmpvar_21.x = clamp (dot (normal_6, tmpvar_16), 0.0, 1.0);
  vec3 tmpvar_22;
  tmpvar_22 = mix (fresnel_13, texture2D (_fresnelwarp, tmpvar_21).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_13 = tmpvar_22;
  vec3 tmpvar_23;
  tmpvar_23 = ((vec3(tmpvar_19) * tmpvar_18) * attenuation_14);
  vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_7;
  vec3 x2_25;
  vec3 x1_26;
  x1_26.x = dot (unity_SHAr, tmpvar_24);
  x1_26.y = dot (unity_SHAg, tmpvar_24);
  x1_26.z = dot (unity_SHAb, tmpvar_24);
  vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_25.x = dot (unity_SHBr, tmpvar_27);
  x2_25.y = dot (unity_SHBg, tmpvar_27);
  x2_25.z = dot (unity_SHBb, tmpvar_27);
  sphericalharmonics_12 = ((x1_26 + x2_25) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_12 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_5.xyz * (tmpvar_23 + (sphericalharmonics_12 * _ambientscale)));
  vec3 tmpvar_29;
  tmpvar_29 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_19) - xlv_TEXCOORD4)), tmpvar_16)), (tmpvar_4.w * _specularexponent))) * tmpvar_18) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_28 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_22.z) * tmpvar_17)) * attenuation_14);
  color_15.xyz = (tmpvar_28 + tmpvar_29);
  color_15.xyz = mix (color_15.xyz, tmpvar_29, tmpvar_3.zzz);
  vec4 v_30;
  v_30.x = unity_MatrixV[0].y;
  v_30.y = unity_MatrixV[1].y;
  v_30.z = unity_MatrixV[2].y;
  v_30.w = unity_MatrixV[3].y;
  vec4 tmpvar_31;
  tmpvar_31.w = 0.0;
  tmpvar_31.xyz = tmpvar_7;
  vec3 tmpvar_32;
  tmpvar_32 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_22.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_30, tmpvar_31), 0.0, 1.0));
  rimlight_11 = tmpvar_32;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_11 = tmpvar_32;
  };
  color_15.xyz = (color_15.xyz + rimlight_11);
  vec3 tmpvar_33;
  tmpvar_33 = mix (((tmpvar_9 * _envmapintensity) * tmpvar_4.x), ((tmpvar_9 * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_10 = tmpvar_33;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_10 = (tmpvar_33 * attenuation_14);
  };
  color_15.xyz = (color_15.xyz + environment_10);
  color_15.w = 1.0;
  c_1.xyz = color_15.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_basetexture_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c16.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c14.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o5.y, r2, r4
dp3 o6.y, r2, r3
mul o4, r0, c14.w
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
mad o1.xy, v3, c15, c15.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefieceddmenilehncabcfnmdbapmeihlmiglkncabaaaaaalmaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaagaaaaeaaaabaalmabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
aaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaia
ebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaa
aaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaa
aeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaa
adaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaai
pccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaf
icaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaagaaaaaaegacbaaaadaaaaaa
egacbaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaagaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaah
eccabaaaagaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_9;
  tmpvar_9 = pow (textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8)))).xyz, vec3(2.2, 2.2, 2.2));
  float atten_10;
  atten_10 = ((float((xlv_TEXCOORD6.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz))).w);
  vec3 environment_11;
  vec3 rimlight_12;
  vec3 sphericalharmonics_13;
  vec3 fresnel_14;
  float attenuation_15;
  vec4 color_16;
  color_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(normalize(xlv_TEXCOORD4));
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_19;
  tmpvar_19 = clamp (dot (normal_6, tmpvar_17), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (_LightColor0.xyz * 2.0);
  attenuation_15 = atten_10;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_15 = (atten_10 * tmpvar_19);
  };
  float tmpvar_21;
  tmpvar_21 = ((tmpvar_19 * 0.5) + 0.5);
  float tmpvar_22;
  tmpvar_22 = pow ((1.0 - clamp (dot (normal_6, tmpvar_18), 0.0, 1.0)), 5.0);
  fresnel_14.xy = vec2(tmpvar_22);
  fresnel_14.z = (1.0 - tmpvar_22);
  vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_24;
  tmpvar_24 = mix (fresnel_14, texture2D (_fresnelwarp, tmpvar_23).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_14 = tmpvar_24;
  vec3 tmpvar_25;
  tmpvar_25 = ((vec3(tmpvar_21) * tmpvar_20) * attenuation_15);
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_7;
  vec3 x2_27;
  vec3 x1_28;
  x1_28.x = dot (unity_SHAr, tmpvar_26);
  x1_28.y = dot (unity_SHAg, tmpvar_26);
  x1_28.z = dot (unity_SHAb, tmpvar_26);
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_27.x = dot (unity_SHBr, tmpvar_29);
  x2_27.y = dot (unity_SHBg, tmpvar_29);
  x2_27.z = dot (unity_SHBb, tmpvar_29);
  sphericalharmonics_13 = ((x1_28 + x2_27) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_13 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * (tmpvar_25 + (sphericalharmonics_13 * _ambientscale)));
  vec3 tmpvar_31;
  tmpvar_31 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_21) - tmpvar_17)), tmpvar_18)), (tmpvar_4.w * _specularexponent))) * tmpvar_20) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_30 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_24.z) * tmpvar_19)) * attenuation_15);
  color_16.xyz = (tmpvar_30 + tmpvar_31);
  color_16.xyz = mix (color_16.xyz, tmpvar_31, tmpvar_3.zzz);
  vec4 v_32;
  v_32.x = unity_MatrixV[0].y;
  v_32.y = unity_MatrixV[1].y;
  v_32.z = unity_MatrixV[2].y;
  v_32.w = unity_MatrixV[3].y;
  vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_7;
  vec3 tmpvar_34;
  tmpvar_34 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_24.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_32, tmpvar_33), 0.0, 1.0));
  rimlight_12 = tmpvar_34;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = (tmpvar_34 * atten_10);
  };
  color_16.xyz = (color_16.xyz + rimlight_12);
  vec3 tmpvar_35;
  tmpvar_35 = mix (((tmpvar_9 * _envmapintensity) * tmpvar_4.x), ((tmpvar_9 * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_11 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_11 = (tmpvar_35 * attenuation_15);
  };
  color_16.xyz = (color_16.xyz + environment_11);
  color_16.w = 1.0;
  c_1.xyz = color_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c20.x
mov r1.xyz, c16
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r4.x, c17, r1
mul r2.xyz, v1.w, r2
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 o5.y, r2, r0
dp3 o5.z, v2, r0
dp3 o5.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.y, r2, c4
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o2, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o3, r1, c18.w
dp3 r1.y, r2, c6
dp3 r1.w, -r3, c6
dp3 r1.x, v1, c6
dp3 r1.z, v2, c6
dp3 o6.y, r2, r3
mul o4, r1, c18.w
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.w, r0, c15
dp4 o7.z, r0, c14
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedakafhigefnpjifdgjlllggjfdpapdihgabaaaaaadmakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fiaiaaaaeaaaabaabgacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_9;
  tmpvar_9 = pow (textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8)))).xyz, vec3(2.2, 2.2, 2.2));
  float atten_10;
  atten_10 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))).w * textureCube (_LightTexture0, xlv_TEXCOORD6).w);
  vec3 environment_11;
  vec3 rimlight_12;
  vec3 sphericalharmonics_13;
  vec3 fresnel_14;
  float attenuation_15;
  vec4 color_16;
  color_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(normalize(xlv_TEXCOORD4));
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_19;
  tmpvar_19 = clamp (dot (normal_6, tmpvar_17), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (_LightColor0.xyz * 2.0);
  attenuation_15 = atten_10;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_15 = (atten_10 * tmpvar_19);
  };
  float tmpvar_21;
  tmpvar_21 = ((tmpvar_19 * 0.5) + 0.5);
  float tmpvar_22;
  tmpvar_22 = pow ((1.0 - clamp (dot (normal_6, tmpvar_18), 0.0, 1.0)), 5.0);
  fresnel_14.xy = vec2(tmpvar_22);
  fresnel_14.z = (1.0 - tmpvar_22);
  vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_24;
  tmpvar_24 = mix (fresnel_14, texture2D (_fresnelwarp, tmpvar_23).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_14 = tmpvar_24;
  vec3 tmpvar_25;
  tmpvar_25 = ((vec3(tmpvar_21) * tmpvar_20) * attenuation_15);
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_7;
  vec3 x2_27;
  vec3 x1_28;
  x1_28.x = dot (unity_SHAr, tmpvar_26);
  x1_28.y = dot (unity_SHAg, tmpvar_26);
  x1_28.z = dot (unity_SHAb, tmpvar_26);
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_27.x = dot (unity_SHBr, tmpvar_29);
  x2_27.y = dot (unity_SHBg, tmpvar_29);
  x2_27.z = dot (unity_SHBb, tmpvar_29);
  sphericalharmonics_13 = ((x1_28 + x2_27) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_13 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * (tmpvar_25 + (sphericalharmonics_13 * _ambientscale)));
  vec3 tmpvar_31;
  tmpvar_31 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_21) - tmpvar_17)), tmpvar_18)), (tmpvar_4.w * _specularexponent))) * tmpvar_20) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_30 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_24.z) * tmpvar_19)) * attenuation_15);
  color_16.xyz = (tmpvar_30 + tmpvar_31);
  color_16.xyz = mix (color_16.xyz, tmpvar_31, tmpvar_3.zzz);
  vec4 v_32;
  v_32.x = unity_MatrixV[0].y;
  v_32.y = unity_MatrixV[1].y;
  v_32.z = unity_MatrixV[2].y;
  v_32.w = unity_MatrixV[3].y;
  vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_7;
  vec3 tmpvar_34;
  tmpvar_34 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_24.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_32, tmpvar_33), 0.0, 1.0));
  rimlight_12 = tmpvar_34;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = (tmpvar_34 * atten_10);
  };
  color_16.xyz = (color_16.xyz + rimlight_12);
  vec3 tmpvar_35;
  tmpvar_35 = mix (((tmpvar_9 * _envmapintensity) * tmpvar_4.x), ((tmpvar_9 * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_11 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_11 = (tmpvar_35 * attenuation_15);
  };
  color_16.xyz = (color_16.xyz + environment_11);
  color_16.w = 1.0;
  c_1.xyz = color_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 51 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c20.x
mov r1.xyz, c16
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r4.x, c17, r1
mul r2.xyz, v1.w, r2
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mad r0.xyz, r4, c18.w, -v0
dp3 o5.y, r2, r0
dp3 o5.z, v2, r0
dp3 o5.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.y, r2, c4
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o2, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o3, r1, c18.w
dp3 r1.y, r2, c6
dp3 r1.w, -r3, c6
dp3 r1.x, v1, c6
dp3 r1.z, v2, c6
dp3 o6.y, r2, r3
mul o4, r1, c18.w
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.z, r0, c14
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedfkcgeiepfiahgailadcibjjkljlpghbhabaaaaaadmakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fiaiaaaaeaaaabaabgacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  tmpvar_5 = texture2D (_basetexture, xlv_TEXCOORD0);
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_9;
  tmpvar_9 = pow (textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8)))).xyz, vec3(2.2, 2.2, 2.2));
  float atten_10;
  atten_10 = texture2D (_LightTexture0, xlv_TEXCOORD6).w;
  vec3 environment_11;
  vec3 rimlight_12;
  vec3 sphericalharmonics_13;
  vec3 fresnel_14;
  float attenuation_15;
  vec4 color_16;
  color_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_18;
  tmpvar_18 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_19;
  tmpvar_19 = (_LightColor0.xyz * 2.0);
  attenuation_15 = atten_10;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_15 = (atten_10 * tmpvar_18);
  };
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_18 * 0.5) + 0.5);
  float tmpvar_21;
  tmpvar_21 = pow ((1.0 - clamp (dot (normal_6, tmpvar_17), 0.0, 1.0)), 5.0);
  fresnel_14.xy = vec2(tmpvar_21);
  fresnel_14.z = (1.0 - tmpvar_21);
  vec2 tmpvar_22;
  tmpvar_22.y = 0.0;
  tmpvar_22.x = clamp (dot (normal_6, tmpvar_17), 0.0, 1.0);
  vec3 tmpvar_23;
  tmpvar_23 = mix (fresnel_14, texture2D (_fresnelwarp, tmpvar_22).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_14 = tmpvar_23;
  vec3 tmpvar_24;
  tmpvar_24 = ((vec3(tmpvar_20) * tmpvar_19) * attenuation_15);
  vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_7;
  vec3 x2_26;
  vec3 x1_27;
  x1_27.x = dot (unity_SHAr, tmpvar_25);
  x1_27.y = dot (unity_SHAg, tmpvar_25);
  x1_27.z = dot (unity_SHAb, tmpvar_25);
  vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_26.x = dot (unity_SHBr, tmpvar_28);
  x2_26.y = dot (unity_SHBg, tmpvar_28);
  x2_26.z = dot (unity_SHBb, tmpvar_28);
  sphericalharmonics_13 = ((x1_27 + x2_26) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_13 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_5.xyz * (tmpvar_24 + (sphericalharmonics_13 * _ambientscale)));
  vec3 tmpvar_30;
  tmpvar_30 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_20) - xlv_TEXCOORD4)), tmpvar_17)), (tmpvar_4.w * _specularexponent))) * tmpvar_19) * _specularscale) * max (tmpvar_4.x, _specularblendtofull)) * ((mix ((tmpvar_29 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_23.z) * tmpvar_18)) * attenuation_15);
  color_16.xyz = (tmpvar_29 + tmpvar_30);
  color_16.xyz = mix (color_16.xyz, tmpvar_30, tmpvar_3.zzz);
  vec4 v_31;
  v_31.x = unity_MatrixV[0].y;
  v_31.y = unity_MatrixV[1].y;
  v_31.z = unity_MatrixV[2].y;
  v_31.w = unity_MatrixV[3].y;
  vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = tmpvar_7;
  vec3 tmpvar_33;
  tmpvar_33 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_23.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_31, tmpvar_32), 0.0, 1.0));
  rimlight_12 = tmpvar_33;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = (tmpvar_33 * atten_10);
  };
  color_16.xyz = (color_16.xyz + rimlight_12);
  vec3 tmpvar_34;
  tmpvar_34 = mix (((tmpvar_9 * _envmapintensity) * tmpvar_4.x), ((tmpvar_9 * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_11 = tmpvar_34;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_11 = (tmpvar_34 * attenuation_15);
  };
  color_16.xyz = (color_16.xyz + environment_11);
  color_16.w = 1.0;
  c_1.xyz = color_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 49 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c20.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c18.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c18.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c18.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r4
dp3 o6.y, r2, r3
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedbhhicgcflkoabanpbnkmfifepcnbfnbjabaaaaaabaakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
cmaiaaaaeaaaabaaalacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaagaebaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaadiaaaaaj
hcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agaabaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaallcaabaaaabaaaaaa
egiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaa
dgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
akiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaaakiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaaacaaaaaabkaabaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
bkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaagbcaabaaaacaaaaaackiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaa
acaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaackiacaaa
adaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
pccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaah
bccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
afaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaa
egbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaa
acaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec4 tmpvar_10;
  tmpvar_10 = tmpvar_4;
  float atten_11;
  atten_11 = texture2D (_LightTexture0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))).w;
  vec3 environment_12;
  vec3 rimlight_13;
  vec3 sphericalharmonics_14;
  vec3 fresnel_15;
  float attenuation_16;
  vec4 color_17;
  color_17 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD4));
  vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_20;
  tmpvar_20 = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_21;
  tmpvar_21 = (_LightColor0.xyz * 2.0);
  attenuation_16 = atten_11;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_16 = (atten_11 * tmpvar_20);
  };
  float tmpvar_22;
  tmpvar_22 = ((tmpvar_20 * 0.5) + 0.5);
  float tmpvar_23;
  tmpvar_23 = pow ((1.0 - clamp (dot (normal_6, tmpvar_19), 0.0, 1.0)), 5.0);
  fresnel_15.xy = vec2(tmpvar_23);
  fresnel_15.z = (1.0 - tmpvar_23);
  vec2 tmpvar_24;
  tmpvar_24.y = 0.0;
  tmpvar_24.x = clamp (dot (normal_6, tmpvar_19), 0.0, 1.0);
  vec3 tmpvar_25;
  tmpvar_25 = mix (fresnel_15, texture2D (_fresnelwarp, tmpvar_24).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_15 = tmpvar_25;
  vec3 tmpvar_26;
  tmpvar_26 = ((vec3(tmpvar_22) * tmpvar_21) * attenuation_16);
  vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_7;
  vec3 x2_28;
  vec3 x1_29;
  x1_29.x = dot (unity_SHAr, tmpvar_27);
  x1_29.y = dot (unity_SHAg, tmpvar_27);
  x1_29.z = dot (unity_SHAb, tmpvar_27);
  vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_28.x = dot (unity_SHBr, tmpvar_30);
  x2_28.y = dot (unity_SHBg, tmpvar_30);
  x2_28.z = dot (unity_SHBb, tmpvar_30);
  sphericalharmonics_14 = ((x1_29 + x2_28) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_14 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_5 * (tmpvar_26 + (sphericalharmonics_14 * _ambientscale)));
  tmpvar_10.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_32;
  tmpvar_32 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_22) - tmpvar_18)), tmpvar_19)), (tmpvar_4.w * _specularexponent))) * tmpvar_21) * _specularscale) * max (tmpvar_10.x, _specularblendtofull)) * ((mix ((tmpvar_31 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_25.z) * tmpvar_20)) * attenuation_16);
  color_17.xyz = (tmpvar_31 + tmpvar_32);
  color_17.xyz = mix (color_17.xyz, tmpvar_32, tmpvar_3.zzz);
  vec4 v_33;
  v_33.x = unity_MatrixV[0].y;
  v_33.y = unity_MatrixV[1].y;
  v_33.z = unity_MatrixV[2].y;
  v_33.w = unity_MatrixV[3].y;
  vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = tmpvar_7;
  vec3 tmpvar_35;
  tmpvar_35 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_25.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_33, tmpvar_34), 0.0, 1.0));
  rimlight_13 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_13 = (tmpvar_35 * atten_11);
  };
  color_17.xyz = (color_17.xyz + rimlight_13);
  vec3 tmpvar_36;
  tmpvar_36 = mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_10.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_12 = tmpvar_36;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_12 = (tmpvar_36 * attenuation_16);
  };
  color_17.xyz = (color_17.xyz + environment_12);
  color_17.w = 1.0;
  color_17.xyz = pow (color_17.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.xyz = color_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 51 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c20.x
mov r1.xyz, c16
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r4.x, c17, r1
mul r2.xyz, v1.w, r2
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mad r0.xyz, r4, c18.w, -v0
dp3 o5.y, r2, r0
dp3 o5.z, v2, r0
dp3 o5.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.y, r2, c4
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o2, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o3, r1, c18.w
dp3 r1.y, r2, c6
dp3 r1.w, -r3, c6
dp3 r1.x, v1, c6
dp3 r1.z, v2, c6
dp3 o6.y, r2, r3
mul o4, r1, c18.w
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.z, r0, c14
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedfkcgeiepfiahgailadcibjjkljlpghbhabaaaaaadmakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fiaiaaaaeaaaabaabgacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec4 tmpvar_10;
  tmpvar_10 = tmpvar_4;
  vec3 environment_11;
  vec3 rimlight_12;
  vec3 sphericalharmonics_13;
  vec3 fresnel_14;
  float attenuation_15;
  vec4 color_16;
  color_16 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_18;
  tmpvar_18 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_19;
  tmpvar_19 = (_LightColor0.xyz * 2.0);
  attenuation_15 = 1.0;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_15 = tmpvar_18;
  };
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_18 * 0.5) + 0.5);
  float tmpvar_21;
  tmpvar_21 = pow ((1.0 - clamp (dot (normal_6, tmpvar_17), 0.0, 1.0)), 5.0);
  fresnel_14.xy = vec2(tmpvar_21);
  fresnel_14.z = (1.0 - tmpvar_21);
  vec2 tmpvar_22;
  tmpvar_22.y = 0.0;
  tmpvar_22.x = clamp (dot (normal_6, tmpvar_17), 0.0, 1.0);
  vec3 tmpvar_23;
  tmpvar_23 = mix (fresnel_14, texture2D (_fresnelwarp, tmpvar_22).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_14 = tmpvar_23;
  vec3 tmpvar_24;
  tmpvar_24 = ((vec3(tmpvar_20) * tmpvar_19) * attenuation_15);
  vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = tmpvar_7;
  vec3 x2_26;
  vec3 x1_27;
  x1_27.x = dot (unity_SHAr, tmpvar_25);
  x1_27.y = dot (unity_SHAg, tmpvar_25);
  x1_27.z = dot (unity_SHAb, tmpvar_25);
  vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_26.x = dot (unity_SHBr, tmpvar_28);
  x2_26.y = dot (unity_SHBg, tmpvar_28);
  x2_26.z = dot (unity_SHBb, tmpvar_28);
  sphericalharmonics_13 = ((x1_27 + x2_26) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_13 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_5 * (tmpvar_24 + (sphericalharmonics_13 * _ambientscale)));
  tmpvar_10.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_30;
  tmpvar_30 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_20) - xlv_TEXCOORD4)), tmpvar_17)), (tmpvar_4.w * _specularexponent))) * tmpvar_19) * _specularscale) * max (tmpvar_10.x, _specularblendtofull)) * ((mix ((tmpvar_29 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_23.z) * tmpvar_18)) * attenuation_15);
  color_16.xyz = (tmpvar_29 + tmpvar_30);
  color_16.xyz = mix (color_16.xyz, tmpvar_30, tmpvar_3.zzz);
  vec4 v_31;
  v_31.x = unity_MatrixV[0].y;
  v_31.y = unity_MatrixV[1].y;
  v_31.z = unity_MatrixV[2].y;
  v_31.w = unity_MatrixV[3].y;
  vec4 tmpvar_32;
  tmpvar_32.w = 0.0;
  tmpvar_32.xyz = tmpvar_7;
  vec3 tmpvar_33;
  tmpvar_33 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_23.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_31, tmpvar_32), 0.0, 1.0));
  rimlight_12 = tmpvar_33;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_12 = tmpvar_33;
  };
  color_16.xyz = (color_16.xyz + rimlight_12);
  vec3 tmpvar_34;
  tmpvar_34 = mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_10.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_11 = tmpvar_34;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_11 = (tmpvar_34 * attenuation_15);
  };
  color_16.xyz = (color_16.xyz + environment_11);
  color_16.w = 1.0;
  color_16.xyz = pow (color_16.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.xyz = color_16.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_basetexture_ST]
"vs_3_0
; 43 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c16.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
dp4 r4.y, c13, r0
mov r1, c8
dp4 r4.x, c13, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c14.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c14.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
dp3 o5.y, r2, r4
dp3 o6.y, r2, r3
mul o4, r0, c14.w
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
mad o1.xy, v3, c15, c15.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefieceddmenilehncabcfnmdbapmeihlmiglkncabaaaaaalmaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpaagaaaaeaaaabaalmabaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaa
aaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
aaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaia
ebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaa
aaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaa
aeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaa
adaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaai
pccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaf
icaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaa
egbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaaadaaaaaa
amaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaag
ecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaagaaaaaaegacbaaaadaaaaaa
egacbaaaaaaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaagaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaah
eccabaaaagaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex));
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec4 tmpvar_10;
  tmpvar_10 = tmpvar_4;
  float atten_11;
  atten_11 = ((float((xlv_TEXCOORD6.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD6.xy / xlv_TEXCOORD6.w) + 0.5)).w) * texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6.xyz, xlv_TEXCOORD6.xyz))).w);
  vec3 environment_12;
  vec3 rimlight_13;
  vec3 sphericalharmonics_14;
  vec3 fresnel_15;
  float attenuation_16;
  vec4 color_17;
  color_17 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD4));
  vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_20;
  tmpvar_20 = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_21;
  tmpvar_21 = (_LightColor0.xyz * 2.0);
  attenuation_16 = atten_11;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_16 = (atten_11 * tmpvar_20);
  };
  float tmpvar_22;
  tmpvar_22 = ((tmpvar_20 * 0.5) + 0.5);
  float tmpvar_23;
  tmpvar_23 = pow ((1.0 - clamp (dot (normal_6, tmpvar_19), 0.0, 1.0)), 5.0);
  fresnel_15.xy = vec2(tmpvar_23);
  fresnel_15.z = (1.0 - tmpvar_23);
  vec2 tmpvar_24;
  tmpvar_24.y = 0.0;
  tmpvar_24.x = clamp (dot (normal_6, tmpvar_19), 0.0, 1.0);
  vec3 tmpvar_25;
  tmpvar_25 = mix (fresnel_15, texture2D (_fresnelwarp, tmpvar_24).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_15 = tmpvar_25;
  vec3 tmpvar_26;
  tmpvar_26 = ((vec3(tmpvar_22) * tmpvar_21) * attenuation_16);
  vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_7;
  vec3 x2_28;
  vec3 x1_29;
  x1_29.x = dot (unity_SHAr, tmpvar_27);
  x1_29.y = dot (unity_SHAg, tmpvar_27);
  x1_29.z = dot (unity_SHAb, tmpvar_27);
  vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_28.x = dot (unity_SHBr, tmpvar_30);
  x2_28.y = dot (unity_SHBg, tmpvar_30);
  x2_28.z = dot (unity_SHBb, tmpvar_30);
  sphericalharmonics_14 = ((x1_29 + x2_28) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_14 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_5 * (tmpvar_26 + (sphericalharmonics_14 * _ambientscale)));
  tmpvar_10.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_32;
  tmpvar_32 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_22) - tmpvar_18)), tmpvar_19)), (tmpvar_4.w * _specularexponent))) * tmpvar_21) * _specularscale) * max (tmpvar_10.x, _specularblendtofull)) * ((mix ((tmpvar_31 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_25.z) * tmpvar_20)) * attenuation_16);
  color_17.xyz = (tmpvar_31 + tmpvar_32);
  color_17.xyz = mix (color_17.xyz, tmpvar_32, tmpvar_3.zzz);
  vec4 v_33;
  v_33.x = unity_MatrixV[0].y;
  v_33.y = unity_MatrixV[1].y;
  v_33.z = unity_MatrixV[2].y;
  v_33.w = unity_MatrixV[3].y;
  vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = tmpvar_7;
  vec3 tmpvar_35;
  tmpvar_35 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_25.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_33, tmpvar_34), 0.0, 1.0));
  rimlight_13 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_13 = (tmpvar_35 * atten_11);
  };
  color_17.xyz = (color_17.xyz + rimlight_13);
  vec3 tmpvar_36;
  tmpvar_36 = mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_10.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_12 = tmpvar_36;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_12 = (tmpvar_36 * attenuation_16);
  };
  color_17.xyz = (color_17.xyz + environment_12);
  color_17.w = 1.0;
  color_17.xyz = pow (color_17.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.xyz = color_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c20.x
mov r1.xyz, c16
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r4.x, c17, r1
mul r2.xyz, v1.w, r2
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 o5.y, r2, r0
dp3 o5.z, v2, r0
dp3 o5.x, v1, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.y, r2, c4
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o2, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o3, r1, c18.w
dp3 r1.y, r2, c6
dp3 r1.w, -r3, c6
dp3 r1.x, v1, c6
dp3 r1.z, v2, c6
dp3 o6.y, r2, r3
mul o4, r1, c18.w
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.w, r0, c15
dp4 o7.z, r0, c14
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedakafhigefnpjifdgjlllggjfdpapdihgabaaaaaadmakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fiaiaaaaeaaaabaabgacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaahaaaaaaegiocaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (((_World2Object * _WorldSpaceLightPos0).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xyz;
}


#endif
#ifdef FRAGMENT
varying vec3 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec4 tmpvar_10;
  tmpvar_10 = tmpvar_4;
  float atten_11;
  atten_11 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD6, xlv_TEXCOORD6))).w * textureCube (_LightTexture0, xlv_TEXCOORD6).w);
  vec3 environment_12;
  vec3 rimlight_13;
  vec3 sphericalharmonics_14;
  vec3 fresnel_15;
  float attenuation_16;
  vec4 color_17;
  color_17 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD4));
  vec3 tmpvar_19;
  tmpvar_19 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_20;
  tmpvar_20 = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_21;
  tmpvar_21 = (_LightColor0.xyz * 2.0);
  attenuation_16 = atten_11;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_16 = (atten_11 * tmpvar_20);
  };
  float tmpvar_22;
  tmpvar_22 = ((tmpvar_20 * 0.5) + 0.5);
  float tmpvar_23;
  tmpvar_23 = pow ((1.0 - clamp (dot (normal_6, tmpvar_19), 0.0, 1.0)), 5.0);
  fresnel_15.xy = vec2(tmpvar_23);
  fresnel_15.z = (1.0 - tmpvar_23);
  vec2 tmpvar_24;
  tmpvar_24.y = 0.0;
  tmpvar_24.x = clamp (dot (normal_6, tmpvar_19), 0.0, 1.0);
  vec3 tmpvar_25;
  tmpvar_25 = mix (fresnel_15, texture2D (_fresnelwarp, tmpvar_24).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_15 = tmpvar_25;
  vec3 tmpvar_26;
  tmpvar_26 = ((vec3(tmpvar_22) * tmpvar_21) * attenuation_16);
  vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_7;
  vec3 x2_28;
  vec3 x1_29;
  x1_29.x = dot (unity_SHAr, tmpvar_27);
  x1_29.y = dot (unity_SHAg, tmpvar_27);
  x1_29.z = dot (unity_SHAb, tmpvar_27);
  vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_28.x = dot (unity_SHBr, tmpvar_30);
  x2_28.y = dot (unity_SHBg, tmpvar_30);
  x2_28.z = dot (unity_SHBb, tmpvar_30);
  sphericalharmonics_14 = ((x1_29 + x2_28) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_14 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_5 * (tmpvar_26 + (sphericalharmonics_14 * _ambientscale)));
  tmpvar_10.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_32;
  tmpvar_32 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_22) - tmpvar_18)), tmpvar_19)), (tmpvar_4.w * _specularexponent))) * tmpvar_21) * _specularscale) * max (tmpvar_10.x, _specularblendtofull)) * ((mix ((tmpvar_31 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_25.z) * tmpvar_20)) * attenuation_16);
  color_17.xyz = (tmpvar_31 + tmpvar_32);
  color_17.xyz = mix (color_17.xyz, tmpvar_32, tmpvar_3.zzz);
  vec4 v_33;
  v_33.x = unity_MatrixV[0].y;
  v_33.y = unity_MatrixV[1].y;
  v_33.z = unity_MatrixV[2].y;
  v_33.w = unity_MatrixV[3].y;
  vec4 tmpvar_34;
  tmpvar_34.w = 0.0;
  tmpvar_34.xyz = tmpvar_7;
  vec3 tmpvar_35;
  tmpvar_35 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_25.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_33, tmpvar_34), 0.0, 1.0));
  rimlight_13 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_13 = (tmpvar_35 * atten_11);
  };
  color_17.xyz = (color_17.xyz + rimlight_13);
  vec3 tmpvar_36;
  tmpvar_36 = mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_10.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_12 = tmpvar_36;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_12 = (tmpvar_36 * attenuation_16);
  };
  color_17.xyz = (color_17.xyz + environment_12);
  color_17.w = 1.0;
  color_17.xyz = pow (color_17.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.xyz = color_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 51 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r1.w, c20.x
mov r1.xyz, c16
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r3.xyz, r0, c18.w, -v0
mov r1.xyz, v1
mov r0, c10
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mov r1, c8
dp4 r4.x, c17, r1
mul r2.xyz, v1.w, r2
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mad r0.xyz, r4, c18.w, -v0
dp3 o5.y, r2, r0
dp3 o5.z, v2, r0
dp3 o5.x, v1, r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.y, r2, c4
dp3 r1.w, -r3, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul o2, r1, c18.w
dp3 r1.y, r2, c5
dp3 r1.w, -r3, c5
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul o3, r1, c18.w
dp3 r1.y, r2, c6
dp3 r1.w, -r3, c6
dp3 r1.x, v1, c6
dp3 r1.z, v2, c6
dp3 o6.y, r2, r3
mul o4, r1, c18.w
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.z, r0, c14
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedfkcgeiepfiahgailadcibjjkljlpghbhabaaaaaadmakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
fiaiaaaaeaaaabaabgacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadhccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaoaaaaaa
ogikcaaaaaaaaaaaaoaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaal
hcaabaaaaaaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaaabaaaaaa
fgafbaiaebaaaaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaallcaabaaaabaaaaaaegiicaaaadaaaaaaaoaaaaaakgakbaia
ebaaaaaaaaaaaaaaegaibaaaabaaaaaadgaaaaaficaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaadaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgbpbaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaaakiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaaakiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
akiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaacaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaaficaabaaaacaaaaaabkaabaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
bkiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaabkiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaadaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaagbcaabaaaacaaaaaackiacaaa
adaaaaaaamaaaaaadgaaaaagccaabaaaacaaaaaackiacaaaadaaaaaaanaaaaaa
dgaaaaagecaabaaaacaaaaaackiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaahaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform mat4 _LightMatrix0;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec4 _WorldSpaceLightPos0;
uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
  xlv_TEXCOORD4 = (tmpvar_6 * (_World2Object * _WorldSpaceLightPos0).xyz);
  xlv_TEXCOORD5 = (tmpvar_6 * (((_World2Object * tmpvar_13).xyz * unity_Scale.w) - gl_Vertex.xyz));
  xlv_TEXCOORD6 = (_LightMatrix0 * (_Object2World * gl_Vertex)).xy;
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD6;
varying vec3 xlv_TEXCOORD5;
varying vec3 xlv_TEXCOORD4;
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform float _fresnelwarpblendtonone;
uniform sampler2D _fresnelwarp;
uniform float _envmapintensity;
uniform samplerCube _envmap;
uniform float _maskenvbymetalness;
uniform float _specularscale;
uniform vec3 _specularcolor;
uniform float _specularblendtofull;
uniform float _specularexponent;
uniform vec3 _rimlightcolor;
uniform float _rimlightblendtofull;
uniform float _rimlightscale;
uniform sampler2D _maskmap2;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
uniform float _ambientscale;
uniform sampler2D _LightTexture0;
uniform vec4 _LightColor0;
uniform mat4 unity_MatrixV;
uniform vec4 unity_SHC;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBr;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAr;
uniform vec4 _WorldSpaceLightPos0;
void main ()
{
  vec4 c_1;
  vec3 tmpvar_2;
  tmpvar_2.x = xlv_TEXCOORD1.w;
  tmpvar_2.y = xlv_TEXCOORD2.w;
  tmpvar_2.z = xlv_TEXCOORD3.w;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_maskmap1, xlv_TEXCOORD0);
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_maskmap2, xlv_TEXCOORD0);
  vec3 tmpvar_5;
  tmpvar_5 = pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2));
  vec3 normal_6;
  normal_6.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_6.z = sqrt((1.0 - clamp (dot (normal_6.xy, normal_6.xy), 0.0, 1.0)));
  vec3 tmpvar_7;
  tmpvar_7.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_7.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_7.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec3 tmpvar_8;
  tmpvar_8.x = dot (xlv_TEXCOORD1.xyz, normal_6);
  tmpvar_8.y = dot (xlv_TEXCOORD2.xyz, normal_6);
  tmpvar_8.z = dot (xlv_TEXCOORD3.xyz, normal_6);
  vec4 tmpvar_9;
  tmpvar_9 = textureCube (_envmap, (tmpvar_2 - (2.0 * (dot (tmpvar_8, tmpvar_2) * tmpvar_8))));
  vec4 tmpvar_10;
  tmpvar_10 = tmpvar_4;
  float atten_11;
  atten_11 = texture2D (_LightTexture0, xlv_TEXCOORD6).w;
  vec3 environment_12;
  vec3 rimlight_13;
  vec3 sphericalharmonics_14;
  vec3 fresnel_15;
  float attenuation_16;
  vec4 color_17;
  color_17 = vec4(0.0, 0.0, 0.0, 0.0);
  vec3 tmpvar_18;
  tmpvar_18 = normalize(normalize(xlv_TEXCOORD5));
  float tmpvar_19;
  tmpvar_19 = clamp (dot (normal_6, xlv_TEXCOORD4), 0.0, 1.0);
  vec3 tmpvar_20;
  tmpvar_20 = (_LightColor0.xyz * 2.0);
  attenuation_16 = atten_11;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    attenuation_16 = (atten_11 * tmpvar_19);
  };
  float tmpvar_21;
  tmpvar_21 = ((tmpvar_19 * 0.5) + 0.5);
  float tmpvar_22;
  tmpvar_22 = pow ((1.0 - clamp (dot (normal_6, tmpvar_18), 0.0, 1.0)), 5.0);
  fresnel_15.xy = vec2(tmpvar_22);
  fresnel_15.z = (1.0 - tmpvar_22);
  vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = clamp (dot (normal_6, tmpvar_18), 0.0, 1.0);
  vec3 tmpvar_24;
  tmpvar_24 = mix (fresnel_15, texture2D (_fresnelwarp, tmpvar_23).xyz, vec3(_fresnelwarpblendtonone));
  fresnel_15 = tmpvar_24;
  vec3 tmpvar_25;
  tmpvar_25 = ((vec3(tmpvar_21) * tmpvar_20) * attenuation_16);
  vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_7;
  vec3 x2_27;
  vec3 x1_28;
  x1_28.x = dot (unity_SHAr, tmpvar_26);
  x1_28.y = dot (unity_SHAg, tmpvar_26);
  x1_28.z = dot (unity_SHAb, tmpvar_26);
  vec4 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyzz * tmpvar_7.yzzx);
  x2_27.x = dot (unity_SHBr, tmpvar_29);
  x2_27.y = dot (unity_SHBg, tmpvar_29);
  x2_27.z = dot (unity_SHBb, tmpvar_29);
  sphericalharmonics_14 = ((x1_28 + x2_27) + (unity_SHC.xyz * ((tmpvar_7.x * tmpvar_7.x) - (tmpvar_7.y * tmpvar_7.y))));
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    sphericalharmonics_14 = vec3(0.0, 0.0, 0.0);
  };
  vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5 * (tmpvar_25 + (sphericalharmonics_14 * _ambientscale)));
  tmpvar_10.x = pow (tmpvar_4.xxx, vec3(2.2, 2.2, 2.2)).x;
  vec3 tmpvar_31;
  tmpvar_31 = (((((vec3(pow (max (0.0, dot (normalize((((2.0 * normal_6) * tmpvar_21) - xlv_TEXCOORD4)), tmpvar_18)), (tmpvar_4.w * _specularexponent))) * tmpvar_20) * _specularscale) * max (tmpvar_10.x, _specularblendtofull)) * ((mix ((tmpvar_30 + tmpvar_3.z), _specularcolor, tmpvar_4.zzz) * tmpvar_24.z) * tmpvar_19)) * attenuation_16);
  color_17.xyz = (tmpvar_30 + tmpvar_31);
  color_17.xyz = mix (color_17.xyz, tmpvar_31, tmpvar_3.zzz);
  vec4 v_32;
  v_32.x = unity_MatrixV[0].y;
  v_32.y = unity_MatrixV[1].y;
  v_32.z = unity_MatrixV[2].y;
  v_32.w = unity_MatrixV[3].y;
  vec4 tmpvar_33;
  tmpvar_33.w = 0.0;
  tmpvar_33.xyz = tmpvar_7;
  vec3 tmpvar_34;
  tmpvar_34 = ((((max (tmpvar_4.y, _rimlightblendtofull) * tmpvar_24.x) * _rimlightscale) * _rimlightcolor) * clamp (dot (v_32, tmpvar_33), 0.0, 1.0));
  rimlight_13 = tmpvar_34;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    rimlight_13 = (tmpvar_34 * atten_11);
  };
  color_17.xyz = (color_17.xyz + rimlight_13);
  vec3 tmpvar_35;
  tmpvar_35 = mix (((tmpvar_9.xyz * _envmapintensity) * tmpvar_10.x), ((tmpvar_9.xyz * _envmapintensity) * tmpvar_3.z), vec3(_maskenvbymetalness));
  environment_12 = tmpvar_35;
  if ((0.0 != _WorldSpaceLightPos0.w)) {
    environment_12 = (tmpvar_35 * attenuation_16);
  };
  color_17.xyz = (color_17.xyz + environment_12);
  color_17.w = 1.0;
  color_17.xyz = pow (color_17.xyz, vec3(0.454545, 0.454545, 0.454545));
  c_1.xyz = color_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_basetexture_ST]
"vs_3_0
; 49 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c20.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, v1.w, r1
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp3 r0.y, r2, c4
dp3 r0.w, -r3, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c18.w
dp3 r0.y, r2, c5
dp3 r0.w, -r3, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c18.w
dp3 r0.y, r2, c6
dp3 r0.w, -r3, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c18.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r4
dp3 o6.y, r2, r3
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
dp3 o6.z, v2, r3
dp3 o6.x, v1, r3
dp4 o7.y, r0, c13
dp4 o7.x, r0, c12
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Matrix 48 [_LightMatrix0]
Vector 224 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
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
eefiecedbhhicgcflkoabanpbnkmfifepcnbfnbjabaaaaaabaakaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaneaaaaaaagaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
cmaiaaaaeaaaabaaalacaaaafjaaaaaeegiocaaaaaaaaaaaapaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaakmccabaaaabaaaaaaagiecaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaagaebaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaoaaaaaaogikcaaaaaaaaaaaaoaaaaaadiaaaaaj
hcaabaaaaaaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaadcaaaaalhcaabaaaaaaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaadiaaaaajhcaabaaaabaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agaabaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaallcaabaaaabaaaaaa
egiicaaaadaaaaaaaoaaaaaakgakbaiaebaaaaaaaaaaaaaaegaibaaaabaaaaaa
dgaaaaaficaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaadaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaaaeaaaaaa
akiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaaaeaaaaaaakiacaaaadaaaaaa
anaaaaaadgaaaaagecaabaaaaeaaaaaaakiacaaaadaaaaaaaoaaaaaabaaaaaah
ccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadgaaaaaficaabaaaacaaaaaabkaabaaa
abaaaaaadgaaaaagbcaabaaaaeaaaaaabkiacaaaadaaaaaaamaaaaaadgaaaaag
ccaabaaaaeaaaaaabkiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaaeaaaaaa
bkiacaaaadaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
aeaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaaeaaaaaa
diaaaaaipccabaaaadaaaaaaegaobaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
dgaaaaagbcaabaaaacaaaaaackiacaaaadaaaaaaamaaaaaadgaaaaagccaabaaa
acaaaaaackiacaaaadaaaaaaanaaaaaadgaaaaagecaabaaaacaaaaaackiacaaa
adaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaai
pccabaaaaeaaaaaaegaobaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
baaaaaahcccabaaaagaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaah
bccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
afaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaagaaaaaa
egbcbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaaheccabaaaagaaaaaaegbcbaaa
acaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_fresnelwarp] 2D 6
"ps_3_0
; 121 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
def c24, 2.00000000, -1.00000000, 1.00000000, 0.50000000
def c25, 0.00000000, 5.00000000, 2.20000005, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0, s3
mad_pp r4.xy, r0.wyzw, c24.x, c24.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.z
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
dp3_pp r4.w, r4, v2
dp3_pp r5.w, r4, v3
dp3_pp r3.x, r4, v1
mov_pp r3.y, r4.w
mov_pp r3.z, r5.w
mov r1.w, c24.z
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r3, r0
mul_pp r1.xyz, r3, r0.w
mad_pp r0.xyz, -r1, c24.x, r0
texld r1.xyz, r0, s4
pow r0, r1.x, c25.z
pow r2, r1.y, c25.z
mov r1.x, r0
pow r0, r1.z, c25.z
mov r1.z, r0
mov r1.y, r2
texld r2, v0, s1
mul_pp r1.xyz, r1, c22.x
dp3_pp r0.x, v4, v4
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, v4
dp3_pp r0.x, r5, r5
rsq_pp r0.y, r0.x
mul_pp r5.xyz, r0.y, r5
dp3 r0.x, v6, v6
mul_pp r6.xyz, r2.x, r1
texld r0.z, v0, s0
mad_pp r1.xyz, r0.z, r1, -r6
mad_pp r1.xyz, r1, c21.x, r6
dp3_pp_sat r3.w, r4, r5
texld r0.x, r0.x, s5
abs r0.y, -c4.w
mul_pp r0.w, r3, r0.x
cmp_pp r0.w, -r0.y, r0.x, r0
mul_pp r6.xyz, r0.w, r1
cmp_pp r9.xyz, -r0.y, r1, r6
mov r1.x, r3
mov r1.y, r4.w
mov r1.z, r5.w
mul_pp r6, r1.xyzz, r1.yzzx
dp4 r7.z, r1, c7
dp4 r7.y, r1, c6
dp4 r7.x, r1, c5
dp4 r1.z, r6, c10
dp4 r1.x, r6, c8
dp4 r1.y, r6, c9
add_pp r6.xyz, r7, r1
mul_pp r1.x, r4.w, r4.w
mad_pp r1.x, r3, r3, -r1
mul r7.xyz, r1.x, c11
add_pp r6.xyz, r6, r7
cmp_pp r6.xyz, -r0.y, r6, c25.x
dp3_pp r1.y, v5, v5
rsq_pp r1.y, r1.y
mul_pp r1.xyz, r1.y, v5
dp3_pp r1.w, r1, r1
rsq_pp r1.w, r1.w
mul_pp r8.xyz, r1.w, r1
dp3_pp_sat r11.x, r4, r8
mad_pp r4.w, r3, c24, c24
mov_pp r11.y, c25.x
mul_pp r4.xyz, r4.w, r4
mad_pp r4.xyz, r4, c24.x, -r5
mul_pp r7.xyz, r6, c13.x
mov_pp r1.xyz, c12
mul_pp r6.xyz, c24.x, r1
mul_pp r1.xyz, r4.w, r6
mad_pp r7.xyz, r1, r0.w, r7
texld r1.xyz, v0, s2
mul_pp r7.xyz, r1, r7
add_pp r5.w, -r11.x, c24.z
pow_pp r1, r5.w, c25.y
add_pp r10.xyz, r0.z, r7
mov_pp r11.z, r1.x
add_pp r1.yzw, -r10.xxyz, c19.xxyz
mad_pp r1.xyz, r2.z, r1.yzww, r10
dp3_pp r1.w, r4, r4
rsq_pp r1.w, r1.w
mul_pp r4.xyz, r1.w, r4
dp3_pp r1.w, r4, r8
add_pp r11.w, -r11.z, c24.z
texld r12.xz, r11, s6
add_pp r11.xy, r12.xzzw, -r11.zwzw
mad_pp r10.xy, r11, c23.x, r11.zwzw
mul_pp r1.xyz, r1, r10.y
max_pp r2.y, r2, c15.x
mul_pp r2.y, r10.x, r2
mul_pp r2.z, r2.y, c14.x
mul_pp r2.y, r2.w, c17.x
max_pp r1.w, r1, c25.x
pow_pp r4, r1.w, r2.y
mov_pp r1.w, r4.x
mul_pp r4.xyz, r6, r1.w
dp3_pp_sat r2.y, r3, c1
mul_pp r5.xyz, r2.z, c16
mul_pp r3.xyz, r5, r2.y
max_pp r1.w, r2.x, c18.x
mul_pp r2.xyz, r4, c20.x
mul_pp r2.xyz, r2, r1.w
mul_pp r1.xyz, r3.w, r1
mul_pp r1.xyz, r2, r1
mul_pp r2.xyz, r0.x, r3
cmp_pp r2.xyz, -r0.y, r3, r2
mad_pp r1.xyz, r0.w, r1, r7
mad_pp r0.xyz, r0.z, -r7, r1
add_pp r0.xyz, r0, r2
add_pp oC0.xyz, r0, r9
mov_pp oC0.w, c25.x
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 3
SetTexture 1 [_maskmap2] 2D 4
SetTexture 2 [_basetexture] 2D 1
SetTexture 3 [_normalmap] 2D 2
SetTexture 4 [_envmap] CUBE 5
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_fresnelwarp] 2D 6
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedaaokcpimhogjaomhmedjjbekdiafpjigabaaaaaaiaapaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaaoaaaaeaaaaaaaimadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpdiaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaa
diaaaaaibcaabaaaabaaaaaadkaabaaaadaaaaaaakiacaaaaaaaaaaaajaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaa
pgipcaaaaaaaaaaaakaaaaaadeaaaaaiecaabaaaaaaaaaaaakaabaaaadaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaeaaaaaakgakbaaaaaaaaaaa
egacbaaaaeaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
agaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaagaaaaaa
akaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
dcaabaaaaaaaaaaaigaabaaaafaaaaaaegaabaiaebaaaaaaagaaaaaadcaaaaak
dcaabaaaaaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaaaaaaaaaegaabaaa
agaaaaaabaaaaaahecaabaaaafaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaah
ccaabaaaafaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaadgaaaaaficaabaaa
afaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaa
cgaaaaaaegaobaaaafaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaa
chaaaaaaegaobaaaafaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaa
ciaaaaaaegaobaaaafaaaaaadiaaaaahpcaabaaaagaaaaaajgacbaaaafaaaaaa
egakbaaaafaaaaaabbaaaaaibcaabaaaahaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaagaaaaaabbaaaaaiccaabaaaahaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaagaaaaaabbaaaaaiecaabaaaahaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaagaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
ahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaafaaaaaabkaabaaaafaaaaaa
dcaaaaakecaabaaaaaaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaackaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaa
kgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaagiacaaaaaaaaaaaahaaaaaadjaaaaaiecaabaaaaaaaaaaadkiacaaa
abaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaacaaaaaakgakbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaabaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaefaaaaaj
pcaabaaaagaaaaaapgapbaaaabaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaagaaaaaadhaaaaaj
icaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaagaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaadaaaaaadcaaaaajocaabaaaagaaaaaaagajbaaaacaaaaaa
agajbaaaabaaaaaakgakbaaaahaaaaaaaaaaaaajlcaabaaaahaaaaaajganbaia
ebaaaaaaagaaaaaaegiicaaaaaaaaaaaakaaaaaadcaaaaajocaabaaaagaaaaaa
kgakbaaaadaaaaaaaganbaaaahaaaaaafgaobaaaagaaaaaadiaaaaahocaabaaa
agaaaaaafgafbaaaaaaaaaaafgaobaaaagaaaaaadiaaaaahocaabaaaagaaaaaa
pgapbaaaaaaaaaaafgaobaaaagaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaa
aeaaaaaajgahbaaaagaaaaaadiaaaaahocaabaaaagaaaaaapgapbaaaabaaaaaa
agajbaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaajgahbaaaagaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaaeaaaaaa
pgapbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
kgakbaaaahaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaaiccaabaaa
aaaaaaaabkaabaaaadaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaailcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegiicaaaaaaaaaaaaiaaaaaadgaaaaagbcaabaaaacaaaaaa
bkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaaacaaaaaabkiacaaaacaaaaaa
agaaaaaadgaaaaagecaabaaaacaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaah
bcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaafaaaaaadiaaaaahlcaabaaa
aaaaaaaaegambaaaaaaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaagaaaaaaegadbaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaibaaaacaaaaaaegambaaaaaaaaaaaaaaaaaahlcaabaaaaaaaaaaa
egambaaaaaaaaaaaegaibaaaabaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaa
acaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaa
abaaaaaadkbabaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaafaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaaabaaaaaa
eghobaaaaeaaaaaaaagabaaaafaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
acaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaamnmmamea
mnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaadaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaahaaaaaaegacbaiaebaaaaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaaegadbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
"ps_3_0
; 109 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c24, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c25, 5.00000000, 0.50000000, 2.20000005, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
texld r0.yw, v0, s3
mad_pp r5.xy, r0.wyzw, c24.x, c24.y
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.z
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r6.w, r5, v2
dp3_pp r2.x, r5, v1
dp3_pp r2.z, r5, v3
mov r2.y, r6.w
mov r2.w, c24.z
dp4 r8.z, r2, c7
dp4 r8.y, r2, c6
dp4 r8.x, r2, c5
mul_pp r2.w, r6, r6
mov_pp r4.x, r2
mov_pp r4.z, r2
dp3_pp_sat r5.w, r5, v4
mov_pp r4.y, r6.w
mad_pp r2.w, r2.x, r2.x, -r2
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r4, r0
mul_pp r1.xyz, r4, r0.w
mad_pp r0.xyz, -r1, c24.x, r0
texld r1.xyz, r0, s4
pow r3, r1.y, c25.z
abs_pp r3.x, -c4.w
pow r0, r1.x, c25.z
mov r1.x, r0
pow r0, r1.z, c25.z
cmp_pp r4.w, -r3.x, c24.z, r5
mov r1.z, r0
mov r1.y, r3
mul_pp r0.xyz, r1, c22.x
texld r1, v0, s1
mul_pp r6.xyz, r1.x, r0
texld r3.z, v0, s0
mad_pp r0.xyz, r3.z, r0, -r6
mad_pp r6.xyz, r0, c21.x, r6
mul_pp r0, r2.xyzz, r2.yzzx
mul_pp r7.xyz, r4.w, r6
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul r0.xyz, r2.w, c11
add_pp r2.xyz, r8, r2
add_pp r0.xyz, r2, r0
cmp_pp r2.xyz, -r3.x, r0, c24.w
dp3_pp r2.w, v5, v5
cmp_pp r7.xyz, -r3.x, r6, r7
mov_pp r0.xyz, c12
mul_pp r6.xyz, c24.x, r0
mad_pp r0.w, r5, c25.y, c25.y
mul_pp r0.xyz, r0.w, r6
mul_pp r2.xyz, r2, c13.x
mad_pp r2.xyz, r0, r4.w, r2
texld r0.xyz, v0, s2
mul_pp r8.xyz, r0, r2
add_pp r2.xyz, r3.z, r8
add_pp r9.xyz, -r2, c19
rsq_pp r2.w, r2.w
mul_pp r0.xyz, r2.w, v5
dp3_pp r2.w, r0, r0
mad_pp r3.xyw, r1.z, r9.xyzz, r2.xyzz
rsq_pp r2.w, r2.w
mul_pp r9.xyz, r2.w, r0
dp3_pp_sat r0.x, r5, r9
mul_pp r5.xyz, r5, r0.w
mov_pp r0.y, c24.w
texld r2.xz, r0, s5
add_pp r1.z, -r0.x, c24
pow_pp r0, r1.z, c25.x
mov_pp r2.y, r0.x
mad_pp r5.xyz, r5, c24.x, -v4
dp3_pp r0.y, r5, r5
rsq_pp r0.x, r0.y
mul_pp r0.xyz, r0.x, r5
add_pp r2.w, -r2.y, c24.z
dp3_pp r0.x, r9, r0
max_pp r1.z, r0.x, c24.w
mul_pp r1.w, r1, c17.x
pow_pp r0, r1.z, r1.w
add_pp r5.xy, r2.xzzw, -r2.ywzw
mad_pp r1.zw, r5.xyxy, c23.x, r2.xyyw
mov_pp r0.w, r0.x
mul_pp r2.xyz, r1.w, r3.xyww
mul_pp r0.xyz, r5.w, r2
mul_pp r2.xyz, r6, r0.w
max_pp r0.w, r1.x, c18.x
mul_pp r2.xyz, r2, c20.x
mul_pp r2.xyz, r2, r0.w
max_pp r0.w, r1.y, c15.x
mul_pp r0.w, r0, r1.z
mul_pp r0.xyz, r2, r0
mad_pp r0.xyz, r4.w, r0, r8
mul_pp r0.w, r0, c14.x
mad_pp r1.xyz, r3.z, -r8, r0
mul_pp r0.xyz, r0.w, c16
dp3_pp_sat r0.w, r4, c1
mad_pp r0.xyz, r0, r0.w, r1
add_pp oC0.xyz, r0, r7
mov_pp oC0.w, c24
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 2
SetTexture 1 [_maskmap2] 2D 3
SetTexture 2 [_basetexture] 2D 0
SetTexture 3 [_normalmap] 2D 1
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 48 [_ambientscale]
Float 52 [_rimlightscale]
Float 56 [_rimlightblendtofull]
Vector 64 [_rimlightcolor] 3
Float 80 [_specularexponent]
Float 84 [_specularblendtofull]
Vector 96 [_specularcolor] 3
Float 108 [_specularscale]
Float 112 [_maskenvbymetalness]
Float 116 [_envmapintensity]
Float 120 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedegeekkijemhiceioamcebleciblgkobdabaaaaaaeeaoaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamanaaaaeaaaaaaaedadaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacakaaaaaadgaaaaafccaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaaaaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
aeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaaeaaaaaa
akaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
dcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaakgikcaaaaaaaaaaaahaaaaaaegaabaaaaaaaaaaaegaabaaa
aeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaa
adaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaa
adaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
chaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
ciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaaadaaaaaa
egakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaa
agaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaackaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaacmaaaaaa
kgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagiacaaaaaaaaaaaadaaaaaadjaaaaaiecaabaaaaaaaaaaadkiacaaa
abaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaaeaaaaaakgakbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaeaaaaaa
bacaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegbcbaaaafaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadp
aaaaaaajhcaabaaaafaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaagaaaaaapgapbaaaabaaaaaaegacbaaaafaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadcaaaaan
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegbcbaiaebaaaaaaafaaaaaadhaaaaajicaabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaeaaaaaa
egacbaaaagaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
agaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaahaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
dcaaaaajlcaabaaaahaaaaaaegaibaaaagaaaaaaegaibaaaaeaaaaaakgakbaaa
ahaaaaaaaaaaaaajhcaabaaaaiaaaaaaegadbaiaebaaaaaaahaaaaaaegiccaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaajaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaajlcaabaaaahaaaaaakgakbaaaajaaaaaa
egaibaaaaiaaaaaaegambaaaahaaaaaadiaaaaahlcaabaaaahaaaaaafgafbaaa
aaaaaaaaegambaaaahaaaaaadiaaaaahlcaabaaaahaaaaaapgapbaaaaaaaaaaa
egambaaaahaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaajaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
afaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaagaaaaaadeaaaaaiccaabaaaaaaaaaaaakaabaaaajaaaaaa
bkiacaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegadbaaaahaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaajhcaabaaaabaaaaaakgakbaaaahaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadeaaaaaiccaabaaaaaaaaaaabkaabaaa
ajaaaaaackiacaaaaaaaaaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaadaaaaaadiaaaaailcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiicaaaaaaaaaaaaeaaaaaadgaaaaagbcaabaaaacaaaaaabkiacaaaacaaaaaa
afaaaaaadgaaaaagccaabaaaacaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaag
ecaabaaaacaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaahbcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadcaaaaajlcaabaaaaaaaaaaaegambaaa
aaaaaaaaagaabaaaacaaaaaaegaibaaaabaaaaaadgaaaaafbcaabaaaabaaaaaa
dkbabaaaacaaaaaadgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaaf
ecaabaaaabaaaaaadkbabaaaaeaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaadaaaaaaagaabaia
ebaaaaaaacaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaa
abaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaacpaaaaafhcaabaaaabaaaaaa
egacbaaaacaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
mnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaa
ahaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaajaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaahaaaaaaegacbaia
ebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaaegadbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
SetTexture 7 [_fresnelwarp] 2D 7
"ps_3_0
; 126 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c24, 2.00000000, -1.00000000, 1.00000000, 0.50000000
def c25, 0.00000000, 1.00000000, 5.00000000, 2.20000005
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
texld r0.yw, v0, s3
mad_pp r4.xy, r0.wyzw, c24.x, c24.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.z
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
dp3_pp r0.y, r4, v2
dp3_pp r6.w, r4, v3
dp3_pp r3.x, r4, v1
mov_pp r3.y, r0
mov_pp r3.z, r6.w
abs r3.w, -c4
texld r0.z, v0, s0
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3_pp r0.x, r3, r1
mul_pp r2.xyz, r3, r0.x
mad_pp r1.xyz, -r2, c24.x, r1
texld r2.xyz, r1, s4
pow r5, r2.y, c25.w
pow r1, r2.x, c25.w
mov r2.x, r1
pow r1, r2.z, c25.w
dp3_pp r0.x, v4, v4
mov r2.z, r1
mov r2.y, r5
mul_pp r1.xyz, r2, c22.x
texld r2, v0, s1
mul_pp r6.xyz, r2.x, r1
mad_pp r1.xyz, r0.z, r1, -r6
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, v4
dp3_pp r0.x, r5, r5
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, r5
dp3 r0.x, v6, v6
mad_pp r1.xyz, r1, c21.x, r6
rcp r0.w, v6.w
mad r6.xy, v6, r0.w, c24.w
dp3_pp_sat r4.w, r4, r5
texld r0.w, r6, s5
cmp r1.w, -v6.z, c25.x, c25.y
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s6
mul_pp r5.w, r0, r0.x
mul_pp r0.x, r4.w, r5.w
cmp_pp r7.w, -r3, r5, r0.x
mul_pp r6.xyz, r7.w, r1
cmp_pp r9.xyz, -r3.w, r1, r6
mul_pp r0.x, r0.y, r0.y
mov r1.y, r0
dp3_pp r0.y, v5, v5
mov r1.x, r3
mov r1.z, r6.w
mov r1.w, c24.z
mul_pp r6, r1.xyzz, r1.yzzx
dp4 r7.z, r1, c7
dp4 r7.y, r1, c6
dp4 r7.x, r1, c5
dp4 r1.z, r6, c10
dp4 r1.x, r6, c8
dp4 r1.y, r6, c9
add_pp r6.xyz, r7, r1
mad_pp r0.x, r3, r3, -r0
mul r7.xyz, r0.x, c11
add_pp r6.xyz, r6, r7
rsq_pp r0.y, r0.y
mul_pp r1.xyz, r0.y, v5
dp3_pp r0.x, r1, r1
cmp_pp r6.xyz, -r3.w, r6, c25.x
rsq_pp r0.x, r0.x
mul_pp r8.xyz, r0.x, r1
dp3_pp_sat r11.x, r4, r8
mad_pp r6.w, r4, c24, c24
mul_pp r4.xyz, r6.w, r4
mad_pp r4.xyz, r4, c24.x, -r5
add_pp r0.x, -r11, c24.z
mul_pp r7.xyz, r6, c13.x
mov_pp r1.xyz, c12
mul_pp r6.xyz, c24.x, r1
mul_pp r1.xyz, r6.w, r6
mad_pp r7.xyz, r1, r7.w, r7
texld r1.xyz, v0, s2
mul_pp r7.xyz, r1, r7
pow_pp r1, r0.x, c25.z
mov_pp r11.z, r1.x
add_pp r10.xyz, r0.z, r7
mov_pp r11.y, c25.x
add_pp r0.xyw, -r10.xyzz, c19.xyzz
texld r1.xz, r11, s7
add_pp r11.w, -r11.z, c24.z
add_pp r11.xy, r1.xzzw, -r11.zwzw
mad_pp r1.xyz, r2.z, r0.xyww, r10
mad_pp r0.xy, r11, c23.x, r11.zwzw
mul_pp r1.xyz, r1, r0.y
max_pp r0.w, r2.y, c15.x
mul_pp r0.x, r0, r0.w
dp3_pp r0.y, r4, r4
rsq_pp r0.y, r0.y
mul_pp r4.xyz, r0.y, r4
mul_pp r0.w, r0.x, c14.x
dp3_pp r0.x, r4, r8
mul_pp r1.xyz, r4.w, r1
mul_pp r0.y, r2.w, c17.x
max_pp r0.x, r0, c25
pow_pp r4, r0.x, r0.y
mov_pp r0.x, r4
mul_pp r4.xyz, r6, r0.x
max_pp r0.x, r2, c18
mul_pp r2.xyz, r4, c20.x
mul_pp r2.xyz, r2, r0.x
mul_pp r1.xyz, r2, r1
dp3_pp_sat r0.y, r3, c1
mul_pp r5.xyz, r0.w, c16
mul_pp r3.xyz, r5, r0.y
mul_pp r2.xyz, r5.w, r3
mad_pp r1.xyz, r7.w, r1, r7
cmp_pp r2.xyz, -r3.w, r3, r2
mad_pp r0.xyz, r0.z, -r7, r1
add_pp r0.xyz, r0, r2
add_pp oC0.xyz, r0, r9
mov_pp oC0.w, c25.x
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 4
SetTexture 1 [_maskmap2] 2D 5
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 6
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_LightTextureB0] 2D 1
SetTexture 7 [_fresnelwarp] 2D 7
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecednfegkcdmgaaepgkkeinggfhihicabmpbabaaaaaahebaaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcceapaaaaeaaaaaaamjadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacalaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaa
ddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaabaaaaaadkaabaaaabaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaa
abaaaaaabbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaadaaaaaa
bbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaadaaaaaa
bbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaadaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaagiacaaa
aaaaaaaaahaaaaaadjaaaaaiicaabaaaaaaaaaaadkiacaaaabaaaaaaaaaaaaaa
abeaaaaaaaaaaaaadhaaaaamhcaabaaaacaaaaaapgapbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaacaaaaaaaoaaaaahdcaabaaa
adaaaaaaegbabaaaahaaaaaapgbpbaaaahaaaaaaaaaaaaakdcaabaaaadaaaaaa
egaabaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaa
dbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaackbabaaaahaaaaaaabaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
abaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahicaabaaaacaaaaaa
egbcbaaaahaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaaadaaaaaapgapbaaa
acaaaaaaeghobaaaagaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaadaaaaaabaaaaaahicaabaaaacaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaacaaaaaaegbcbaaaafaaaaaabacaaaah
icaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaa
adaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadhaaaaajicaabaaaadaaaaaa
dkaabaaaaaaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaadcaaaaajbcaabaaa
aeaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaaj
ocaabaaaaeaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaafaaaaaajgahbaaaaeaaaaaaagaabaaaaeaaaaaadiaaaaah
hcaabaaaagaaaaaaegacbaaaabaaaaaaagaabaaaaeaaaaaadcaaaaanhcaabaaa
adaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaa
pgapbaaaadaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaagaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaajlcaabaaa
agaaaaaaegaibaaaafaaaaaaegaibaaaacaaaaaakgakbaaaagaaaaaaaaaaaaaj
hcaabaaaahaaaaaaegadbaiaebaaaaaaagaaaaaaegiccaaaaaaaaaaaakaaaaaa
efaaaaajpcaabaaaaiaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
afaaaaaadcaaaaajlcaabaaaagaaaaaakgakbaaaaiaaaaaaegaibaaaahaaaaaa
egambaaaagaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaeeaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaahhcaabaaa
ahaaaaaaagaabaaaaeaaaaaaegbcbaaaagaaaaaabacaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaahaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaahaaaaaa
aagabaaaahaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahbcaabaaaakaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaak
ccaabaaaakaaaaaaakaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaaidcaabaaaabaaaaaaigaabaaaajaaaaaaegaabaiaebaaaaaa
akaaaaaadcaaaaakdcaabaaaabaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaa
abaaaaaaegaabaaaakaaaaaadiaaaaahlcaabaaaagaaaaaafgafbaaaabaaaaaa
egambaaaagaaaaaadiaaaaahlcaabaaaagaaaaaapgapbaaaacaaaaaaegambaaa
agaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
fgafbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaahaaaaaadeaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaadkaabaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaahhcaabaaaadaaaaaajgahbaaaaeaaaaaa
fgafbaaaabaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaapgipcaaa
aaaaaaaaakaaaaaadeaaaaaiccaabaaaabaaaaaaakaabaaaaiaaaaaabkiacaaa
aaaaaaaaajaaaaaadiaaaaahhcaabaaaadaaaaaafgafbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaaegadbaaaagaaaaaaegacbaaaadaaaaaa
diaaaaahhcaabaaaaeaaaaaapgapbaaaadaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
dcaaaaakhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaadcaaaaajhcaabaaaacaaaaaakgakbaaaagaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaadeaaaaaiccaabaaaabaaaaaabkaabaaaaiaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaabaaaaaaegiccaaa
aaaaaaaaaiaaaaaadgaaaaagbcaabaaaadaaaaaabkiacaaaacaaaaaaafaaaaaa
dgaaaaagccaabaaaadaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaa
adaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaahicaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaa
acaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaaeaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaaaaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegacbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaa
agaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmameamnmmameamnmmameaaaaaaaaa
bjaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgifcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaiaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaakgakbaaaagaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaagiacaaaaaaaaaaaalaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaadaaaaaaegacbaaaaaaaaaaadhaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
aaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTextureB0] 2D 5
SetTexture 6 [_LightTexture0] CUBE 6
SetTexture 7 [_fresnelwarp] 2D 7
"ps_3_0
; 122 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_cube s6
dcl_2d s7
def c24, 2.00000000, -1.00000000, 1.00000000, 0.50000000
def c25, 0.00000000, 5.00000000, 2.20000005, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0, s3
mad_pp r4.xy, r0.wyzw, c24.x, c24.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.z
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
dp3_pp r0.y, r4, v2
dp3_pp r6.w, r4, v3
dp3_pp r3.x, r4, v1
mov_pp r3.y, r0
mov_pp r3.z, r6.w
abs r3.w, -c4
texld r0.z, v0, s0
mov r1.x, v1.w
mov r1.z, v3.w
mov r1.y, v2.w
dp3_pp r0.x, r3, r1
mul_pp r2.xyz, r3, r0.x
mad_pp r1.xyz, -r2, c24.x, r1
texld r2.xyz, r1, s4
pow r5, r2.z, c25.z
pow r1, r2.x, c25.z
mov r2.x, r1
pow r1, r2.y, c25.z
dp3_pp r0.x, v4, v4
mov r1.w, c24.z
mov r2.y, r1
mov r2.z, r5
mul_pp r1.xyz, r2, c22.x
texld r2, v0, s1
mul_pp r6.xyz, r2.x, r1
mad_pp r1.xyz, r0.z, r1, -r6
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, v4
dp3_pp r0.x, r5, r5
rsq_pp r0.x, r0.x
mul_pp r5.xyz, r0.x, r5
dp3 r0.x, v6, v6
mad_pp r1.xyz, r1, c21.x, r6
dp3_pp_sat r4.w, r4, r5
texld r0.w, v6, s6
texld r0.x, r0.x, s5
mul r5.w, r0.x, r0
mul_pp r0.x, r4.w, r5.w
cmp_pp r7.w, -r3, r5, r0.x
mul_pp r6.xyz, r7.w, r1
cmp_pp r9.xyz, -r3.w, r1, r6
mul_pp r0.x, r0.y, r0.y
mov r1.y, r0
dp3_pp r0.y, v5, v5
mov r1.x, r3
mov r1.z, r6.w
mul_pp r6, r1.xyzz, r1.yzzx
dp4 r7.z, r1, c7
dp4 r7.y, r1, c6
dp4 r7.x, r1, c5
dp4 r1.z, r6, c10
dp4 r1.x, r6, c8
dp4 r1.y, r6, c9
add_pp r6.xyz, r7, r1
mad_pp r0.x, r3, r3, -r0
mul r7.xyz, r0.x, c11
add_pp r6.xyz, r6, r7
rsq_pp r0.y, r0.y
mul_pp r1.xyz, r0.y, v5
dp3_pp r0.x, r1, r1
cmp_pp r6.xyz, -r3.w, r6, c25.x
rsq_pp r0.x, r0.x
mul_pp r8.xyz, r0.x, r1
dp3_pp_sat r11.x, r4, r8
mad_pp r6.w, r4, c24, c24
mul_pp r4.xyz, r6.w, r4
mad_pp r4.xyz, r4, c24.x, -r5
add_pp r0.x, -r11, c24.z
mul_pp r7.xyz, r6, c13.x
mov_pp r1.xyz, c12
mul_pp r6.xyz, c24.x, r1
mul_pp r1.xyz, r6.w, r6
mad_pp r7.xyz, r1, r7.w, r7
texld r1.xyz, v0, s2
mul_pp r7.xyz, r1, r7
pow_pp r1, r0.x, c25.y
mov_pp r11.z, r1.x
add_pp r10.xyz, r0.z, r7
mov_pp r11.y, c25.x
add_pp r0.xyw, -r10.xyzz, c19.xyzz
texld r1.xz, r11, s7
add_pp r11.w, -r11.z, c24.z
add_pp r11.xy, r1.xzzw, -r11.zwzw
mad_pp r1.xyz, r2.z, r0.xyww, r10
mad_pp r0.xy, r11, c23.x, r11.zwzw
mul_pp r1.xyz, r1, r0.y
max_pp r0.w, r2.y, c15.x
mul_pp r0.x, r0, r0.w
dp3_pp r0.y, r4, r4
rsq_pp r0.y, r0.y
mul_pp r4.xyz, r0.y, r4
mul_pp r0.w, r0.x, c14.x
dp3_pp r0.x, r4, r8
mul_pp r1.xyz, r4.w, r1
mul_pp r0.y, r2.w, c17.x
max_pp r0.x, r0, c25
pow_pp r4, r0.x, r0.y
mov_pp r0.x, r4
mul_pp r4.xyz, r6, r0.x
max_pp r0.x, r2, c18
mul_pp r2.xyz, r4, c20.x
mul_pp r2.xyz, r2, r0.x
mul_pp r1.xyz, r2, r1
dp3_pp_sat r0.y, r3, c1
mul_pp r5.xyz, r0.w, c16
mul_pp r3.xyz, r5, r0.y
mul_pp r2.xyz, r5.w, r3
mad_pp r1.xyz, r7.w, r1, r7
cmp_pp r2.xyz, -r3.w, r3, r2
mad_pp r0.xyz, r0.z, -r7, r1
add_pp r0.xyz, r0, r2
add_pp oC0.xyz, r0, r9
mov_pp oC0.w, c25.x
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 4
SetTexture 1 [_maskmap2] 2D 5
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 6
SetTexture 5 [_LightTextureB0] 2D 1
SetTexture 6 [_LightTexture0] CUBE 0
SetTexture 7 [_fresnelwarp] 2D 7
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedcaddjlkkofifhomehbnkdfmbccmcogeiabaaaaaanmapaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcimaoaaaaeaaaaaaakdadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafidaaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacakaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaa
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaa
eeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
kgakbaaaaaaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaaaaaaaaabacaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaaaaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaaeaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaaeaaaaaaakaabaia
ebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaidcaabaaa
aaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaadcaaaaakdcaabaaa
aaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaaaaaaaaaegaabaaaaeaaaaaa
dgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaaadaaaaaa
egbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaaadaaaaaa
egacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaaadaaaaaaegakbaaa
adaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
afaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
afaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
afaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaagaaaaaa
diaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaak
ecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaackaabaiaebaaaaaa
aaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaacmaaaaaakgakbaaa
aaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaa
agiacaaaaaaaaaaaahaaaaaadjaaaaaiecaabaaaaaaaaaaadkiacaaaabaaaaaa
aaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaaeaaaaaakgakbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaapgapbaaaaaaaaaaa
egbcbaaaafaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
afaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaaadpaaaaaaajhcaabaaaagaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaabaaaaaa
egacbaaaagaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
abaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaahicaabaaa
abaaaaaaegbcbaaaahaaaaaaegbcbaaaahaaaaaaefaaaaajpcaabaaaafaaaaaa
pgapbaaaabaaaaaaeghobaaaafaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
aiaaaaaaegbcbaaaahaaaaaaeghobaaaagaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaabaaaaaaakaabaaaafaaaaaadkaabaaaaiaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajicaabaaaacaaaaaa
ckaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aeaaaaaaegacbaaaahaaaaaapgapbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aeaaaaaadcaaaaajlcaabaaaahaaaaaaegaibaaaafaaaaaaegaibaaaaeaaaaaa
kgakbaaaahaaaaaaaaaaaaajhcaabaaaaiaaaaaaegadbaiaebaaaaaaahaaaaaa
egiccaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaajaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaafaaaaaadcaaaaajlcaabaaaahaaaaaakgakbaaa
ajaaaaaaegaibaaaaiaaaaaaegambaaaahaaaaaadiaaaaahlcaabaaaahaaaaaa
fgafbaaaaaaaaaaaegambaaaahaaaaaadiaaaaahlcaabaaaahaaaaaapgapbaaa
aaaaaaaaegambaaaahaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaajaaaaaaakiacaaaaaaaaaaa
ajaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaagaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaaaaaaaaaakaaaaaadeaaaaaiccaabaaaaaaaaaaaakaabaaa
ajaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegadbaaaahaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaajhcaabaaaabaaaaaakgakbaaa
ahaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadeaaaaaiccaabaaaaaaaaaaa
bkaabaaaajaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaailcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegiicaaaaaaaaaaaaiaaaaaadgaaaaagbcaabaaaacaaaaaabkiacaaa
acaaaaaaafaaaaaadgaaaaagccaabaaaacaaaaaabkiacaaaacaaaaaaagaaaaaa
dgaaaaagecaabaaaacaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaahbcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahlcaabaaaaaaaaaaa
egambaaaaaaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegadbaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaakgakbaaaaaaaaaaa
egaibaaaacaaaaaaegambaaaaaaaaaaaaaaaaaahlcaabaaaaaaaaaaaegambaaa
aaaaaaaaegaibaaaabaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaacaaaaaa
dgaaaaafccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaa
dkbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaiaebaaaaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaagaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaa
diaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaamnmmameamnmmamea
mnmmameaaaaaaaaabjaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaajaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaakgakbaaaahaaaaaaegacbaiaebaaaaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaaegadbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "_LINEAR_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_fresnelwarp] 2D 6
"ps_3_0
; 114 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
def c24, 2.00000000, -1.00000000, 1.00000000, 0.50000000
def c25, 0.00000000, 5.00000000, 2.20000005, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xy
texld r0.yw, v0, s3
mad_pp r5.xy, r0.wyzw, c24.x, c24.y
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.z
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r7.w, r5, v2
dp3_pp r3.w, r5, v3
dp3_pp r4.x, r5, v1
mov_pp r4.z, r3.w
dp3_pp_sat r6.w, r5, v4
abs_pp r4.w, -c4
mov_pp r4.y, r7.w
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r4, r0
mul_pp r1.xyz, r4, r0.w
mad_pp r0.xyz, -r1, c24.x, r0
texld r1.xyz, r0, s4
pow r2, r1.y, c25.z
pow r0, r1.x, c25.z
mov r1.x, r0
pow r0, r1.z, c25.z
mov r1.z, r0
mov r1.y, r2
mul_pp r2.xyz, r1, c22.x
texld r1, v0, s1
texld r0.w, v6, s5
mul_pp r0.x, r6.w, r0.w
cmp_pp r5.w, -r4, r0, r0.x
mul_pp r0.x, r7.w, r7.w
dp3_pp r0.y, v5, v5
mul_pp r3.xyz, r1.x, r2
texld r0.z, v0, s0
mad_pp r2.xyz, r0.z, r2, -r3
mad_pp r3.xyz, r2, c21.x, r3
mul_pp r2.xyz, r5.w, r3
cmp_pp r6.xyz, -r4.w, r3, r2
mov r2.z, r3.w
mov r2.x, r4
mov r2.y, r7.w
mov r2.w, c24.z
mul_pp r3, r2.xyzz, r2.yzzx
dp4 r7.z, r2, c7
dp4 r7.y, r2, c6
dp4 r7.x, r2, c5
dp4 r2.z, r3, c10
dp4 r2.x, r3, c8
dp4 r2.y, r3, c9
mad_pp r0.x, r4, r4, -r0
add_pp r7.xyz, r7, r2
rsq_pp r0.y, r0.y
mul r3.xyz, r0.x, c11
mul_pp r2.xyz, r0.y, v5
add_pp r3.xyz, r7, r3
dp3_pp r0.x, r2, r2
cmp_pp r3.xyz, -r4.w, r3, c25.x
rsq_pp r0.x, r0.x
mul_pp r8.xyz, r0.x, r2
dp3_pp_sat r0.x, r5, r8
add_pp r0.y, -r0.x, c24.z
mul_pp r7.xyz, r3, c13.x
mov_pp r2.xyz, c12
mul_pp r3.xyz, c24.x, r2
mad_pp r3.w, r6, c24, c24
mul_pp r2.xyz, r3.w, r3
mad_pp r7.xyz, r2, r5.w, r7
texld r2.xyz, v0, s2
mul_pp r7.xyz, r2, r7
pow_pp r2, r0.y, c25.y
mov_pp r2.y, r2.x
add_pp r9.xyz, r0.z, r7
mov_pp r0.y, c25.x
add_pp r10.xyz, -r9, c19
add_pp r2.w, -r2.y, c24.z
texld r2.xz, r0, s6
add_pp r0.xy, r2.xzzw, -r2.ywzw
mad_pp r0.xy, r0, c23.x, r2.ywzw
mul_pp r2.xyz, r3.w, r5
mad_pp r9.xyz, r1.z, r10, r9
mul_pp r5.xyz, r9, r0.y
mad_pp r2.xyz, r2, c24.x, -v4
dp3_pp r0.y, r2, r2
max_pp r1.y, r1, c15.x
mul_pp r0.x, r0, r1.y
rsq_pp r0.y, r0.y
mul_pp r2.xyz, r0.y, r2
mul_pp r1.y, r0.x, c14.x
dp3_pp r0.x, r2, r8
mul_pp r0.y, r1.w, c17.x
max_pp r0.x, r0, c25
pow_pp r2, r0.x, r0.y
mov_pp r0.x, r2
mul_pp r3.xyz, r3, r0.x
max_pp r0.x, r1, c18
mul_pp r8.xyz, r1.y, c16
dp3_pp_sat r0.y, r4, c1
mul_pp r1.xyz, r3, c20.x
mul_pp r2.xyz, r8, r0.y
mul_pp r3.xyz, r0.w, r2
mul_pp r1.xyz, r1, r0.x
mul_pp r5.xyz, r6.w, r5
mul_pp r1.xyz, r1, r5
mad_pp r1.xyz, r5.w, r1, r7
cmp_pp r2.xyz, -r4.w, r2, r3
mad_pp r0.xyz, r0.z, -r7, r1
add_pp r0.xyz, r0, r2
add_pp oC0.xyz, r0, r6
mov_pp oC0.w, c25.x
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 3
SetTexture 1 [_maskmap2] 2D 4
SetTexture 2 [_basetexture] 2D 1
SetTexture 3 [_normalmap] 2D 2
SetTexture 4 [_envmap] CUBE 5
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_fresnelwarp] 2D 6
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedfehnljilipnpgpgfddmbmdfejjdmgifoabaaaaaabiapaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmianaaaaeaaaaaaahcadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacakaaaaaadgaaaaafccaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaaaaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
aeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaaeaaaaaa
akaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
dcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaaaaaaaaaegaabaaa
aeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaa
adaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaa
adaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
chaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
ciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaaadaaaaaa
egakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaa
agaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaackaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaacmaaaaaa
kgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagiacaaaaaaaaaaaahaaaaaadjaaaaaiecaabaaaaaaaaaaadkiacaaa
abaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaaeaaaaaakgakbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaeaaaaaa
bacaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegbcbaaaafaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadp
aaaaaaajhcaabaaaafaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaagaaaaaapgapbaaaabaaaaaaegacbaaaafaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadcaaaaan
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegbcbaiaebaaaaaaafaaaaaaefaaaaajpcaabaaaahaaaaaaogbkbaaa
abaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaahaaaaaadhaaaaajicaabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaahaaaaaadcaaaaajhcaabaaaaeaaaaaa
egacbaaaagaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
agaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaaiaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaahaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaakgakbaaa
aiaaaaaaaaaaaaajlcaabaaaaiaaaaaaegaibaiaebaaaaaaahaaaaaaegiicaaa
aaaaaaaaakaaaaaaefaaaaajpcaabaaaajaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaahaaaaaakgakbaaaajaaaaaa
egadbaaaaiaaaaaaegacbaaaahaaaaaadiaaaaahhcaabaaaahaaaaaafgafbaaa
aaaaaaaaegacbaaaahaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaaaaaaaaa
egacbaaaahaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaadkaabaaaajaaaaaaakiacaaaaaaaaaaaajaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaabjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
afaaaaaafgafbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaakaaaaaadeaaaaaiccaabaaaaaaaaaaaakaabaaaajaaaaaa
bkiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaahaaaaaaegacbaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadcaaaaajhcaabaaaabaaaaaakgakbaaaaiaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadeaaaaaiccaabaaaaaaaaaaabkaabaaa
ajaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaahaaaaaadiaaaaailcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egiicaaaaaaaaaaaaiaaaaaadgaaaaagbcaabaaaacaaaaaabkiacaaaacaaaaaa
afaaaaaadgaaaaagccaabaaaacaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaag
ecaabaaaacaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaahbcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahlcaabaaaaaaaaaaaegambaaa
aaaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaahaaaaaa
egadbaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaakgakbaaaaaaaaaaaegaibaaa
acaaaaaaegambaaaaaaaaaaaaaaaaaahlcaabaaaaaaaaaaaegambaaaaaaaaaaa
egaibaaaabaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaacaaaaaadgaaaaaf
ccaabaaaabaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaadkbabaaa
aeaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
aaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaadaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaafaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaamnmmameamnmmameamnmmamea
aaaaaaaabjaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaajaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaakgakbaaaaiaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
dhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaahhccabaaaaaaaaaaaegadbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_fresnelwarp] 2D 6
"ps_3_0
; 138 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
def c24, 2.20000005, 2.00000000, -1.00000000, 1.00000000
def c25, 0.50000000, 0.00000000, 5.00000000, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0, s3
mad_pp r5.xy, r0.wyzw, c24.y, c24.z
mul_pp r0.xy, r5, r5
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.w
rsq_pp r0.x, r0.x
rcp_pp r5.z, r0.x
dp3_pp r1.w, r5, v2
dp3_pp r3.x, r5, v3
dp3_pp r4.x, r5, v1
mov r2.x, r4
mov r2.y, r1.w
mov r2.z, r3.x
mov r2.w, c24
mul_pp r0, r2.xyzz, r2.yzzx
texld r11.xyz, v0, s2
dp4 r1.z, r2, c7
dp4 r1.y, r2, c6
dp4 r1.x, r2, c5
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul_pp r0.x, r1.w, r1.w
mad_pp r0.w, r4.x, r4.x, -r0.x
mov_pp r4.z, r3.x
mov_pp r4.y, r1.w
add_pp r1.xyz, r1, r2
mul r3.xyz, r0.w, c11
add_pp r1.xyz, r1, r3
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r1.w, r4, r0
mul_pp r2.xyz, r4, r1.w
mad_pp r0.xyz, -r2, c24.y, r0
texld r3.xyz, r0, s4
texld r2, v0, s1
pow r0, r2.x, c24.x
mov r0.y, r0.x
mul_pp r3.xyz, r3, c22.x
mul_pp r7.xyz, r0.y, r3
dp3_pp r0.z, v4, v4
rsq_pp r0.x, r0.z
mul_pp r6.xyz, r0.x, v4
texld r0.z, v0, s0
mad_pp r3.xyz, r0.z, r3, -r7
dp3_pp r0.x, r6, r6
rsq_pp r0.w, r0.x
mul_pp r6.xyz, r0.w, r6
dp3_pp_sat r4.w, r5, r6
abs r0.w, -c4
cmp_pp r1.xyz, -r0.w, r1, c25.y
mul_pp r8.xyz, r1, c13.x
dp3 r0.x, v6, v6
texld r0.x, r0.x, s5
mul_pp r1.w, r4, r0.x
cmp_pp r2.x, -r0.w, r0, r1.w
mad_pp r3.xyz, r3, c21.x, r7
mul_pp r7.xyz, r2.x, r3
dp3_pp r1.w, v5, v5
cmp_pp r10.xyz, -r0.w, r3, r7
mov_pp r1.xyz, c12
mul_pp r7.xyz, c24.y, r1
mad_pp r5.w, r4, c25.x, c25.x
rsq_pp r1.w, r1.w
mul_pp r1.xyz, r1.w, v5
mul_pp r3.xyz, r5.w, r7
mad_pp r8.xyz, r3, r2.x, r8
pow r3, r11.y, c24.x
dp3_pp r1.w, r1, r1
rsq_pp r1.w, r1.w
mul_pp r9.xyz, r1.w, r1
dp3_pp_sat r12.x, r5, r9
pow r1, r11.x, c24.x
mov r11.x, r1
pow r1, r11.z, c24.x
mul_pp r5.xyz, r5.w, r5
mad_pp r6.xyz, r5, c24.y, -r6
mov r11.y, r3
mov r11.z, r1
mul_pp r3.xyz, r11, r8
add_pp r8.xyz, r0.z, r3
add_pp r6.w, -r12.x, c24
pow_pp r1, r6.w, c25.z
mov_pp r12.z, r1.x
mov_pp r12.y, c25
texld r1.xz, r12, s6
add_pp r12.w, -r12.z, c24
add_pp r11.xyz, -r8, c19
add_pp r12.xy, r1.xzzw, -r12.zwzw
mad_pp r1.xyz, r2.z, r11, r8
mad_pp r8.xy, r12, c23.x, r12.zwzw
mul_pp r1.xyz, r1, r8.y
mul_pp r5.xyz, r4.w, r1
max_pp r1.y, r2, c15.x
mul_pp r1.w, r8.x, r1.y
dp3_pp r1.x, r6, r6
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r6
mul_pp r3.w, r1, c14.x
dp3_pp r1.x, r1, r9
max_pp r2.y, r1.x, c25
mul_pp r2.z, r2.w, c17.x
pow_pp r1, r2.y, r2.z
mov_pp r1.w, r1.x
dp3_pp_sat r1.y, r4, c1
mul_pp r4.xyz, r7, r1.w
mul_pp r6.xyz, r3.w, c16
mul_pp r1.xyz, r6, r1.y
max_pp r0.y, r0, c18.x
mul_pp r4.xyz, r4, c20.x
mul_pp r4.xyz, r4, r0.y
mul_pp r4.xyz, r4, r5
mul_pp r5.xyz, r0.x, r1
mad_pp r2.xyz, r2.x, r4, r3
cmp_pp r1.xyz, -r0.w, r1, r5
mad_pp r0.xyz, r0.z, -r3, r2
add_pp r0.xyz, r0, r1
add_pp r2.xyz, r0, r10
pow r0, r2.x, c25.w
mov r2.x, r0
pow r0, r2.z, c25.w
pow r1, r2.y, c25.w
mov r2.z, r0
mov r2.y, r1
mov_pp oC0.xyz, r2
mov_pp oC0.w, c25.y
"
}
SubProgram "d3d11 " {
Keywords { "POINT" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 3
SetTexture 1 [_maskmap2] 2D 4
SetTexture 2 [_basetexture] 2D 1
SetTexture 3 [_normalmap] 2D 2
SetTexture 4 [_envmap] CUBE 5
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_fresnelwarp] 2D 6
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecednlmgnnaonhdhdafemimgobiofpogbiklabaaaaaabebaaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeaoaaaaeaaaaaaalbadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacajaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaa
egaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabacaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadcaaaaajicaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpdiaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaia
ebaaaaaaabaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaabacaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadeaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaa
diaaaaaibcaabaaaabaaaaaadkaabaaaadaaaaaaakiacaaaaaaaaaaaajaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaa
pgipcaaaaaaaaaaaakaaaaaacpaaaaafecaabaaaaaaaaaaaakaabaaaadaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaamnmmameabjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadeaaaaaiicaabaaaabaaaaaackaabaaa
aaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
abaaaaaaegacbaaaaeaaaaaabaaaaaahecaabaaaafaaaaaaegbcbaaaaeaaaaaa
egacbaaaacaaaaaabaaaaaahbcaabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaafaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaa
dgaaaaaficaabaaaafaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaafaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaafaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaafaaaaaadiaaaaahpcaabaaaagaaaaaa
jgacbaaaafaaaaaaegakbaaaafaaaaaabbaaaaaibcaabaaaahaaaaaaegiocaaa
abaaaaaacjaaaaaaegaobaaaagaaaaaabbaaaaaiccaabaaaahaaaaaaegiocaaa
abaaaaaackaaaaaaegaobaaaagaaaaaabbaaaaaiecaabaaaahaaaaaaegiocaaa
abaaaaaaclaaaaaaegaobaaaagaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaahaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaafaaaaaa
bkaabaaaafaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaafaaaaaaakaabaaa
afaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaadjaaaaaiicaabaaa
abaaaaaadkiacaaaabaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaa
acaaaaaapgapbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaacaaaaaaegbcbaaaahaaaaaaegbcbaaa
ahaaaaaaefaaaaajpcaabaaaagaaaaaapgapbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaaa
agaaaaaadhaaaaajicaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaagaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaacpaaaaafhcaabaaaacaaaaaaegacbaaa
ahaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaamnmmamea
mnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
adaaaaaadcaaaaajocaabaaaagaaaaaaagajbaaaacaaaaaaagajbaaaabaaaaaa
kgakbaaaahaaaaaaaaaaaaajlcaabaaaahaaaaaajganbaiaebaaaaaaagaaaaaa
egiicaaaaaaaaaaaakaaaaaadcaaaaajncaabaaaadaaaaaakgakbaaaadaaaaaa
aganbaaaahaaaaaafgaobaaaagaaaaaadeaaaaaiccaabaaaadaaaaaabkaabaaa
adaaaaaackiacaaaaaaaaaaaahaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaa
aagabaaaagaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaahaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
ccaabaaaahaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaidcaabaaaaaaaaaaaegaabaiaebaaaaaaahaaaaaaigaabaaa
aiaaaaaadcaaaaakdcaabaaaaaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaa
aaaaaaaaegaabaaaahaaaaaadiaaaaahncaabaaaadaaaaaafgafbaaaaaaaaaaa
agaobaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
adaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaa
ahaaaaaadiaaaaaiocaabaaaagaaaaaaagaabaaaaaaaaaaaagijcaaaaaaaaaaa
aiaaaaaadiaaaaahlcaabaaaaaaaaaaapgapbaaaaaaaaaaaigambaaaadaaaaaa
diaaaaahlcaabaaaaaaaaaaaegambaaaaaaaaaaaegaibaaaaeaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaacaaaaaaegadbaaaaaaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
lcaabaaaaaaaaaaaegambaaaaaaaaaaapgapbaaaacaaaaaaegaibaiaebaaaaaa
abaaaaaadcaaaaajlcaabaaaaaaaaaaakgakbaaaahaaaaaaegambaaaaaaaaaaa
egaibaaaabaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaacaaaaaaafaaaaaa
dgaaaaagccaabaaaabaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaa
abaaaaaabkiacaaaacaaaaaaahaaaaaabacaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
jgahbaaaagaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaagaaaaaaegacbaaa
abaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaahlcaabaaaaaaaaaaaegambaaaaaaaaaaaegaibaaa
abaaaaaadgaaaaafbcaabaaaabaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaa
abaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaabaaaaaadkbabaaaaeaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegacbaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaa
afaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaadaaaaaafgifcaaaaaaaaaaa
alaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaahaaaaaaegacbaia
ebaaaaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegadbaaa
aaaaaaaaegacbaaaabaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
diaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaacplkoidocplkoido
cplkoidoaaaaaaaabjaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
"ps_3_0
; 127 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
def c24, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c25, 5.00000000, 2.20000005, 0.50000000, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
texld r0.yw, v0, s3
mad_pp r2.xy, r0.wyzw, c24.x, c24.y
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.z
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3_pp r1.w, r2, v2
dp3_pp r2.w, r2, v3
dp3_pp r5.x, r2, v1
dp3_pp r4.w, v5, v5
mov r5.y, r1.w
mov r5.z, r2.w
mov r5.w, c24.z
mov_pp r1.z, r2.w
mov_pp r1.x, r5
mov_pp r1.y, r1.w
dp4 r4.z, r5, c7
dp4 r4.y, r5, c6
dp4 r4.x, r5, c5
abs_pp r2.w, -c4
texld r7.z, v0, s0
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r1, r0
mul_pp r3.xyz, r1, r0.w
mad_pp r0.xyz, -r3, c24.x, r0
mul_pp r3, r5.xyzz, r5.yzzx
dp4 r6.z, r3, c10
dp4 r6.x, r3, c8
dp4 r6.y, r3, c9
add_pp r3.xyz, r4, r6
texld r4.xyz, r0, s4
texld r0, v0, s1
pow r6, r0.x, c25.y
mul_pp r0.x, r1.w, r1.w
mad_pp r1.w, r5.x, r5.x, -r0.x
mov r0.x, r6
mul r6.xyz, r1.w, c11
dp3_pp_sat r1.w, r2, v4
add_pp r3.xyz, r3, r6
cmp_pp r6.xyz, -r2.w, r3, c24.w
mul_pp r8.xyz, r6, c13.x
mul_pp r4.xyz, r4, c22.x
mul_pp r5.xyz, r0.x, r4
mad_pp r4.xyz, r7.z, r4, -r5
texld r6.xyz, v0, s2
cmp_pp r3.w, -r2, c24.z, r1
mad_pp r5.xyz, r4, c21.x, r5
mul_pp r4.xyz, r3.w, r5
cmp_pp r3.xyz, -r2.w, r5, r4
pow r5, r6.x, c25.y
mov r6.x, r5
pow r5, r6.z, c25.y
mov_pp r4.xyz, c12
mad_pp r2.w, r1, c25.z, c25.z
mul_pp r4.xyz, c24.x, r4
mul_pp r9.xyz, r2.w, r4
mad_pp r7.xyw, r9.xyzz, r3.w, r8.xyzz
pow r8, r6.y, c25.y
mov r6.y, r8
mov r6.z, r5
mul_pp r5.xyz, r6, r7.xyww
add_pp r9.xyz, r7.z, r5
add_pp r6.xyz, -r9, c19
rsq_pp r4.w, r4.w
mul_pp r8.xyz, r4.w, v5
dp3_pp r4.w, r8, r8
rsq_pp r4.w, r4.w
mul_pp r8.xyz, r4.w, r8
mad_pp r6.xyz, r0.z, r6, r9
dp3_pp_sat r7.x, r2, r8
mov_pp r7.y, c24.w
add_pp r0.z, -r7.x, c24
texld r9.xz, r7, s5
mul_pp r7.xyw, r2.xyzz, r2.w
pow_pp r2, r0.z, c25.x
mad_pp r2.yzw, r7.xxyw, c24.x, -v4.xxyz
dp3_pp r0.z, r2.yzww, r2.yzww
mov_pp r7.x, r2
rsq_pp r0.z, r0.z
mul_pp r2.xyz, r0.z, r2.yzww
add_pp r7.y, -r7.x, c24.z
mul_pp r0.z, r0.w, c17.x
dp3_pp r2.x, r8, r2
max_pp r0.w, r2.x, c24
pow_pp r2, r0.w, r0.z
add_pp r9.xy, r9.xzzw, -r7
mad_pp r0.zw, r9.xyxy, c23.x, r7.xyxy
mul_pp r6.xyz, r0.w, r6
mov_pp r0.w, r2.x
mul_pp r4.xyz, r4, r0.w
mul_pp r2.xyz, r1.w, r6
max_pp r0.x, r0, c18
mul_pp r4.xyz, r4, c20.x
mul_pp r4.xyz, r4, r0.x
max_pp r0.x, r0.y, c15
mul_pp r0.w, r0.x, r0.z
mul_pp r2.xyz, r4, r2
mad_pp r0.xyz, r3.w, r2, r5
mul_pp r0.w, r0, c14.x
mul_pp r2.xyz, r0.w, c16
dp3_pp_sat r0.w, r1, c1
mad_pp r0.xyz, r7.z, -r5, r0
mad_pp r0.xyz, r2, r0.w, r0
add_pp r2.xyz, r0, r3
pow r0, r2.x, c25.w
mov r2.x, r0
pow r1, r2.z, c25.w
pow r0, r2.y, c25.w
mov r2.z, r1
mov r2.y, r0
mov_pp oC0.xyz, r2
mov_pp oC0.w, c24
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 2
SetTexture 1 [_maskmap2] 2D 3
SetTexture 2 [_basetexture] 2D 0
SetTexture 3 [_normalmap] 2D 1
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_fresnelwarp] 2D 5
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 48 [_ambientscale]
Float 52 [_rimlightscale]
Float 56 [_rimlightblendtofull]
Vector 64 [_rimlightcolor] 3
Float 80 [_specularexponent]
Float 84 [_specularblendtofull]
Vector 96 [_specularcolor] 3
Float 108 [_specularscale]
Float 112 [_maskenvbymetalness]
Float 116 [_envmapintensity]
Float 120 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedhdhhfehgoifgapagohcpdcmidgneplepabaaaaaaniaoaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaanaaaaeaaaaaaagiadaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaa
fjaaaaaeegiocaaaacaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacakaaaaaadgaaaaafccaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaaaaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
aeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaaeaaaaaa
akaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
dcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaakgikcaaaaaaaaaaaahaaaaaaegaabaaaaaaaaaaaegaabaaa
aeaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaa
adaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahbcaabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaadaaaaaaegbcbaaa
adaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaabaaaaaa
cgaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaabaaaaaa
chaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaabaaaaaa
ciaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaafaaaaaajgacbaaaadaaaaaa
egakbaaaadaaaaaabbaaaaaibcaabaaaagaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaafaaaaaabbaaaaaiccaabaaaagaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaafaaaaaabbaaaaaiecaabaaaagaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaafaaaaaaaaaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaa
agaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaakecaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaackaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaabaaaaaacmaaaaaa
kgakbaaaaaaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaa
aeaaaaaaagiacaaaaaaaaaaaadaaaaaadjaaaaaiecaabaaaaaaaaaaadkiacaaa
abaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaamhcaabaaaaeaaaaaakgakbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaeaaaaaa
bacaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegbcbaaaafaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadp
aaaaaaajhcaabaaaafaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaahhcaabaaaagaaaaaapgapbaaaabaaaaaaegacbaaaafaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadcaaaaan
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegbcbaiaebaaaaaaafaaaaaadhaaaaajicaabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajhcaabaaaaeaaaaaa
egacbaaaagaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
agaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaacpaaaaaf
hcaabaaaagaaaaaaegacbaaaagaaaaaadiaaaaakhcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaamnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaa
agaaaaaaegacbaaaagaaaaaaefaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaajlcaabaaaahaaaaaaegaibaaa
agaaaaaaegaibaaaaeaaaaaakgakbaaaahaaaaaaaaaaaaajhcaabaaaaiaaaaaa
egadbaiaebaaaaaaahaaaaaaegiccaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
ajaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaj
lcaabaaaahaaaaaakgakbaaaajaaaaaaegaibaaaaiaaaaaaegambaaaahaaaaaa
diaaaaahlcaabaaaahaaaaaafgafbaaaaaaaaaaaegambaaaahaaaaaadiaaaaah
lcaabaaaahaaaaaapgapbaaaaaaaaaaaegambaaaahaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
ajaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaafaaaaaafgafbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaacpaaaaaf
ccaabaaaaaaaaaaaakaabaaaajaaaaaadeaaaaaiicaabaaaaaaaaaaabkaabaaa
ajaaaaaackiacaaaaaaaaaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaamnmmameabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaafaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegadbaaaahaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaafaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaeaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaiaebaaaaaaaeaaaaaadcaaaaaj
hcaabaaaabaaaaaakgakbaaaahaaaaaaegacbaaaabaaaaaaegacbaaaaeaaaaaa
dgaaaaagbcaabaaaaeaaaaaabkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaa
aeaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaaaeaaaaaabkiacaaa
acaaaaaaahaaaaaabacaaaahccaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
adaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaafbcaabaaaacaaaaaadkbabaaaacaaaaaadgaaaaaf
ccaabaaaacaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaa
aeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
aaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
hcaabaaaacaaaaaaegacbaaaadaaaaaafgafbaiaebaaaaaaaaaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegacbaaaacaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaafgifcaaa
aaaaaaaaahaaaaaadiaaaaahlcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaakgakbaaaahaaaaaa
egadbaiaebaaaaaaaaaaaaaadcaaaaaklcaabaaaaaaaaaaaagiacaaaaaaaaaaa
ahaaaaaaegaibaaaacaaaaaaegambaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegadbaaaaaaaaaaadhaaaaajhcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaaegadbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaacplkoido
cplkoidocplkoidoaaaaaaaabjaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
SetTexture 7 [_fresnelwarp] 2D 7
"ps_3_0
; 143 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c24, 2.20000005, 2.00000000, -1.00000000, 1.00000000
def c25, 0.50000000, 0.00000000, 1.00000000, 5.00000000
def c26, 0.45454544, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
texld r0.yw, v0, s3
mad_pp r3.xy, r0.wyzw, c24.y, c24.z
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r1.w, r3, v2
dp3_pp r3.w, r3, v3
dp3_pp r4.x, r3, v1
mov r2.x, r4
mov r2.y, r1.w
mov r2.z, r3.w
mov r2.w, c24
mul_pp r0, r2.xyzz, r2.yzzx
texld r11.xyz, v0, s2
dp4 r1.z, r2, c7
dp4 r1.y, r2, c6
dp4 r1.x, r2, c5
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul_pp r0.x, r1.w, r1.w
mad_pp r0.w, r4.x, r4.x, -r0.x
mov_pp r4.y, r1.w
mov_pp r4.z, r3.w
add_pp r1.xyz, r1, r2
mul r5.xyz, r0.w, c11
add_pp r1.xyz, r1, r5
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r1.w, r4, r0
mul_pp r2.xyz, r4, r1.w
mad_pp r0.xyz, -r2, c24.y, r0
texld r5.xyz, r0, s4
texld r2, v0, s1
pow r0, r2.x, c24.x
mov r2.x, r0
mul_pp r5.xyz, r5, c22.x
dp3_pp r0.y, v4, v4
rsq_pp r0.x, r0.y
mul_pp r6.xyz, r0.x, v4
dp3_pp r0.x, r6, r6
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, r6
dp3_pp_sat r6.w, r3, r6
dp3 r0.x, v6, v6
mul_pp r7.xyz, r2.x, r5
texld r0.z, v0, s0
mad_pp r5.xyz, r0.z, r5, -r7
mad_pp r5.xyz, r5, c21.x, r7
rcp r0.y, v6.w
mad r7.xy, v6, r0.y, c25.x
texld r0.w, r7, s5
cmp r0.y, -v6.z, c25, c25.z
mul_pp r0.y, r0, r0.w
abs r0.w, -c4
cmp_pp r1.xyz, -r0.w, r1, c25.y
texld r0.x, r0.x, s6
mul_pp r3.w, r0.y, r0.x
mul_pp r0.x, r6.w, r3.w
cmp_pp r4.w, -r0, r3, r0.x
mul_pp r7.xyz, r4.w, r5
mul_pp r8.xyz, r1, c13.x
dp3_pp r0.x, v5, v5
cmp_pp r10.xyz, -r0.w, r5, r7
mov_pp r1.xyz, c12
mul_pp r7.xyz, c24.y, r1
mad_pp r7.w, r6, c25.x, c25.x
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v5
mul_pp r5.xyz, r7.w, r7
mad_pp r8.xyz, r5, r4.w, r8
pow r5, r11.y, c24.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r9.xyz, r0.x, r1
dp3_pp_sat r0.x, r3, r9
pow r1, r11.x, c24.x
mov r11.x, r1
pow r1, r11.z, c24.x
mul_pp r3.xyz, r7.w, r3
mad_pp r6.xyz, r3, c24.y, -r6
add_pp r0.y, -r0.x, c24.w
mov r11.z, r1
pow_pp r1, r0.y, c25.w
mov_pp r12.x, r1
mov r11.y, r5
mul_pp r5.xyz, r11, r8
add_pp r8.xyz, r0.z, r5
mov_pp r0.y, c25
texld r1.xz, r0, s7
add_pp r12.y, -r12.x, c24.w
add_pp r0.xy, r1.xzzw, -r12
add_pp r11.xyz, -r8, c19
mad_pp r0.xy, r0, c23.x, r12
mad_pp r1.xyz, r2.z, r11, r8
mul_pp r1.xyz, r1, r0.y
mul_pp r3.xyz, r6.w, r1
max_pp r1.x, r2.y, c15
mul_pp r0.x, r0, r1
dp3_pp r0.y, r6, r6
rsq_pp r0.y, r0.y
mul_pp r1.xyz, r0.y, r6
mul_pp r2.y, r0.x, c14.x
dp3_pp r0.x, r1, r9
mul_pp r0.y, r2.w, c17.x
max_pp r0.x, r0, c25.y
pow_pp r1, r0.x, r0.y
dp3_pp_sat r0.y, r4, c1
mov_pp r0.x, r1
mul_pp r6.xyz, r2.y, c16
mul_pp r4.xyz, r7, r0.x
max_pp r0.x, r2, c18
mul_pp r2.xyz, r4, c20.x
mul_pp r2.xyz, r2, r0.x
mul_pp r2.xyz, r2, r3
mul_pp r1.xyz, r6, r0.y
mad_pp r2.xyz, r4.w, r2, r5
mul_pp r3.xyz, r3.w, r1
cmp_pp r1.xyz, -r0.w, r1, r3
mad_pp r0.xyz, r0.z, -r5, r2
add_pp r0.xyz, r0, r1
add_pp r2.xyz, r0, r10
pow r0, r2.x, c26.x
mov r2.x, r0
pow r0, r2.z, c26.x
pow r1, r2.y, c26.x
mov r2.z, r0
mov r2.y, r1
mov_pp oC0.xyz, r2
mov_pp oC0.w, c25.y
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 4
SetTexture 1 [_maskmap2] 2D 5
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 6
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_LightTextureB0] 2D 1
SetTexture 7 [_fresnelwarp] 2D 7
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedjicmanjfhgemimaooobfpolnfpahabmaabaaaaaaaibbaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcliapaaaaeaaaaaaaooadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadpcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacalaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
aaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aeaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaafaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaaaaaaaaaaahaaaaaadjaaaaai
icaabaaaaaaaaaaadkiacaaaabaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaam
hcaabaaaadaaaaaapgapbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaadaaaaaaaoaaaaahdcaabaaaaeaaaaaaegbabaaaahaaaaaa
pgbpbaaaahaaaaaaaaaaaaakdcaabaaaaeaaaaaaegaabaaaaeaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
aeaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaabaaaaaa
abeaaaaaaaaaaaaackbabaaaahaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaaeaaaaaa
dkaabaaaabaaaaaabaaaaaahicaabaaaacaaaaaaegbcbaaaahaaaaaaegbcbaaa
ahaaaaaaefaaaaajpcaabaaaaeaaaaaapgapbaaaacaaaaaaeghobaaaagaaaaaa
aagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaa
aeaaaaaabaaaaaahicaabaaaacaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaa
pgapbaaaacaaaaaaegbcbaaaafaaaaaabacaaaahicaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaabaaaaaa
dkaabaaaacaaaaaadhaaaaajicaabaaaadaaaaaadkaabaaaaaaaaaaadkaabaaa
adaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaeaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajhcaabaaaafaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
pgapbaaaaeaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaa
acaaaaaapgapbaaaaeaaaaaadcaaaaanhcaabaaaaeaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaiaebaaaaaaaeaaaaaa
dcaaaaajhcaabaaaadaaaaaaegacbaaaagaaaaaapgapbaaaadaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaeaaaaaadcaaaaajlcaabaaaagaaaaaaegaibaaaaaaaaaaaegaibaaa
adaaaaaakgakbaaaagaaaaaaaaaaaaajhcaabaaaahaaaaaaegadbaiaebaaaaaa
agaaaaaaegiccaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaaaiaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaadcaaaaajlcaabaaaagaaaaaa
kgakbaaaaiaaaaaaegaibaaaahaaaaaaegambaaaagaaaaaabaaaaaahicaabaaa
aeaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaaficaabaaaaeaaaaaa
dkaabaaaaeaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaaeaaaaaaegbcbaaa
agaaaaaabacaaaahbcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaahaaaaaa
dgaaaaafccaabaaaacaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaajaaaaaa
egaabaaaacaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaaaaaaaaaibcaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaa
acaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaakaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaakaaaaaaakaabaiaebaaaaaa
acaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaidcaabaaaacaaaaaa
igaabaaaajaaaaaaegaabaiaebaaaaaaakaaaaaadcaaaaakdcaabaaaacaaaaaa
kgikcaaaaaaaaaaaalaaaaaaegaabaaaacaaaaaaegaabaaaakaaaaaadiaaaaah
lcaabaaaagaaaaaafgafbaaaacaaaaaaegambaaaagaaaaaadiaaaaahocaabaaa
acaaaaaapgapbaaaacaaaaaaaganbaaaagaaaaaabaaaaaahicaabaaaaeaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaaeaaaaaadkaabaaa
aeaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaa
baaaaaahbcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaahaaaaaadeaaaaah
bcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aeaaaaaaakaabaaaaeaaaaaadiaaaaaiccaabaaaaeaaaaaadkaabaaaaiaaaaaa
akiacaaaaaaaaaaaajaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaaaeaaaaaa
bkaabaaaaeaaaaaabjaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaaegacbaaaafaaaaaaagaabaaaaeaaaaaadiaaaaaihcaabaaa
aeaaaaaaegacbaaaaeaaaaaapgipcaaaaaaaaaaaakaaaaaacpaaaaaficaabaaa
aeaaaaaaakaabaaaaiaaaaaadeaaaaaibcaabaaaafaaaaaabkaabaaaaiaaaaaa
ckiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaafaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaabkiacaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaafaaaaaaagaabaaaacaaaaaaegiccaaa
aaaaaaaaaiaaaaaadiaaaaahbcaabaaaacaaaaaadkaabaaaaeaaaaaaabeaaaaa
mnmmameabjaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadeaaaaaiicaabaaa
aeaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
aeaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaahocaabaaaacaaaaaa
fgaobaaaacaaaaaaagajbaaaaeaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaa
adaaaaaajgahbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaadcaaaaakocaabaaaacaaaaaafgaobaaa
acaaaaaapgapbaaaadaaaaaaagajbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaakgakbaaaagaaaaaajgahbaaaacaaaaaaegacbaaaaaaaaaaadgaaaaag
bcaabaaaadaaaaaabkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaaadaaaaaa
bkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaacaaaaaa
ahaaaaaabacaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
diaaaaahocaabaaaacaaaaaafgafbaaaacaaaaaaagajbaaaafaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaabaaaaaajgahbaaaacaaaaaadhaaaaajocaabaaa
acaaaaaapgapbaaaaaaaaaaaagajbaaaadaaaaaafgaobaaaacaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaaacaaaaaadgaaaaafbcaabaaa
adaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaadaaaaaadkbabaaaadaaaaaa
dgaaaaafecaabaaaadaaaaaadkbabaaaaeaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaagaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaafgifcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaakgakbaaaagaaaaaaegacbaiaebaaaaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaadaaaaaaegacbaaaabaaaaaa
dhaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
cpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaacplkoidocplkoidocplkoidoaaaaaaaabjaaaaaf
hccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTextureB0] 2D 5
SetTexture 6 [_LightTexture0] CUBE 6
SetTexture 7 [_fresnelwarp] 2D 7
"ps_3_0
; 139 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_cube s6
dcl_2d s7
def c24, 2.20000005, 2.00000000, -1.00000000, 1.00000000
def c25, 0.50000000, 0.00000000, 5.00000000, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xyz
texld r0.yw, v0, s3
mad_pp r3.xy, r0.wyzw, c24.y, c24.z
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.w
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r1.w, r3, v2
dp3_pp r3.w, r3, v3
dp3_pp r4.x, r3, v1
mov r2.x, r4
mov r2.y, r1.w
mov r2.z, r3.w
mov r2.w, c24
mul_pp r0, r2.xyzz, r2.yzzx
texld r11.xyz, v0, s2
dp4 r1.z, r2, c7
dp4 r1.y, r2, c6
dp4 r1.x, r2, c5
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mul_pp r0.w, r1, r1
mov_pp r4.y, r1.w
mov_pp r4.z, r3.w
add_pp r1.xyz, r1, r2
mad_pp r0.w, r4.x, r4.x, -r0
mul r2.xyz, r0.w, c11
add_pp r1.xyz, r1, r2
texld r2, v0, s1
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r1.w, r4, r0
mul_pp r5.xyz, r4, r1.w
mad_pp r0.xyz, -r5, c24.y, r0
texld r0.xyz, r0, s4
mul_pp r5.xyz, r0, c22.x
pow r0, r2.x, c24.x
dp3_pp r0.y, v4, v4
mov r4.w, r0.x
rsq_pp r0.y, r0.y
mul_pp r6.xyz, r0.y, v4
dp3_pp r0.x, r6, r6
rsq_pp r0.x, r0.x
mul_pp r6.xyz, r0.x, r6
dp3_pp_sat r6.w, r3, r6
dp3 r0.x, v6, v6
mul_pp r7.xyz, r4.w, r5
texld r0.z, v0, s0
mad_pp r5.xyz, r0.z, r5, -r7
mad_pp r5.xyz, r5, c21.x, r7
texld r0.w, v6, s6
texld r0.x, r0.x, s5
mul r2.x, r0, r0.w
abs r0.w, -c4
mul_pp r0.x, r6.w, r2
cmp_pp r3.w, -r0, r2.x, r0.x
mul_pp r7.xyz, r3.w, r5
cmp_pp r1.xyz, -r0.w, r1, c25.y
mul_pp r8.xyz, r1, c13.x
dp3_pp r0.x, v5, v5
cmp_pp r10.xyz, -r0.w, r5, r7
mov_pp r1.xyz, c12
mul_pp r7.xyz, c24.y, r1
mad_pp r7.w, r6, c25.x, c25.x
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v5
mul_pp r5.xyz, r7.w, r7
mad_pp r8.xyz, r5, r3.w, r8
pow r5, r11.y, c24.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r9.xyz, r0.x, r1
dp3_pp_sat r0.x, r3, r9
pow r1, r11.x, c24.x
mov r11.x, r1
pow r1, r11.z, c24.x
mul_pp r3.xyz, r7.w, r3
mad_pp r6.xyz, r3, c24.y, -r6
add_pp r0.y, -r0.x, c24.w
mov r11.z, r1
pow_pp r1, r0.y, c25.z
mov_pp r12.x, r1
mov r11.y, r5
mul_pp r5.xyz, r11, r8
add_pp r8.xyz, r0.z, r5
mov_pp r0.y, c25
texld r1.xz, r0, s7
add_pp r12.y, -r12.x, c24.w
add_pp r0.xy, r1.xzzw, -r12
add_pp r11.xyz, -r8, c19
mad_pp r0.xy, r0, c23.x, r12
mad_pp r1.xyz, r2.z, r11, r8
mul_pp r1.xyz, r1, r0.y
mul_pp r3.xyz, r6.w, r1
max_pp r1.x, r2.y, c15
mul_pp r0.x, r0, r1
dp3_pp r0.y, r6, r6
rsq_pp r0.y, r0.y
mul_pp r1.xyz, r0.y, r6
mul_pp r2.y, r0.x, c14.x
dp3_pp r0.x, r1, r9
mul_pp r0.y, r2.w, c17.x
max_pp r0.x, r0, c25.y
pow_pp r1, r0.x, r0.y
dp3_pp_sat r0.y, r4, c1
mov_pp r0.x, r1
mul_pp r4.xyz, r7, r0.x
mul_pp r6.xyz, r2.y, c16
mul_pp r1.xyz, r6, r0.y
mul_pp r2.xyz, r2.x, r1
cmp_pp r1.xyz, -r0.w, r1, r2
max_pp r0.x, r4.w, c18
mul_pp r4.xyz, r4, c20.x
mul_pp r4.xyz, r4, r0.x
mul_pp r3.xyz, r4, r3
mad_pp r3.xyz, r3.w, r3, r5
mad_pp r0.xyz, r0.z, -r5, r3
add_pp r0.xyz, r0, r1
add_pp r2.xyz, r0, r10
pow r0, r2.x, c25.w
mov r2.x, r0
pow r0, r2.z, c25.w
pow r1, r2.y, c25.w
mov r2.z, r0
mov r2.y, r1
mov_pp oC0.xyz, r2
mov_pp oC0.w, c25.y
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 4
SetTexture 1 [_maskmap2] 2D 5
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 6
SetTexture 5 [_LightTextureB0] 2D 1
SetTexture 6 [_LightTexture0] CUBE 0
SetTexture 7 [_fresnelwarp] 2D 7
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefieceddlpnicfbdepbkcafkmocaeaamaaklhinabaaaaaahabaaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccaapaaaaeaaaaaaamiadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaad
aagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafidaaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaafidaaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaa
ahaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagcbaaaadhcbabaaaahaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacalaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
aaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
aeaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaafaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaaiccaabaaaafaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaaiecaabaaaafaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaaaaaaaaaaahaaaaaadjaaaaai
icaabaaaaaaaaaaadkiacaaaabaaaaaaaaaaaaaaabeaaaaaaaaaaaaadhaaaaam
hcaabaaaadaaaaaapgapbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaaeaaaaaapgapbaaaabaaaaaaegbcbaaaafaaaaaabacaaaahicaabaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaajicaabaaaacaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajhcaabaaa
afaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaaafaaaaaadiaaaaahhcaabaaa
ahaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaadcaaaaanhcaabaaaaeaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaia
ebaaaaaaaeaaaaaabaaaaaahicaabaaaacaaaaaaegbcbaaaahaaaaaaegbcbaaa
ahaaaaaaefaaaaajpcaabaaaahaaaaaapgapbaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaaiaaaaaaegbcbaaaahaaaaaaeghobaaa
agaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaaahaaaaaa
dkaabaaaaiaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaabaaaaaadkaabaaa
acaaaaaadhaaaaajicaabaaaadaaaaaadkaabaaaaaaaaaaadkaabaaaadaaaaaa
dkaabaaaacaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaagaaaaaapgapbaaa
adaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaagaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaajlcaabaaaagaaaaaaegaibaaa
aaaaaaaaegaibaaaadaaaaaakgakbaaaagaaaaaaaaaaaaajhcaabaaaahaaaaaa
egadbaiaebaaaaaaagaaaaaaegiccaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaa
aiaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaadcaaaaaj
lcaabaaaagaaaaaakgakbaaaaiaaaaaaegaibaaaahaaaaaaegambaaaagaaaaaa
baaaaaahicaabaaaaeaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaeeaaaaaf
icaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaa
aeaaaaaaegbcbaaaagaaaaaabacaaaahbcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaahaaaaaadgaaaaafccaabaaaacaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaajaaaaaaegaabaaaacaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
akaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaakccaabaaaakaaaaaa
akaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaai
dcaabaaaacaaaaaaigaabaaaajaaaaaaegaabaiaebaaaaaaakaaaaaadcaaaaak
dcaabaaaacaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaacaaaaaaegaabaaa
akaaaaaadiaaaaahlcaabaaaagaaaaaafgafbaaaacaaaaaaegambaaaagaaaaaa
diaaaaahlcaabaaaagaaaaaapgapbaaaabaaaaaaegambaaaagaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaapgapbaaaabaaaaaa
egacbaaaaeaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
ahaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaaiccaabaaaacaaaaaa
dkaabaaaaiaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaabjaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaafaaaaaapgapbaaaabaaaaaa
diaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaapgipcaaaaaaaaaaaakaaaaaa
cpaaaaaficaabaaaabaaaaaaakaabaaaaiaaaaaadeaaaaaiccaabaaaacaaaaaa
bkaabaaaaiaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaaibcaabaaaacaaaaaaakaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaa
acaaaaaaegiccaaaaaaaaaaaaiaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaamnmmameabjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
deaaaaaiicaabaaaaeaaaaaadkaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaa
diaaaaahhcaabaaaaeaaaaaapgapbaaaaeaaaaaaegacbaaaaeaaaaaadiaaaaah
hcaabaaaaeaaaaaaegadbaaaagaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaa
afaaaaaapgapbaaaadaaaaaaegacbaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadcaaaaakhcaabaaa
adaaaaaaegacbaaaaeaaaaaapgapbaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaakgakbaaaagaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaadgaaaaagbcaabaaaadaaaaaabkiacaaaacaaaaaaafaaaaaadgaaaaag
ccaabaaaadaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaaadaaaaaa
bkiacaaaacaaaaaaahaaaaaabacaaaahbcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaagaabaaa
adaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
dhaaaaajhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dgaaaaafbcaabaaaacaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaacaaaaaa
dkbabaaaadaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaaeaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaiaebaaaaaaacaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegacbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaagaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaaalaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaagaaaaaaegacbaiaebaaaaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaagiacaaaaaaaaaaaalaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaadaaaaaa
egacbaaaabaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaacplkoidocplkoidocplkoido
aaaaaaaabjaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "_GAMMA_SPACE" }
Matrix 0 [unity_MatrixV]
Vector 4 [_WorldSpaceLightPos0]
Vector 5 [unity_SHAr]
Vector 6 [unity_SHAg]
Vector 7 [unity_SHAb]
Vector 8 [unity_SHBr]
Vector 9 [unity_SHBg]
Vector 10 [unity_SHBb]
Vector 11 [unity_SHC]
Vector 12 [_LightColor0]
Float 13 [_ambientscale]
Float 14 [_rimlightscale]
Float 15 [_rimlightblendtofull]
Vector 16 [_rimlightcolor]
Float 17 [_specularexponent]
Float 18 [_specularblendtofull]
Vector 19 [_specularcolor]
Float 20 [_specularscale]
Float 21 [_maskenvbymetalness]
Float 22 [_envmapintensity]
Float 23 [_fresnelwarpblendtonone]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_maskmap2] 2D 1
SetTexture 2 [_basetexture] 2D 2
SetTexture 3 [_normalmap] 2D 3
SetTexture 4 [_envmap] CUBE 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_fresnelwarp] 2D 6
"ps_3_0
; 131 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
dcl_2d s5
dcl_2d s6
def c24, 2.20000005, 2.00000000, -1.00000000, 1.00000000
def c25, 0.50000000, 0.00000000, 5.00000000, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6.xy
texld r0.yw, v0, s3
mad_pp r6.xy, r0.wyzw, c24.y, c24.z
mul_pp r0.xy, r6, r6
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c24.w
rsq_pp r0.x, r0.x
rcp_pp r6.z, r0.x
dp3_pp r4.w, r6, v2
dp3_pp r3.w, r6, v3
texld r2, v0, s1
dp3_pp r5.x, r6, v1
mov_pp r5.y, r4.w
mov_pp r5.z, r3.w
abs_pp r5.w, -c4
mov r1.w, c24
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r5, r0
mul_pp r1.xyz, r5, r0.w
mad_pp r1.xyz, -r1, c24.y, r0
pow r0, r2.x, c24.x
texld r1.xyz, r1, s4
texld r0.w, v6, s5
dp3_pp_sat r2.x, r6, v4
mov r7.w, r0.x
mul_pp r0.x, r2, r0.w
cmp_pp r6.w, -r5, r0, r0.x
mul_pp r1.xyz, r1, c22.x
mul_pp r0.x, r4.w, r4.w
mul_pp r3.xyz, r7.w, r1
texld r0.z, v0, s0
mad_pp r1.xyz, r0.z, r1, -r3
mad_pp r7.xyz, r1, c21.x, r3
mov r1.y, r4.w
mov r1.z, r3.w
mov r1.x, r5
mul_pp r3, r1.xyzz, r1.yzzx
dp4 r8.z, r1, c7
dp4 r8.y, r1, c6
dp4 r8.x, r1, c5
mul_pp r4.xyz, r6.w, r7
dp4 r1.z, r3, c10
dp4 r1.y, r3, c9
dp4 r1.x, r3, c8
mad_pp r0.x, r5, r5, -r0
mul r3.xyz, r0.x, c11
add_pp r1.xyz, r8, r1
add_pp r1.xyz, r1, r3
dp3_pp r0.x, v5, v5
cmp_pp r8.xyz, -r5.w, r7, r4
cmp_pp r1.xyz, -r5.w, r1, c25.y
mov_pp r3.xyz, c12
mul_pp r4.xyz, r1, c13.x
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, v5
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r9.xyz, r0.x, r1
dp3_pp_sat r0.x, r6, r9
mul_pp r7.xyz, c24.y, r3
mad_pp r3.w, r2.x, c25.x, c25.x
mul_pp r3.xyz, r3.w, r7
mad_pp r10.xyz, r3, r6.w, r4
texld r3.xyz, v0, s2
pow r1, r3.x, c24.x
pow r4, r3.z, c24.x
mov r3.x, r1
pow r1, r3.y, c24.x
add_pp r0.y, -r0.x, c24.w
mov r3.y, r1
pow_pp r1, r0.y, c25.z
mov_pp r1.y, r1.x
mov r3.z, r4
mul_pp r3.xyz, r3, r10
add_pp r4.xyz, r0.z, r3
mov_pp r0.y, c25
add_pp r10.xyz, -r4, c19
add_pp r1.w, -r1.y, c24
texld r1.xz, r0, s6
add_pp r0.xy, r1.xzzw, -r1.ywzw
mad_pp r0.xy, r0, c23.x, r1.ywzw
max_pp r1.w, r2.y, c15.x
mad_pp r4.xyz, r2.z, r10, r4
mul_pp r4.xyz, r4, r0.y
mul_pp r1.xyz, r3.w, r6
mad_pp r1.xyz, r1, c24.y, -v4
dp3_pp r0.y, r1, r1
rsq_pp r0.y, r0.y
mul_pp r1.xyz, r0.y, r1
mul_pp r0.x, r0, r1.w
mul_pp r4.xyz, r2.x, r4
mul_pp r2.x, r0, c14
dp3_pp r0.x, r1, r9
mul_pp r0.y, r2.w, c17.x
max_pp r0.x, r0, c25.y
pow_pp r1, r0.x, r0.y
mov_pp r0.x, r1
mul_pp r2.xyz, r2.x, c16
dp3_pp_sat r0.y, r5, c1
mul_pp r1.xyz, r2, r0.y
mul_pp r2.xyz, r7, r0.x
max_pp r0.x, r7.w, c18
mul_pp r2.xyz, r2, c20.x
mul_pp r2.xyz, r2, r0.x
mul_pp r2.xyz, r2, r4
mul_pp r4.xyz, r0.w, r1
mad_pp r2.xyz, r6.w, r2, r3
mad_pp r0.xyz, r0.z, -r3, r2
cmp_pp r1.xyz, -r5.w, r1, r4
add_pp r0.xyz, r0, r1
add_pp r2.xyz, r0, r8
pow r0, r2.x, c25.w
mov r2.x, r0
pow r0, r2.z, c25.w
pow r1, r2.y, c25.w
mov r2.z, r0
mov r2.y, r1
mov_pp oC0.xyz, r2
mov_pp oC0.w, c25.y
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 3
SetTexture 1 [_maskmap2] 2D 4
SetTexture 2 [_basetexture] 2D 1
SetTexture 3 [_normalmap] 2D 2
SetTexture 4 [_envmap] CUBE 5
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_fresnelwarp] 2D 6
ConstBuffer "$Globals" 240
Vector 16 [_LightColor0]
Float 112 [_ambientscale]
Float 116 [_rimlightscale]
Float 120 [_rimlightblendtofull]
Vector 128 [_rimlightcolor] 3
Float 144 [_specularexponent]
Float 148 [_specularblendtofull]
Vector 160 [_specularcolor] 3
Float 172 [_specularscale]
Float 176 [_maskenvbymetalness]
Float 180 [_envmapintensity]
Float 184 [_fresnelwarpblendtonone]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerFrame" 208
Matrix 80 [unity_MatrixV]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerFrame" 2
"ps_4_0
eefiecedaenpcneebhphmoocndngnndkkppglplmabaaaaaakmapaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaaneaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfmaoaaaaeaaaaaaajhadaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacakaaaaaadgaaaaafccaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaa
agaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahecaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaaaaaaaaa
bacaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaa
aeaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakccaabaaaaeaaaaaa
akaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
dcaabaaaaaaaaaaaigaabaaaadaaaaaaegaabaiaebaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaakgikcaaaaaaaaaaaalaaaaaaegaabaaaaaaaaaaaegaabaaa
aeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaacpaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadiaaaaak
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaamnmmameamnmmameamnmmamea
aaaaaaaabjaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaadgaaaaaficaabaaa
aeaaaaaaabeaaaaaaaaaiadpbaaaaaahecaabaaaaeaaaaaaegbcbaaaaeaaaaaa
egacbaaaacaaaaaabaaaaaahbcaabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaaeaaaaaaegbcbaaaadaaaaaaegacbaaaacaaaaaa
bbaaaaaibcaabaaaafaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaeaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaeaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaeaaaaaa
diaaaaahpcaabaaaagaaaaaajgacbaaaaeaaaaaaegakbaaaaeaaaaaabbaaaaai
bcaabaaaahaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaagaaaaaabbaaaaai
ccaabaaaahaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaagaaaaaabbaaaaai
ecaabaaaahaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaagaaaaaaaaaaaaah
hcaabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaahaaaaaadiaaaaahecaabaaa
aaaaaaaabkaabaaaaeaaaaaabkaabaaaaeaaaaaadcaaaaakecaabaaaaaaaaaaa
akaabaaaaeaaaaaaakaabaaaaeaaaaaackaabaiaebaaaaaaaaaaaaaadcaaaaak
hcaabaaaafaaaaaaegiccaaaabaaaaaacmaaaaaakgakbaaaaaaaaaaaegacbaaa
afaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaaagiacaaaaaaaaaaa
ahaaaaaadjaaaaaiecaabaaaaaaaaaaadkiacaaaabaaaaaaaaaaaaaaabeaaaaa
aaaaaaaadhaaaaamhcaabaaaafaaaaaakgakbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaaaafaaaaaabacaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpaaaaaaajhcaabaaaagaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaa
ahaaaaaapgapbaaaabaaaaaaegacbaaaagaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaabaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegbcbaiaebaaaaaa
afaaaaaaefaaaaajpcaabaaaaiaaaaaaogbkbaaaabaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aiaaaaaadhaaaaajicaabaaaabaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaiaaaaaadcaaaaajhcaabaaaafaaaaaaegacbaaaahaaaaaapgapbaaa
abaaaaaaegacbaaaafaaaaaaefaaaaajpcaabaaaahaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaadaaaaaadcaaaaajlcaabaaaahaaaaaaegaibaaa
adaaaaaaegaibaaaafaaaaaakgakbaaaahaaaaaaaaaaaaajhcaabaaaaiaaaaaa
egadbaiaebaaaaaaahaaaaaaegiccaaaaaaaaaaaakaaaaaaefaaaaajpcaabaaa
ajaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadcaaaaaj
lcaabaaaahaaaaaakgakbaaaajaaaaaaegaibaaaaiaaaaaaegambaaaahaaaaaa
diaaaaahlcaabaaaahaaaaaafgafbaaaaaaaaaaaegambaaaahaaaaaadiaaaaah
lcaabaaaahaaaaaapgapbaaaaaaaaaaaegambaaaahaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
ajaaaaaaakiacaaaaaaaaaaaajaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaagaaaaaafgafbaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaakaaaaaacpaaaaaf
ccaabaaaaaaaaaaaakaabaaaajaaaaaadeaaaaaiicaabaaaaaaaaaaabkaabaaa
ajaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkiacaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaacaaaaaaagaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaamnmmameabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaai
ccaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaajaaaaaadiaaaaah
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegadbaaaahaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaagaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaafaaaaaaegacbaaaagaaaaaadcaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaakgakbaaaahaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaagbcaabaaaadaaaaaabkiacaaaacaaaaaaafaaaaaadgaaaaagccaabaaa
adaaaaaabkiacaaaacaaaaaaagaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaa
acaaaaaaahaaaaaabacaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaiaaaaaaegacbaaaacaaaaaadhaaaaaj
hcaabaaaacaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaf
bcaabaaaacaaaaaadkbabaaaacaaaaaadgaaaaafccaabaaaacaaaaaadkbabaaa
adaaaaaadgaaaaafecaabaaaacaaaaaadkbabaaaaeaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaaaaaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaa
aeaaaaaafgafbaiaebaaaaaaaaaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegacbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaafaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaaalaaaaaadiaaaaah
lcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaakgakbaaaahaaaaaaegadbaiaebaaaaaaaaaaaaaa
dcaaaaaklcaabaaaaaaaaaaaagiacaaaaaaaaaaaalaaaaaaegaibaaaacaaaaaa
egambaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegadbaaa
aaaaaaaadhaaaaajhcaabaaaaaaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
egadbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaacplkoidocplkoidocplkoidoaaaaaaaa
bjaaaaafhccabaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Geometry" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform samplerCube _envmap;
uniform sampler2D _normalmap;
void main ()
{
  vec4 res_1;
  vec3 worldN_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1.xyz, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2.xyz, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3.xyz, normal_4);
  vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normal_4;
  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normal_4;
  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_7);
  vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = normal_4;
  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_8);
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = pow (textureCube (_envmap, (tmpvar_3 - (2.0 * (dot (tmpvar_5, tmpvar_3) * tmpvar_5)))).xyz, vec3(2.2, 2.2, 2.2)).x;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [_basetexture_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c13.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c13.w
mad o1.xy, v3, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 160 [_basetexture_ST]
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
eefiecedgapaldakainoodihpdekpemffpcilhbkabaaaaaabeahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiafaaaaeaaaabaa
foabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaal
lcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaa
kgakbaiaebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaaakiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaa
adaaaaaabkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaa
ckiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaacaaaaaa
anaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaa
aaaaaaaapgipcaaaacaaaaaabeaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
attribute vec4 TANGENT;
uniform vec4 _basetexture_ST;
uniform vec4 unity_Scale;
uniform mat4 _World2Object;
uniform mat4 _Object2World;

uniform vec3 _WorldSpaceCameraPos;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _WorldSpaceCameraPos;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (gl_Vertex.xyz - ((_World2Object * tmpvar_1).xyz * unity_Scale.w)));
  vec3 tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_4 = TANGENT.xyz;
  tmpvar_5 = (((gl_Normal.yzx * TANGENT.zxy) - (gl_Normal.zxy * TANGENT.yzx)) * TANGENT.w);
  mat3 tmpvar_6;
  tmpvar_6[0].x = tmpvar_4.x;
  tmpvar_6[0].y = tmpvar_5.x;
  tmpvar_6[0].z = gl_Normal.x;
  tmpvar_6[1].x = tmpvar_4.y;
  tmpvar_6[1].y = tmpvar_5.y;
  tmpvar_6[1].z = gl_Normal.y;
  tmpvar_6[2].x = tmpvar_4.z;
  tmpvar_6[2].y = tmpvar_5.z;
  tmpvar_6[2].z = gl_Normal.z;
  vec4 v_7;
  v_7.x = _Object2World[0].x;
  v_7.y = _Object2World[1].x;
  v_7.z = _Object2World[2].x;
  v_7.w = _Object2World[3].x;
  vec4 tmpvar_8;
  tmpvar_8.xyz = (tmpvar_6 * v_7.xyz);
  tmpvar_8.w = tmpvar_3.x;
  vec4 v_9;
  v_9.x = _Object2World[0].y;
  v_9.y = _Object2World[1].y;
  v_9.z = _Object2World[2].y;
  v_9.w = _Object2World[3].y;
  vec4 tmpvar_10;
  tmpvar_10.xyz = (tmpvar_6 * v_9.xyz);
  tmpvar_10.w = tmpvar_3.y;
  vec4 v_11;
  v_11.x = _Object2World[0].z;
  v_11.y = _Object2World[1].z;
  v_11.z = _Object2World[2].z;
  v_11.w = _Object2World[3].z;
  vec4 tmpvar_12;
  tmpvar_12.xyz = (tmpvar_6 * v_11.xyz);
  tmpvar_12.w = tmpvar_3.z;
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = (tmpvar_8 * unity_Scale.w);
  xlv_TEXCOORD2 = (tmpvar_10 * unity_Scale.w);
  xlv_TEXCOORD3 = (tmpvar_12 * unity_Scale.w);
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD3;
varying vec4 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform samplerCube _envmap;
uniform sampler2D _normalmap;
void main ()
{
  vec4 res_1;
  vec3 worldN_2;
  vec3 tmpvar_3;
  tmpvar_3.x = xlv_TEXCOORD1.w;
  tmpvar_3.y = xlv_TEXCOORD2.w;
  tmpvar_3.z = xlv_TEXCOORD3.w;
  vec3 normal_4;
  normal_4.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_4.z = sqrt((1.0 - clamp (dot (normal_4.xy, normal_4.xy), 0.0, 1.0)));
  vec3 tmpvar_5;
  tmpvar_5.x = dot (xlv_TEXCOORD1.xyz, normal_4);
  tmpvar_5.y = dot (xlv_TEXCOORD2.xyz, normal_4);
  tmpvar_5.z = dot (xlv_TEXCOORD3.xyz, normal_4);
  vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normal_4;
  worldN_2.x = dot (xlv_TEXCOORD1, tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normal_4;
  worldN_2.y = dot (xlv_TEXCOORD2, tmpvar_7);
  vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = normal_4;
  worldN_2.z = dot (xlv_TEXCOORD3, tmpvar_8);
  res_1.xyz = ((worldN_2 * 0.5) + 0.5);
  res_1.w = textureCube (_envmap, (tmpvar_3 - (2.0 * (dot (tmpvar_5, tmpvar_3) * tmpvar_5)))).x;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [_basetexture_ST]
"vs_3_0
; 31 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, v1.w, r0
mov r0.xyz, c12
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r2.xyz, r2, c13.w, -v0
dp3 r0.y, r1, c4
dp3 r0.w, -r2, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o2, r0, c13.w
dp3 r0.y, r1, c5
dp3 r0.w, -r2, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o3, r0, c13.w
dp3 r0.y, r1, c6
dp3 r0.w, -r2, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o4, r0, c13.w
mad o1.xy, v3, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 160 [_basetexture_ST]
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
eefiecedgapaldakainoodihpdekpemffpcilhbkabaaaaaabeahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiafaaaaeaaaabaa
foabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaadiaaaaajhcaabaaa
abaaaaaafgafbaiaebaaaaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaal
lcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaiaebaaaaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaallcaabaaaaaaaaaaaegiicaaaacaaaaaaaoaaaaaa
kgakbaiaebaaaaaaaaaaaaaaegambaaaaaaaaaaadgaaaaaficaabaaaabaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgbpbaaaabaaaaaadgaaaaagbcaabaaaadaaaaaaakiacaaaacaaaaaaamaaaaaa
dgaaaaagccaabaaaadaaaaaaakiacaaaacaaaaaaanaaaaaadgaaaaagecaabaaa
adaaaaaaakiacaaaacaaaaaaaoaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaabaaaaaa
egacbaaaadaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaa
adaaaaaadiaaaaaipccabaaaacaaaaaaegaobaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaaaaaaaadgaaaaagbcaabaaa
adaaaaaabkiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaadaaaaaabkiacaaa
acaaaaaaanaaaaaadgaaaaagecaabaaaadaaaaaabkiacaaaacaaaaaaaoaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaadaaaaaadiaaaaaipccabaaaadaaaaaa
egaobaaaabaaaaaapgipcaaaacaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaa
ckiacaaaacaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaacaaaaaa
anaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaacaaaaaaaoaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipccabaaaaeaaaaaaegaobaaa
aaaaaaaapgipcaaaacaaaaaabeaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "_LINEAR_SPACE" }
SetTexture 2 [_normalmap] 2D 2
SetTexture 3 [_envmap] CUBE 3
"ps_3_0
; 23 ALU, 2 TEX
dcl_2d s2
dcl_cube s3
def c0, 2.00000000, -1.00000000, 1.00000000, 2.20000005
def c1, 0.50000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c0
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r1.x, v1, r0
dp3_pp r1.y, r0, v2
dp3_pp r1.z, r0, v3
mov_pp r2.x, r1
mov_pp r2.y, r1
mov_pp r2.z, r1
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r2, r0
mul_pp r2.xyz, r2, r0.w
mad_pp r0.xyz, -r2, c0.x, r0
texld r2.x, r0, s3
pow r0, r2.x, c0.w
mov oC0.w, r0
mad_pp oC0.xyz, r1, c1.x, c1.x
"
}
SubProgram "d3d11 " {
Keywords { "_LINEAR_SPACE" }
SetTexture 0 [_normalmap] 2D 0
SetTexture 1 [_envmap] CUBE 1
"ps_4_0
eefiecedkeiockikjdpjgipjdpfpfjkmikkofpboabaaaaaapaadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiacaaaaeaaaaaaalkaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaa
egbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
aeaaaaaaegacbaaaaaaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaacaaaaaa
dgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaa
dkbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaamnmmameabjaaaaaficcabaaa
aaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "_GAMMA_SPACE" }
SetTexture 2 [_normalmap] 2D 2
SetTexture 3 [_envmap] CUBE 3
"ps_3_0
; 20 ALU, 2 TEX
dcl_2d s2
dcl_cube s3
def c0, 2.00000000, -1.00000000, 1.00000000, 0.50000000
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
dcl_texcoord2 v2
dcl_texcoord3 v3
texld r0.yw, v0, s2
mad_pp r0.xy, r0.wyzw, c0.x, c0.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c0
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r1.x, v1, r0
dp3_pp r1.y, r0, v2
dp3_pp r1.z, r0, v3
mov_pp r2.x, r1
mov_pp r2.y, r1
mov_pp r2.z, r1
mov r0.x, v1.w
mov r0.z, v3.w
mov r0.y, v2.w
dp3_pp r0.w, r2, r0
mul_pp r2.xyz, r2, r0.w
mad_pp r0.xyz, -r2, c0.x, r0
texld r0.x, r0, s3
mov_pp oC0.w, r0.x
mad_pp oC0.xyz, r1, c0.w, c0.w
"
}
SubProgram "d3d11 " {
Keywords { "_GAMMA_SPACE" }
SetTexture 0 [_normalmap] 2D 0
SetTexture 1 [_envmap] CUBE 1
"ps_4_0
eefiecedijjgcnlcidnbppnfpdhamamkkenpcmikabaaaaaamaadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcliacaaaaeaaaaaaakoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaa
egbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaa
aeaaaaaaegacbaaaaaaaaaaadgaaaaafbcaabaaaaaaaaaaadkbabaaaacaaaaaa
dgaaaaafccaabaaaaaaaaaaadkbabaaaadaaaaaadgaaaaafecaabaaaaaaaaaaa
dkbabaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaapgapbaiaebaaaaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegacbaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Geometry" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_2;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((-(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD1))).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * texture2D (_basetexture, xlv_TEXCOORD0).xyz));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_basetexture_ST]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidialmhlhfffkeaoejfbnopcnahkfdchabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform mat4 _Object2World;


uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * gl_Vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((gl_ModelViewMatrix * gl_Vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((-(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD1))).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * texture2D (_basetexture, xlv_TEXCOORD0).xyz));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_basetexture_ST]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad o2.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o2.zw, r0
mul o4.xyz, r1, c14.w
mad o1.xy, v1, c16, c16.zwzw
mad o3.xy, v2, c15, c15.zwzw
mul o4.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 160 [unity_LightmapST]
Vector 176 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedccecopdheancfkjhbhoedkdchdhegibiabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_2;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((texture2DProj (_LightBuffer, xlv_TEXCOORD1).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * texture2D (_basetexture, xlv_TEXCOORD0).xyz));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_basetexture_ST]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidialmhlhfffkeaoejfbnopcnahkfdchabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform mat4 _Object2World;


uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * gl_Vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((gl_ModelViewMatrix * gl_Vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((texture2DProj (_LightBuffer, xlv_TEXCOORD1).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * texture2D (_basetexture, xlv_TEXCOORD0).xyz));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_basetexture_ST]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad o2.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o2.zw, r0
mul o4.xyz, r1, c14.w
mad o1.xy, v1, c16, c16.zwzw
mad o3.xy, v2, c15, c15.zwzw
mul o4.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 160 [unity_LightmapST]
Vector 176 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedccecopdheancfkjhbhoedkdchdhegibiabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_2;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((-(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD1))).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2))));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_basetexture_ST]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidialmhlhfffkeaoejfbnopcnahkfdchabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform mat4 _Object2World;


uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * gl_Vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((gl_ModelViewMatrix * gl_Vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((-(log2(texture2DProj (_LightBuffer, xlv_TEXCOORD1))).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2))));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_basetexture_ST]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad o2.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o2.zw, r0
mul o4.xyz, r1, c14.w
mad o1.xy, v1, c16, c16.zwzw
mad o3.xy, v2, c15, c15.zwzw
mul o4.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 160 [unity_LightmapST]
Vector 176 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedccecopdheancfkjhbhoedkdchdhegibiabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;

uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_2;
  vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_2;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((texture2DProj (_LightBuffer, xlv_TEXCOORD1).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2))));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [_basetexture_ST]
"vs_3_0
; 10 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad o2.xy, r1.z, c5.zwzw, r1
mov o0, r0
mov o2.zw, r0
mad o1.xy, v1, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 160 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedidialmhlhfffkeaoejfbnopcnahkfdchabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
"!!GLSL
#ifdef VERTEX
varying vec4 xlv_TEXCOORD3;
varying vec2 xlv_TEXCOORD2;
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform vec4 _basetexture_ST;
uniform vec4 unity_LightmapST;
uniform mat4 _Object2World;


uniform vec4 unity_ShadowFadeCenterAndType;
uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * gl_Vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((gl_ModelViewMatrix * gl_Vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = ((gl_MultiTexCoord0.xy * _basetexture_ST.xy) + _basetexture_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = ((gl_MultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
varying vec4 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform float _selfillumblendtofull;
uniform sampler2D _maskmap1;
uniform sampler2D _normalmap;
uniform sampler2D _basetexture;
void main ()
{
  vec4 c_1;
  vec3 normal_2;
  normal_2.xy = ((texture2D (_normalmap, xlv_TEXCOORD0).wy * 2.0) - 1.0);
  normal_2.z = sqrt((1.0 - clamp (dot (normal_2.xy, normal_2.xy), 0.0, 1.0)));
  vec4 color_3;
  color_3.w = 1.0;
  color_3.xyz = vec3(((texture2DProj (_LightBuffer, xlv_TEXCOORD1).w * 0.5) + 0.5));
  c_1.w = color_3.w;
  c_1.xyz = (color_3.xyz + (max (texture2D (_maskmap1, xlv_TEXCOORD0).w, _selfillumblendtofull) * pow (texture2D (_basetexture, xlv_TEXCOORD0).xyz, vec3(2.2, 2.2, 2.2))));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_basetexture_ST]
"vs_3_0
; 20 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad o2.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov r0.x, c14.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov o2.zw, r0
mul o4.xyz, r1, c14.w
mad o1.xy, v1, c16, c16.zwzw
mad o3.xy, v2, c15, c15.zwzw
mul o4.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 224
Vector 160 [unity_LightmapST]
Vector 176 [_basetexture_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedccecopdheancfkjhbhoedkdchdhegibiabaaaaaaiiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaa
plaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
acaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaapgipcaaa
acaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
adaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaa
akbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 4 [_LightBuffer] 2D 4
"ps_3_0
; 6 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s4
def c1, 0.50000000, 1.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r1.w, v0, s0
texldp r0.w, v1, s4
texld r0.xyz, v0, s1
max_pp r1.x, r1.w, c0
mul_pp r0.xyz, r1.x, r0
log_pp r0.w, r0.w
mad_pp r0.xyz, -r0.w, c1.x, r0
add_pp oC0.xyz, r0, c1.x
mov_pp oC0.w, c1.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 192
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlabnbcialcpeggllbghfmgffpblecofoabaaaaaaimacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaagnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaalp
abeaaaaaaaaaaadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadeaaaaaiccaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaafgafbaaa
aaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 4 [_LightBuffer] 2D 4
"ps_3_0
; 6 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s4
def c1, 0.50000000, 1.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r1.w, v0, s0
texldp r0.w, v1, s4
texld r0.xyz, v0, s1
max_pp r1.x, r1.w, c0
mul_pp r0.xyz, r1.x, r0
log_pp r0.w, r0.w
mad_pp r0.xyz, -r0.w, c1.x, r0
add_pp oC0.xyz, r0, c1.x
mov_pp oC0.w, c1.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "_LINEAR_SPACE" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 224
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfiomalkdnpoamgggadhdkphajafebniaabaaaaaalmacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcleabaaaaeaaaaaaagnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
cpaaaaafbcaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaalpabeaaaaaaaaaaadpefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadeaaaaai
ccaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 4 [_LightBuffer] 2D 4
"ps_3_0
; 5 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s4
def c1, 0.50000000, 1.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r0.w, v0, s0
max_pp r0.w, r0, c0.x
texld r0.xyz, v0, s1
mul_pp r0.xyz, r0.w, r0
texldp r0.w, v1, s4
mad_pp r0.xyz, r0.w, c1.x, r0
add_pp oC0.xyz, r0, c1.x
mov_pp oC0.w, c1.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 192
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedobjdjabajffmemjfipobidjdcfpjbofiabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadeaaaaaiccaabaaa
aaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 4 [_LightBuffer] 2D 4
"ps_3_0
; 5 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s4
def c1, 0.50000000, 1.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r0.w, v0, s0
max_pp r0.w, r0, c0.x
texld r0.xyz, v0, s1
mul_pp r0.xyz, r0.w, r0
texldp r0.w, v1, s4
mad_pp r0.xyz, r0.w, c1.x, r0
add_pp oC0.xyz, r0, c1.x
mov_pp oC0.w, c1.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_LINEAR_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 224
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhaffkhipekebnmpbcklignecglnepioeabaaaaaakiacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefckaabaaaaeaaaaaaagiaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaaadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadeaaaaaiccaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaafgafbaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"ps_3_0
; 18 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c1, 2.20000005, 0.50000000, 1.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r1.xyz, v0, s1
pow r0, r1.x, c1.x
mov r1.x, r0
pow r0, r1.y, c1.x
pow r2, r1.z, c1.x
texld r1.w, v0, s0
texldp r0.w, v1, s3
mov r1.y, r0
mov r1.z, r2
max_pp r0.x, r1.w, c0
mul_pp r0.xyz, r0.x, r1
log_pp r0.w, r0.w
mad_pp r0.xyz, -r0.w, c1.y, r0
add_pp oC0.xyz, r0, c1.y
mov_pp oC0.w, c1.z
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 192
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedohdjenkmfggnmhjdmcenpdggeceapbblabaaaaaanmacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeacaaaaeaaaaaaaibaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaalpabeaaaaaaaaaaadpefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
deaaaaaibcaabaaaabaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaa
dcaaaaajhccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"ps_3_0
; 18 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c1, 2.20000005, 0.50000000, 1.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r1.xyz, v0, s1
pow r0, r1.x, c1.x
mov r1.x, r0
pow r0, r1.y, c1.x
pow r2, r1.z, c1.x
texld r1.w, v0, s0
texldp r0.w, v1, s3
mov r1.y, r0
mov r1.z, r2
max_pp r0.x, r1.w, c0
mul_pp r0.xyz, r0.x, r1
log_pp r0.w, r0.w
mad_pp r0.xyz, -r0.w, c1.y, r0
add_pp oC0.xyz, r0, c1.y
mov_pp oC0.w, c1.z
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 224
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecednlhhoeflgooiofccgbdjpihdhmmnfamcabaaaaaaamadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcaeacaaaaeaaaaaaaibaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmameamnmmameamnmmameaaaaaaaaa
bjaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaaficaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaalpabeaaaaaaaaaaadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadeaaaaaibcaabaaaabaaaaaadkaabaaa
abaaaaaadkiacaaaaaaaaaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaaagaabaaa
abaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"ps_3_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c1, 2.20000005, 0.50000000, 1.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r1.xyz, v0, s1
pow r0, r1.x, c1.x
pow r2, r1.y, c1.x
mov r1.x, r0
pow r0, r1.z, c1.x
texld r0.w, v0, s0
max_pp r0.x, r0.w, c0
mov r1.y, r2
mov r1.z, r0
mul_pp r0.xyz, r0.x, r1
texldp r0.w, v1, s3
mad_pp r0.xyz, r0.w, c1.y, r0
add_pp oC0.xyz, r0, c1.y
mov_pp oC0.w, c1.z
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 192
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjibhokommjalboojemhiohbocofgkecjabaaaaaamiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
mnmmameamnmmameamnmmameaaaaaaaaabjaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaaadpefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadeaaaaaibcaabaaaabaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaaeaaaaaadcaaaaajhccabaaaaaaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
"!!GLSL"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
Float 0 [_selfillumblendtofull]
SetTexture 0 [_maskmap1] 2D 0
SetTexture 1 [_basetexture] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"ps_3_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c1, 2.20000005, 0.50000000, 1.00000000, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1
texld r1.xyz, v0, s1
pow r0, r1.x, c1.x
pow r2, r1.y, c1.x
mov r1.x, r0
pow r0, r1.z, c1.x
texld r0.w, v0, s0
max_pp r0.x, r0.w, c0
mov r1.y, r2
mov r1.z, r0
mul_pp r0.xyz, r0.x, r1
texldp r0.w, v1, s3
mad_pp r0.xyz, r0.w, c1.y, r0
add_pp oC0.xyz, r0, c1.y
mov_pp oC0.w, c1.z
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" "_GAMMA_SPACE" }
SetTexture 0 [_maskmap1] 2D 1
SetTexture 1 [_basetexture] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 224
Float 76 [_selfillumblendtofull]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfgafablcpjmofmkimmcmkdnncinlifcgabaaaaaapiacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmameamnmmameamnmmameaaaaaaaaa
bjaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadpefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadeaaaaai
bcaabaaaabaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaadcaaaaaj
hccabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}