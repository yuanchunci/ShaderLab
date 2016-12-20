Shader "OrbAdditive" {
Properties {
 _MainTex ("Base layer (RGB)", 2D) = "white" {}
 _MainScale ("Base layer scale", Float) = 0.7
 _Scale ("Hotline scale", Float) = 1
 _Color ("Color", Color) = (1,1,1,1)
 _ScrollX ("Base layer Scroll speed X", Float) = 1
 _Ratio ("Ratio", Float) = 0
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 5 [_World2Object]
Vector 9 [_Time]
Vector 10 [_MainTex_ST]
Float 11 [_ScrollX]
Float 12 [_Ratio]
"!!ARBvp1.0
# 24 ALU
PARAM c[13] = { { -0.14001465, 0, 3 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
MOV R1.zw, c[0].xyxz;
MOV R0.w, c[0].y;
MOV R0.z, c[11].x;
MUL R1.xy, R0.zwzw, c[9];
MOV R0.y, c[0];
MUL R0.x, R1.z, c[11];
MUL R0.xy, R0, c[9];
FRC R0.zw, R0.xyxy;
MAD R0.xy, vertex.texcoord[0], c[10], c[10].zwzw;
ADD R0.zw, R0.xyxy, R0;
FRC R1.xy, R1;
ADD R0.xy, R0, R1;
MAD result.texcoord[0].w, R1, c[12].x, R0;
MOV result.texcoord[0].z, R0;
MAD result.texcoord[0].y, R1.w, c[12].x, R0;
MOV result.texcoord[0].x, R0;
DP4 result.texcoord[1].w, vertex.position, c[8];
DP4 result.texcoord[1].z, vertex.position, c[7];
DP4 result.texcoord[1].y, vertex.position, c[6];
DP4 result.texcoord[1].x, vertex.position, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_Time]
Vector 9 [_MainTex_ST]
Float 10 [_ScrollX]
Float 11 [_Ratio]
"vs_2_0
; 30 ALU
def c12, -0.14001465, 0.00000000, 3.00000000, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c10
mad r0.zw, v1.xyxy, c9.xyxy, c9
mov r0.y, c12
mul r0.x, c12, r0
mul r0.xy, r0, c8
frc r0.xy, r0
add r1.xy, r0.zwzw, r0
mov r1.z, c11.x
mov r0.y, c12
mov r0.x, c10
mul r0.xy, r0, c8
frc r0.xy, r0
add r0.zw, r0, r0.xyxy
mov r0.x, c11
mad oT0.w, c12.z, r1.z, r1.y
mov oT0.z, r1.x
mad oT0.y, c12.z, r0.x, r0.w
mov oT0.x, r0.z
dp4 oT1.w, v0, c7
dp4 oT1.z, v0, c6
dp4 oT1.y, v0, c5
dp4 oT1.x, v0, c4
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
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 2 TEX
PARAM c[4] = { program.local[0..1],
		{ 1, 0, -2.5, 4 },
		{ -1.5, 2 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[0].zwzw, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, R1;
MUL R0, R0, c[0];
MOV R1.x, c[3];
MOV R1.y, c[2].w;
MAD R1.y, R1, c[1].x, R1.x;
MOV R1.z, c[1].x;
MAD R1.x, R1.z, c[2].w, c[2].z;
SLT R1.y, fragment.texcoord[1], R1;
SLT R1.x, R1, fragment.texcoord[1].y;
MUL R1.x, R1, R1.y;
ABS R1.x, R1;
MUL R0, R0, c[3].y;
CMP R1.x, -R1, c[2].y, c[2];
CMP result.color, -R1.x, c[2].y, R0;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Color]
Float 1 [_Ratio]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c2, 4.00000000, -2.50000000, 0.00000000, 1.00000000
def c3, 4.00000000, -1.50000000, 2.00000000, 0
dcl t1.xy
dcl t0
texld r1, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s0
mul_pp r0, r1, r0
mul_pp r2, r0, c0
mov_pp r1.x, c1
mov_pp r0.x, c1
mad_pp r1.x, r1, c3, c3.y
mad_pp r0.x, r0, c2, c2.y
add_pp r1.x, t1.y, -r1
add_pp r0.x, -t1.y, r0
cmp_pp r1.x, r1, c2.z, c2.w
cmp_pp r0.x, r0, c2.z, c2.w
mul_pp r0.x, r0, r1
mul_pp r1, r2, c3.z
abs_pp r0.x, r0
cmp_pp r0, -r0.x, c2.z, r1
mov_pp oC0, r0
"
}
}
 }
}
}