Shader "OrbBaseAdditive" {
Properties {
 _MainTex ("Main Tex (RGB)", 2D) = "white" {}
 _1stLayerScale ("1stLayer Scale", Float) = 0.7
 _1stLayerScrollX ("1stLayer ScrollX", Float) = 1
 _1stLayerScrollY ("1stLayer ScrollY", Float) = 0
 _2ndLayerScale ("2ndLayer Scale", Float) = 1.2
 _2ndLayerScrollX ("2ndLayer ScrollX", Float) = 1
 _2ndLayerScrollY ("2ndLayer ScrollY", Float) = 0
 _3rdLayerScale ("3rdLayer Scale", Float) = 1
 _3rdLayerScrollX ("3rdLayer ScrollX", Float) = 1
 _3rdLayerScrollY ("3rdLayer ScrollY", Float) = 0
 _Intensity ("Intensity", Float) = 1
 _Color ("Color", Color) = (1,1,1,1)
 _Ratio ("Ratio", Float) = 0
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent-1" }
 Pass {
  Tags { "QUEUE"="Transparent-1" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 5 [_World2Object]
Vector 9 [_Time]
Vector 10 [_MainTex_ST]
Float 11 [_1stLayerScale]
Float 12 [_2ndLayerScale]
Float 13 [_3rdLayerScale]
Float 14 [_1stLayerScrollX]
Float 15 [_1stLayerScrollY]
Float 16 [_2ndLayerScrollX]
Float 17 [_2ndLayerScrollY]
Float 18 [_3rdLayerScrollX]
Float 19 [_3rdLayerScrollY]
"!!ARBvp1.0
# 30 ALU
PARAM c[20] = { { 4 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
MAD R0.zw, vertex.texcoord[0].xyxy, c[10].xyxy, c[10];
MOV R0.y, c[17].x;
MOV R0.x, c[16];
MUL R0.xy, R0, c[9];
FRC R1.xy, R0;
RCP R0.x, c[12].x;
MUL R0.xy, R0.zwzw, R0.x;
MAD result.texcoord[0].zw, R0.xyxy, c[0].x, R1.xyxy;
MOV R0.y, c[15].x;
MOV R0.x, c[14];
MUL R1.xy, R0, c[9];
RCP R0.x, c[11].x;
MUL R0.xy, R0.zwzw, R0.x;
FRC R1.xy, R1;
MAD result.texcoord[0].xy, R0, c[0].x, R1;
RCP R1.x, c[13].x;
MOV R0.y, c[19].x;
MOV R0.x, c[18];
MUL R0.xy, R0, c[9];
FRC R0.xy, R0;
MUL R0.zw, R0, R1.x;
MAD result.texcoord[1].xy, R0.zwzw, c[0].x, R0;
DP4 result.texcoord[2].w, vertex.position, c[8];
DP4 result.texcoord[2].z, vertex.position, c[7];
DP4 result.texcoord[2].y, vertex.position, c[6];
DP4 result.texcoord[2].x, vertex.position, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_Time]
Vector 9 [_MainTex_ST]
Float 10 [_1stLayerScale]
Float 11 [_2ndLayerScale]
Float 12 [_3rdLayerScale]
Float 13 [_1stLayerScrollX]
Float 14 [_1stLayerScrollY]
Float 15 [_2ndLayerScrollX]
Float 16 [_2ndLayerScrollY]
Float 17 [_3rdLayerScrollX]
Float 18 [_3rdLayerScrollY]
"vs_2_0
; 36 ALU
def c19, 4.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mad r0.zw, v1.xyxy, c9.xyxy, c9
mov r0.y, c16.x
mov r0.x, c15
mul r0.xy, r0, c8
frc r1.xy, r0
rcp r0.x, c11.x
mul r0.xy, r0.zwzw, r0.x
mad oT0.zw, r0.xyxy, c19.x, r1.xyxy
mov r0.y, c14.x
mov r0.x, c13
mul r1.xy, r0, c8
rcp r0.x, c10.x
mul r0.xy, r0.zwzw, r0.x
frc r1.xy, r1
mad oT0.xy, r0, c19.x, r1
rcp r1.x, c12.x
mov r0.y, c18.x
mov r0.x, c17
mul r0.xy, r0, c8
frc r0.xy, r0
mul r0.zw, r0, r1.x
mad oT1.xy, r0.zwzw, c19.x, r0
dp4 oT2.w, v0, c7
dp4 oT2.z, v0, c6
dp4 oT2.y, v0, c5
dp4 oT2.x, v0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Color]
Float 1 [_Ratio]
Float 2 [_Intensity]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 3 TEX
PARAM c[5] = { program.local[0..2],
		{ 4, 1.5, 0, 1 },
		{ 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R0.w, R0, R1;
MUL R1.xyz, R0, R1;
MUL R1.xyz, R1, R2;
MOV R2.y, c[3].x;
MUL R1.w, R0, c[3].x;
DP3 R0.w, R0, R0;
MUL R1.xyz, R1, c[3].x;
MUL R1, R1, c[0];
RSQ R0.w, R0.w;
MOV R2.x, c[4];
MAD R2.x, R2.y, c[1], -R2;
MAD R2.z, R2.y, c[1].x, fragment.texcoord[2].y;
SLT R2.x, -fragment.texcoord[2].y, R2;
ABS R2.x, R2;
MUL R1, R1, c[2].x;
MUL R0.w, R0, R0.x;
ADD R2.y, R2.z, -c[3];
MUL R0, R0, R2.y;
MUL R0, R0, c[4].x;
CMP R2.x, -R2, c[3].z, c[3].w;
CMP result.color, -R2.x, R0, R1;
END
# 24 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Color]
Float 1 [_Ratio]
Float 2 [_Intensity]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 26 ALU, 3 TEX
dcl_2d s0
def c3, 4.00000000, -2.00000000, 0.00000000, 1.00000000
def c4, -1.50000000, 2.00000000, 0, 0
dcl t2.xy
dcl t0
dcl t1.xy
texld r1, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r2.xy, r0
mov_pp r3.xyz, r1
texld r0, t1, s0
texld r2, r2, s0
mul_pp r2.xyz, r1, r2
mul_pp r2.xyz, r2, r0
mul_pp r0.x, r1.w, r2.w
mul_pp r2.w, r0.x, c3.x
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r3.w, r0.x, r1.x
mul_pp r2.xyz, r2, c3.x
mul_pp r2, r2, c0
mov_pp r1.x, c1
mov_pp r0.x, c1
mad_pp r1.x, c3, r1, t2.y
mad_pp r0.x, r0, c3, c3.y
add_pp r1.x, r1, c4
add_pp r0.x, -t2.y, -r0
mul_pp r1, r3, r1.x
cmp_pp r0.x, r0, c3.z, c3.w
mul_pp r2, r2, c2.x
mul_pp r1, r1, c4.y
abs_pp r0.x, r0
cmp_pp r0, -r0.x, r1, r2
mov_pp oC0, r0
"
}
}
 }
}
}