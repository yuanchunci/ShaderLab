Shader "CG Shaders/Particles/Unlit/Butterfly2" {
Properties {
 _diffuseColor ("Shader Color", Color) = (1,1,1,1)
 _diffuseMap ("Shader Texture", 2D) = "white" {}
 Speed ("Speed", Range(0,5)) = 1
 Speed (" ", Float) = 1
 deformationScale ("Deformation Scale", Range(0,1)) = 1
 deformationScale (" ", Float) = 1
 Tiles ("Tiles", Range(1,5)) = 1
 Tiles (" ", Float) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" }
  Cull Off
  AlphaTest Greater 0.3
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Time]
Float 6 [Speed]
Float 7 [deformationScale]
"!!ARBvp1.0
PARAM c[12] = { { 255, 0.15915491, 0.25 },
		state.matrix.mvp,
		program.local[5..7],
		{ 0, 0.5, 1, -1 },
		{ 24.980801, -24.980801, -60.145809, 60.145809 },
		{ 85.453789, -85.453789, -64.939346, 64.939346 },
		{ 19.73921, -19.73921, -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[6];
MUL R0.y, vertex.color.w, c[0].x;
MUL R0.x, R0, c[5].y;
MAD R0.x, R0, vertex.color, R0.y;
MAD R0.x, R0, c[0].y, -c[0].z;
FRC R0.w, R0.x;
ADD R0.xyz, -R0.w, c[8];
MUL R0.xyz, R0, R0;
MAD R1.xyz, R0, c[9].xyxw, c[9].zwzw;
MAD R1.xyz, R1, R0, c[10].xyxw;
MAD R1.xyz, R1, R0, c[10].zwzw;
MAD R1.xyz, R1, R0, c[11].xyxw;
MAD R1.xyz, R1, R0, c[8].wzww;
SLT R2.x, R0.w, c[0].z;
SGE R2.yz, R0.w, c[11].xzww;
MOV R0.xz, R2;
DP3 R0.y, R2, c[8].wzww;
DP3 R0.x, R1, -R0;
MUL R0.x, R0, vertex.color;
MUL R0.x, R0, c[7];
MAD R0, R0.x, c[8].xxzx, vertex.position;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[1], vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 27 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Time]
Float 5 [Speed]
Float 6 [deformationScale]
"vs_2_0
def c7, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c8, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c9, 255.00000000, 0.15915491, 0.50000000, 0
def c10, 6.28318501, -3.14159298, 0.00000000, 1.00000000
dcl_position0 v0
dcl_texcoord0 v1
dcl_color0 v2
mov r0.x, c4.y
mul r0.y, v2.w, c9.x
mul r0.x, c5, r0
mad r0.x, r0, v2, r0.y
mad r0.x, r0, c9.y, c9.z
frc r0.x, r0
mad r1.x, r0, c10, c10.y
sincos r0.xy, r1.x, c8.xyzw, c7.xyzw
mul r0.x, r0.y, v2
mul r0.x, r0, c6
mad r0, r0.x, c10.zzwz, v0
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mov oT1, v2
mov oT0.xy, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 48 [Speed]
Float 52 [deformationScale]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgliifglmmjnpgpbmkjpndonkhcokppjjabaaaaaaemadaaaaadaaaaaa
cmaaaaaajmaaaaaaamabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcdiacaaaaeaaaabaaioaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
abaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacacaaaaaa
diaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaabaaaaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaadkbabaaaacaaaaaaabeaaaaaaaaahped
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakbabaaaacaaaaaabkaabaaa
aaaaaaaaenaaaaagbcaabaaaaaaaaaaaaanaaaaaakaabaaaaaaaaaaadiaaaaak
pcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadp
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagbabaaaacaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaaaaaaaaaaadaaaaaa
egbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
acaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadgaaaaafpccabaaaacaaaaaa
egbobaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 48 [Speed]
Float 52 [deformationScale]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedjgoegdfkpgdknoeenkkmciachebbcgomabaaaaaahaafaaaaaeaaaaaa
daaaaaaafaacaaaajaaeaaaaaaafaaaaebgpgodjbiacaaaabiacaaaaaaacpopp
mmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaadaa
abaaabaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaahpedidpjccdoaaaaaadpaaaaaaaa
fbaaaaafaiaaapkanlapmjeanlapejmaaaaaaaaaaaaaiadpfbaaaaafajaaapka
abannalfgballglhklkkckdlijiiiidjfbaaaaafakaaapkaklkkkklmaaaaaalo
aaaaiadpaaaaaadpbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjaabaaaaacaaaaabiaabaaaakaafaaaaadaaaaabia
aaaaaaiaacaaffkaafaaaaadaaaaaciaacaappjaahaaaakaaeaaaaaeaaaaabia
aaaaaaiaacaaaajaaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaahaaffkaahaakkka
bdaaaaacaaaaabiaaaaaaaiaaeaaaaaeaaaaabiaaaaaaaiaaiaaaakaaiaaffka
cfaaaaaeabaaaciaaaaaaaiaajaaoekaakaaoekaafaaaaadaaaaapiaabaaffia
aiaalkkaafaaaaadaaaaapiaaaaaoeiaacaaaajaaeaaaaaeaaaaapiaaaaaoeia
abaaffkaaaaaoejaafaaaaadabaaapiaaaaaffiaaeaaoekaaeaaaaaeabaaapia
adaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaafaaoekaaaaakkiaabaaoeia
aeaaaaaeaaaaapiaagaaoekaaaaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
abaaaaacabaaapoaacaaoejappppaaaafdeieefcdiacaaaaeaaaabaaioaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaadpcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
abaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkbabaaaacaaaaaaabeaaaaa
aaaahpeddcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakbabaaaacaaaaaa
bkaabaaaaaaaaaaaenaaaaagbcaabaaaaaaaaaaaaanaaaaaakaabaaaaaaaaaaa
diaaaaakpcaabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagbabaaa
acaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaaaaaaaaaa
adaaaaaaegbobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaacaaaaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadgaaaaafpccabaaa
acaaaaaaegbobaaaacaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaa
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_diffuseColor]
Vector 1 [_diffuseMap_ST]
Float 2 [Tiles]
SetTexture 0 [_diffuseMap] 2D 0
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0.5, 0.30004883 } };
TEMP R0;
TEMP R1;
FLR R0.x, c[2];
MUL R0.y, R0.x, R0.x;
MUL R0.y, R0, fragment.texcoord[1].w;
RCP R0.z, R0.x;
FLR R0.y, R0;
MUL R0.w, R0.y, R0.z;
ABS R1.x, R0.w;
ABS R1.y, R0.x;
FRC R0.x, R1;
MUL R0.x, R0, R1.y;
CMP R1.x, R0.y, -R0, R0;
FLR R1.x, -R1;
FLR R0.w, R0;
MUL R1.y, -R1.x, c[3].x;
MUL R1.x, R0.w, c[3];
MAD R0.xy, fragment.texcoord[0], c[1], c[1].zwzw;
MAD R0.xy, R0, R0.z, R1;
TEX R0, R0, texture[0], 2D;
SLT R1.x, R0.w, c[3].y;
MUL result.color, R0, c[0];
KIL -R1.x;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_diffuseColor]
Vector 1 [_diffuseMap_ST]
Float 2 [Tiles]
SetTexture 0 [_diffuseMap] 2D 0
"ps_2_0
dcl_2d s0
def c3, 0.50000000, -0.30004883, 0.00000000, 1.00000000
dcl t0.xy
dcl t1.xyzw
frc_pp r0.x, c2
add_pp r2.x, -r0, c2
mul_pp r0.x, r2, r2
mul_pp r1.x, r0, t1.w
rcp_pp r0.x, r2.x
frc_pp r3.x, r1
add_pp r3.x, r1, -r3
mul_pp r1.x, r3, r0
abs_pp r4.x, r1
frc_pp r4.x, r4
abs_pp r2.x, r2
mul_pp r2.x, r4, r2
cmp_pp r3.x, r3, r2, -r2
frc_pp r2.x, r1
add_pp r1.x, r1, -r2
frc_pp r4.x, -r3
add_pp r3.x, -r3, -r4
mul_pp r1.y, -r3.x, c3.x
mul_pp r1.x, r1, c3
mov_pp r2.y, c1.w
mov_pp r2.x, c1.z
mad_pp r2.xy, t0, c1, r2
mad_pp r0.xy, r2, r0.x, r1
texld r0, r0, s0
add_pp r1.x, r0.w, c3.y
cmp r1.x, r1, c3.z, c3.w
mov_pp r1, -r1.x
mul_pp r0, r0, c0
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
SetTexture 0 [_diffuseMap] 2D 0
ConstBuffer "$Globals" 64
Vector 16 [_diffuseColor]
Vector 32 [_diffuseMap_ST]
Float 56 [Tiles]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkejdfmhnhdfekglgohdhbibidaafkmheabaaaaaajiadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaacaaaaeaaaaaaalaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadicbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaebaaaaagbcaabaaa
aaaaaaaackiacaaaaaaaaaaaadaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkbabaaaacaaaaaaebaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaabnaaaaaiecaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaaaaagicaabaaa
aaaaaaaabkaabaiaibaaaaaaaaaaaaaaebaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadp
dhaaaaakccaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaaecaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaal
gcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaaaaaaaaaaaacaaaaaakgilcaaa
aaaaaaaaacaaaaaadcaaaaajdcaabaaaaaaaaaaajgafbaaaaaaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaajkjjjjlodiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_diffuseMap] 2D 0
ConstBuffer "$Globals" 64
Vector 16 [_diffuseColor]
Vector 32 [_diffuseMap_ST]
Float 56 [Tiles]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjamfhckbpijdbdpmlanfddiokbpjphhfabaaaaaakeafaaaaaeaaaaaa
daaaaaaadiacaaaaaaafaaaahaafaaaaebgpgodjaaacaaaaaaacaaaaaaacpppp
mmabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaadaaaaaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaadpjkjjjjlo
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaacpla
bpaaaaacaaaaaajaaaaiapkabdaaaaacaaaaciiaacaakkkaacaaaaadaaaacbia
aaaappibacaakkkaafaaaaadaaaacciaaaaaaaiaaaaaaaiaafaaaaadaaaaccia
aaaaffiaabaapplabdaaaaacaaaaceiaaaaaffiaacaaaaadaaaacciaaaaakkib
aaaaffiaagaaaaacaaaaaeiaaaaaaaiaafaaaaadaaaacciaaaaakkiaaaaaffia
cdaaaaacaaaaciiaaaaaffiabdaaaaacaaaaciiaaaaappiafiaaaaaeaaaaciia
aaaaffiaaaaappiaaaaappibafaaaaadaaaacbiaaaaaaaiaaaaappiabdaaaaac
aaaaciiaaaaaaaibacaaaaadaaaacbiaaaaappiaaaaaaaiaafaaaaadabaaccia
aaaaaaiaadaaaakabdaaaaacaaaacbiaaaaaffiaacaaaaadaaaacbiaaaaaaaib
aaaaffiaafaaaaadabaacbiaaaaaaaiaadaaaakaaeaaaaaeaaaacbiaaaaaaala
abaaaakaabaakkkaaeaaaaaeaaaacciaaaaafflaabaaffkaabaappkaaeaaaaae
aaaacdiaaaaaoeiaaaaakkiaabaaoeiaecaaaaadaaaacpiaaaaaoeiaaaaioeka
acaaaaadabaacpiaaaaappiaadaaffkaafaaaaadaaaacpiaaaaaoeiaaaaaoeka
abaaaaacaaaicpiaaaaaoeiaebaaaaababaaapiappppaaaafdeieefcmaacaaaa
eaaaaaaalaaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadicbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
ebaaaaagbcaabaaaaaaaaaaackiacaaaaaaaaaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkbabaaaacaaaaaaebaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
bnaaaaaiecaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
bkaaaaagicaabaaaaaaaaaaabkaabaiaibaaaaaaaaaaaaaaebaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaadpdhaaaaakccaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaaaaaaaaaecaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaalgcaabaaaaaaaaaaaagbbbaaaabaaaaaaagibcaaaaaaaaaaa
acaaaaaakgilcaaaaaaaaaaaacaaaaaadcaaaaajdcaabaaaaaaaaaaajgafbaaa
aaaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaajkjjjjlodiaaaaaipccabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
}
}