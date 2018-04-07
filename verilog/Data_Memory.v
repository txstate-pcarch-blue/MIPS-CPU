
module DataMemory (MR, MW, Addr, WD, Clk, RD/*,
memOut0,memOut1,memOut2,memOut3,memOut4,memOut5,memOut6,memOut7,
memOut8,memOut9,memOut10,memOut11,memOut12,memOut13,memOut14,memOut15,
memOut16,memOut17,memOut18,memOut19,memOut20,memOut21,memOut22,memOut23,
memOut24,memOut25,memOut26,memOut27,memOut28,memOut29,memOut30,memOut31,
memOut32,memOut33,memOut34,memOut35,memOut36,memOut37,memOut38,memOut39,
memOut40,memOut41,memOut42,memOut43,memOut44,memOut45,memOut46,memOut47,
memOut48,memOut49,memOut50,memOut51,memOut52,memOut53,memOut54,memOut55,
memOut56,memOut57,memOut58,memOut59,memOut60,memOut61,memOut62,memOut63,
memOut64,memOut65,memOut66,memOut67,memOut68,memOut69,memOut70,memOut71,
memOut72,memOut73,memOut74,memOut75,memOut76,memOut77,memOut78,memOut79,
memOut80,memOut81,memOut82,memOut83,memOut84,memOut85,memOut86,memOut87,
memOut88,memOut89,memOut90,memOut91,memOut92,memOut93,memOut94,memOut95,
memOut96,memOut97,memOut98,memOut99,memOut100,memOut101,memOut102,
memOut103,memOut104,memOut105,memOut106,memOut107,memOut108,memOut109,
memOut110,memOut111,memOut112,memOut113,memOut114,memOut115,memOut116,
memOut117,memOut118,memOut119,memOut120,memOut121,memOut122,memOut123,
memOut124,memOut125,memOut126,memOut127,memOut128,memOut129,memOut130,
memOut131,memOut132,memOut133,memOut134,memOut135,memOut136,memOut137,
memOut138,memOut139,memOut140,memOut141,memOut142,memOut143,memOut144,
memOut145,memOut146,memOut147,memOut148,memOut149,memOut150,memOut151,
memOut152,memOut153,memOut154,memOut155,memOut156,memOut157,memOut158,
memOut159,memOut160,memOut161,memOut162,memOut163,memOut164,memOut165,
memOut166,memOut167,memOut168,memOut169,memOut170,memOut171,memOut172,
memOut173,memOut174,memOut175,memOut176,memOut177,memOut178,memOut179,
memOut180,memOut181,memOut182,memOut183,memOut184,memOut185,memOut186,
memOut187,memOut188,memOut189,memOut190,memOut191,memOut192,memOut193,
memOut194,memOut195,memOut196,memOut197,memOut198,memOut199,memOut200,
memOut201,memOut202,memOut203,memOut204,memOut205,memOut206,memOut207,
memOut208,memOut209,memOut210,memOut211,memOut212,memOut213,memOut214,
memOut215,memOut216,memOut217,memOut218,memOut219,memOut220,memOut221,
memOut222,memOut223,memOut224,memOut225,memOut226,memOut227,memOut228,
memOut229,memOut230,memOut231,memOut232,memOut233,memOut234,memOut235,
memOut236,memOut237,memOut238,memOut239,memOut240,memOut241,memOut242,
memOut243,memOut244,memOut245,memOut246,memOut247,memOut248,memOut249,
memOut250,memOut251,memOut252,memOut253,memOut254,memOut255
*/
);

input MR, MW;  // MemRead, MemWrite
input [31:0] Addr;  // memory address
input [31:0] WD;  // memory address contents
input Clk;
output reg [31:0] RD;  // output of memory address contents

reg [31:0] MEM[0:255];  // 256 words of 32-bit memory

  /* 
  * FOR DEBUG registers to view on GTKWave
  * Uncomment as needed
  */
  /*
    output [31:0] memOut0;
    output [31:0] memOut1;
    output [31:0] memOut2;
    output [31:0] memOut3;
    output [31:0] memOut4;
    output [31:0] memOut5;
    output [31:0] memOut6;
    output [31:0] memOut7;
    output [31:0] memOut8;
    output [31:0] memOut9;
    output [31:0] memOut10;
    output [31:0] memOut11;
    output [31:0] memOut12;
    output [31:0] memOut13;
    output [31:0] memOut14;
    output [31:0] memOut15;
    output [31:0] memOut16;
    output [31:0] memOut17;
    output [31:0] memOut18;
    output [31:0] memOut19;
    output [31:0] memOut20;
    output [31:0] memOut21;
    output [31:0] memOut22;
    output [31:0] memOut23;
    output [31:0] memOut24;
    output [31:0] memOut25;
    output [31:0] memOut26;
    output [31:0] memOut27;
    output [31:0] memOut28;
    output [31:0] memOut29;
    output [31:0] memOut30;
    output [31:0] memOut31;
    output [31:0] memOut32;
    output [31:0] memOut33;
    output [31:0] memOut34;
    output [31:0] memOut35;
    output [31:0] memOut36;
    output [31:0] memOut37;
    output [31:0] memOut38;
    output [31:0] memOut39;
    output [31:0] memOut40;
    output [31:0] memOut41;
    output [31:0] memOut42;
    output [31:0] memOut43;
    output [31:0] memOut44;
    output [31:0] memOut45;
    output [31:0] memOut46;
    output [31:0] memOut47;
    output [31:0] memOut48;
    output [31:0] memOut49;
    output [31:0] memOut50;
    output [31:0] memOut51;
    output [31:0] memOut52;
    output [31:0] memOut53;
    output [31:0] memOut54;
    output [31:0] memOut55;
    output [31:0] memOut56;
    output [31:0] memOut57;
    output [31:0] memOut58;
    output [31:0] memOut59;
    output [31:0] memOut60;
    output [31:0] memOut61;
    output [31:0] memOut62;
    output [31:0] memOut63;
    output [31:0] memOut64;
    output [31:0] memOut65;
    output [31:0] memOut66;
    output [31:0] memOut67;
    output [31:0] memOut68;
    output [31:0] memOut69;
    output [31:0] memOut70;
    output [31:0] memOut71;
    output [31:0] memOut72;
    output [31:0] memOut73;
    output [31:0] memOut74;
    output [31:0] memOut75;
    output [31:0] memOut76;
    output [31:0] memOut77;
    output [31:0] memOut78;
    output [31:0] memOut79;
    output [31:0] memOut80;
    output [31:0] memOut81;
    output [31:0] memOut82;
    output [31:0] memOut83;
    output [31:0] memOut84;
    output [31:0] memOut85;
    output [31:0] memOut86;
    output [31:0] memOut87;
    output [31:0] memOut88;
    output [31:0] memOut89;
    output [31:0] memOut90;
    output [31:0] memOut91;
    output [31:0] memOut92;
    output [31:0] memOut93;
    output [31:0] memOut94;
    output [31:0] memOut95;
    output [31:0] memOut96;
    output [31:0] memOut97;
    output [31:0] memOut98;
    output [31:0] memOut99;
    output [31:0] memOut100;
    output [31:0] memOut101;
    output [31:0] memOut102;
    output [31:0] memOut103;
    output [31:0] memOut104;
    output [31:0] memOut105;
    output [31:0] memOut106;
    output [31:0] memOut107;
    output [31:0] memOut108;
    output [31:0] memOut109;
    output [31:0] memOut110;
    output [31:0] memOut111;
    output [31:0] memOut112;
    output [31:0] memOut113;
    output [31:0] memOut114;
    output [31:0] memOut115;
    output [31:0] memOut116;
    output [31:0] memOut117;
    output [31:0] memOut118;
    output [31:0] memOut119;
    output [31:0] memOut120;
    output [31:0] memOut121;
    output [31:0] memOut122;
    output [31:0] memOut123;
    output [31:0] memOut124;
    output [31:0] memOut125;
    output [31:0] memOut126;
    output [31:0] memOut127;
    output [31:0] memOut128;
    output [31:0] memOut129;
    output [31:0] memOut130;
    output [31:0] memOut131;
    output [31:0] memOut132;
    output [31:0] memOut133;
    output [31:0] memOut134;
    output [31:0] memOut135;
    output [31:0] memOut136;
    output [31:0] memOut137;
    output [31:0] memOut138;
    output [31:0] memOut139;
    output [31:0] memOut140;
    output [31:0] memOut141;
    output [31:0] memOut142;
    output [31:0] memOut143;
    output [31:0] memOut144;
    output [31:0] memOut145;
    output [31:0] memOut146;
    output [31:0] memOut147;
    output [31:0] memOut148;
    output [31:0] memOut149;
    output [31:0] memOut150;
    output [31:0] memOut151;
    output [31:0] memOut152;
    output [31:0] memOut153;
    output [31:0] memOut154;
    output [31:0] memOut155;
    output [31:0] memOut156;
    output [31:0] memOut157;
    output [31:0] memOut158;
    output [31:0] memOut159;
    output [31:0] memOut160;
    output [31:0] memOut161;
    output [31:0] memOut162;
    output [31:0] memOut163;
    output [31:0] memOut164;
    output [31:0] memOut165;
    output [31:0] memOut166;
    output [31:0] memOut167;
    output [31:0] memOut168;
    output [31:0] memOut169;
    output [31:0] memOut170;
    output [31:0] memOut171;
    output [31:0] memOut172;
    output [31:0] memOut173;
    output [31:0] memOut174;
    output [31:0] memOut175;
    output [31:0] memOut176;
    output [31:0] memOut177;
    output [31:0] memOut178;
    output [31:0] memOut179;
    output [31:0] memOut180;
    output [31:0] memOut181;
    output [31:0] memOut182;
    output [31:0] memOut183;
    output [31:0] memOut184;
    output [31:0] memOut185;
    output [31:0] memOut186;
    output [31:0] memOut187;
    output [31:0] memOut188;
    output [31:0] memOut189;
    output [31:0] memOut190;
    output [31:0] memOut191;
    output [31:0] memOut192;
    output [31:0] memOut193;
    output [31:0] memOut194;
    output [31:0] memOut195;
    output [31:0] memOut196;
    output [31:0] memOut197;
    output [31:0] memOut198;
    output [31:0] memOut199;
    output [31:0] memOut200;
    output [31:0] memOut201;
    output [31:0] memOut202;
    output [31:0] memOut203;
    output [31:0] memOut204;
    output [31:0] memOut205;
    output [31:0] memOut206;
    output [31:0] memOut207;
    output [31:0] memOut208;
    output [31:0] memOut209;
    output [31:0] memOut210;
    output [31:0] memOut211;
    output [31:0] memOut212;
    output [31:0] memOut213;
    output [31:0] memOut214;
    output [31:0] memOut215;
    output [31:0] memOut216;
    output [31:0] memOut217;
    output [31:0] memOut218;
    output [31:0] memOut219;
    output [31:0] memOut220;
    output [31:0] memOut221;
    output [31:0] memOut222;
    output [31:0] memOut223;
    output [31:0] memOut224;
    output [31:0] memOut225;
    output [31:0] memOut226;
    output [31:0] memOut227;
    output [31:0] memOut228;
    output [31:0] memOut229;
    output [31:0] memOut230;
    output [31:0] memOut231;
    output [31:0] memOut232;
    output [31:0] memOut233;
    output [31:0] memOut234;
    output [31:0] memOut235;
    output [31:0] memOut236;
    output [31:0] memOut237;
    output [31:0] memOut238;
    output [31:0] memOut239;
    output [31:0] memOut240;
    output [31:0] memOut241;
    output [31:0] memOut242;
    output [31:0] memOut243;
    output [31:0] memOut244;
    output [31:0] memOut245;
    output [31:0] memOut246;
    output [31:0] memOut247;
    output [31:0] memOut248;
    output [31:0] memOut249;
    output [31:0] memOut250;
    output [31:0] memOut251;
    output [31:0] memOut252;
    output [31:0] memOut253;
    output [31:0] memOut254;
    output [31:0] memOut255;

    assign memOut0 = MEM[0];
    assign memOut1 = MEM[1];
    assign memOut2 = MEM[2];
    assign memOut3 = MEM[3];
    assign memOut4 = MEM[4];
    assign memOut5 = MEM[5];
    assign memOut6 = MEM[6];
    assign memOut7 = MEM[7];
    assign memOut8 = MEM[8];
    assign memOut9 = MEM[9];
    assign memOut10 = MEM[10];
    assign memOut11 = MEM[11];
    assign memOut12 = MEM[12];
    assign memOut13 = MEM[13];
    assign memOut14 = MEM[14];
    assign memOut15 = MEM[15];
    assign memOut16 = MEM[16];
    assign memOut17 = MEM[17];
    assign memOut18 = MEM[18];
    assign memOut19 = MEM[19];
    assign memOut20 = MEM[20];
    assign memOut21 = MEM[21];
    assign memOut22 = MEM[22];
    assign memOut23 = MEM[23];
    assign memOut24 = MEM[24];
    assign memOut25 = MEM[25];
    assign memOut26 = MEM[26];
    assign memOut27 = MEM[27];
    assign memOut28 = MEM[28];
    assign memOut29 = MEM[29];
    assign memOut30 = MEM[30];
    assign memOut31 = MEM[31];
    assign memOut32 = MEM[32];
    assign memOut33 = MEM[33];
    assign memOut34 = MEM[34];
    assign memOut35 = MEM[35];
    assign memOut36 = MEM[36];
    assign memOut37 = MEM[37];
    assign memOut38 = MEM[38];
    assign memOut39 = MEM[39];
    assign memOut40 = MEM[40];
    assign memOut41 = MEM[41];
    assign memOut42 = MEM[42];
    assign memOut43 = MEM[43];
    assign memOut44 = MEM[44];
    assign memOut45 = MEM[45];
    assign memOut46 = MEM[46];
    assign memOut47 = MEM[47];
    assign memOut48 = MEM[48];
    assign memOut49 = MEM[49];
    assign memOut50 = MEM[50];
    assign memOut51 = MEM[51];
    assign memOut52 = MEM[52];
    assign memOut53 = MEM[53];
    assign memOut54 = MEM[54];
    assign memOut55 = MEM[55];
    assign memOut56 = MEM[56];
    assign memOut57 = MEM[57];
    assign memOut58 = MEM[58];
    assign memOut59 = MEM[59];
    assign memOut60 = MEM[60];
    assign memOut61 = MEM[61];
    assign memOut62 = MEM[62];
    assign memOut63 = MEM[63];
    assign memOut64 = MEM[64];
    assign memOut65 = MEM[65];
    assign memOut66 = MEM[66];
    assign memOut67 = MEM[67];
    assign memOut68 = MEM[68];
    assign memOut69 = MEM[69];
    assign memOut70 = MEM[70];
    assign memOut71 = MEM[71];
    assign memOut72 = MEM[72];
    assign memOut73 = MEM[73];
    assign memOut74 = MEM[74];
    assign memOut75 = MEM[75];
    assign memOut76 = MEM[76];
    assign memOut77 = MEM[77];
    assign memOut78 = MEM[78];
    assign memOut79 = MEM[79];
    assign memOut80 = MEM[80];
    assign memOut81 = MEM[81];
    assign memOut82 = MEM[82];
    assign memOut83 = MEM[83];
    assign memOut84 = MEM[84];
    assign memOut85 = MEM[85];
    assign memOut86 = MEM[86];
    assign memOut87 = MEM[87];
    assign memOut88 = MEM[88];
    assign memOut89 = MEM[89];
    assign memOut90 = MEM[90];
    assign memOut91 = MEM[91];
    assign memOut92 = MEM[92];
    assign memOut93 = MEM[93];
    assign memOut94 = MEM[94];
    assign memOut95 = MEM[95];
    assign memOut96 = MEM[96];
    assign memOut97 = MEM[97];
    assign memOut98 = MEM[98];
    assign memOut99 = MEM[99];
    assign memOut100 = MEM[100];
    assign memOut101 = MEM[101];
    assign memOut102 = MEM[102];
    assign memOut103 = MEM[103];
    assign memOut104 = MEM[104];
    assign memOut105 = MEM[105];
    assign memOut106 = MEM[106];
    assign memOut107 = MEM[107];
    assign memOut108 = MEM[108];
    assign memOut109 = MEM[109];
    assign memOut110 = MEM[110];
    assign memOut111 = MEM[111];
    assign memOut112 = MEM[112];
    assign memOut113 = MEM[113];
    assign memOut114 = MEM[114];
    assign memOut115 = MEM[115];
    assign memOut116 = MEM[116];
    assign memOut117 = MEM[117];
    assign memOut118 = MEM[118];
    assign memOut119 = MEM[119];
    assign memOut120 = MEM[120];
    assign memOut121 = MEM[121];
    assign memOut122 = MEM[122];
    assign memOut123 = MEM[123];
    assign memOut124 = MEM[124];
    assign memOut125 = MEM[125];
    assign memOut126 = MEM[126];
    assign memOut127 = MEM[127];
    assign memOut128 = MEM[128];
    assign memOut129 = MEM[129];
    assign memOut130 = MEM[130];
    assign memOut131 = MEM[131];
    assign memOut132 = MEM[132];
    assign memOut133 = MEM[133];
    assign memOut134 = MEM[134];
    assign memOut135 = MEM[135];
    assign memOut136 = MEM[136];
    assign memOut137 = MEM[137];
    assign memOut138 = MEM[138];
    assign memOut139 = MEM[139];
    assign memOut140 = MEM[140];
    assign memOut141 = MEM[141];
    assign memOut142 = MEM[142];
    assign memOut143 = MEM[143];
    assign memOut144 = MEM[144];
    assign memOut145 = MEM[145];
    assign memOut146 = MEM[146];
    assign memOut147 = MEM[147];
    assign memOut148 = MEM[148];
    assign memOut149 = MEM[149];
    assign memOut150 = MEM[150];
    assign memOut151 = MEM[151];
    assign memOut152 = MEM[152];
    assign memOut153 = MEM[153];
    assign memOut154 = MEM[154];
    assign memOut155 = MEM[155];
    assign memOut156 = MEM[156];
    assign memOut157 = MEM[157];
    assign memOut158 = MEM[158];
    assign memOut159 = MEM[159];
    assign memOut160 = MEM[160];
    assign memOut161 = MEM[161];
    assign memOut162 = MEM[162];
    assign memOut163 = MEM[163];
    assign memOut164 = MEM[164];
    assign memOut165 = MEM[165];
    assign memOut166 = MEM[166];
    assign memOut167 = MEM[167];
    assign memOut168 = MEM[168];
    assign memOut169 = MEM[169];
    assign memOut170 = MEM[170];
    assign memOut171 = MEM[171];
    assign memOut172 = MEM[172];
    assign memOut173 = MEM[173];
    assign memOut174 = MEM[174];
    assign memOut175 = MEM[175];
    assign memOut176 = MEM[176];
    assign memOut177 = MEM[177];
    assign memOut178 = MEM[178];
    assign memOut179 = MEM[179];
    assign memOut180 = MEM[180];
    assign memOut181 = MEM[181];
    assign memOut182 = MEM[182];
    assign memOut183 = MEM[183];
    assign memOut184 = MEM[184];
    assign memOut185 = MEM[185];
    assign memOut186 = MEM[186];
    assign memOut187 = MEM[187];
    assign memOut188 = MEM[188];
    assign memOut189 = MEM[189];
    assign memOut190 = MEM[190];
    assign memOut191 = MEM[191];
    assign memOut192 = MEM[192];
    assign memOut193 = MEM[193];
    assign memOut194 = MEM[194];
    assign memOut195 = MEM[195];
    assign memOut196 = MEM[196];
    assign memOut197 = MEM[197];
    assign memOut198 = MEM[198];
    assign memOut199 = MEM[199];
    assign memOut200 = MEM[200];
    assign memOut201 = MEM[201];
    assign memOut202 = MEM[202];
    assign memOut203 = MEM[203];
    assign memOut204 = MEM[204];
    assign memOut205 = MEM[205];
    assign memOut206 = MEM[206];
    assign memOut207 = MEM[207];
    assign memOut208 = MEM[208];
    assign memOut209 = MEM[209];
    assign memOut210 = MEM[210];
    assign memOut211 = MEM[211];
    assign memOut212 = MEM[212];
    assign memOut213 = MEM[213];
    assign memOut214 = MEM[214];
    assign memOut215 = MEM[215];
    assign memOut216 = MEM[216];
    assign memOut217 = MEM[217];
    assign memOut218 = MEM[218];
    assign memOut219 = MEM[219];
    assign memOut220 = MEM[220];
    assign memOut221 = MEM[221];
    assign memOut222 = MEM[222];
    assign memOut223 = MEM[223];
    assign memOut224 = MEM[224];
    assign memOut225 = MEM[225];
    assign memOut226 = MEM[226];
    assign memOut227 = MEM[227];
    assign memOut228 = MEM[228];
    assign memOut229 = MEM[229];
    assign memOut230 = MEM[230];
    assign memOut231 = MEM[231];
    assign memOut232 = MEM[232];
    assign memOut233 = MEM[233];
    assign memOut234 = MEM[234];
    assign memOut235 = MEM[235];
    assign memOut236 = MEM[236];
    assign memOut237 = MEM[237];
    assign memOut238 = MEM[238];
    assign memOut239 = MEM[239];
    assign memOut240 = MEM[240];
    assign memOut241 = MEM[241];
    assign memOut242 = MEM[242];
    assign memOut243 = MEM[243];
    assign memOut244 = MEM[244];
    assign memOut245 = MEM[245];
    assign memOut246 = MEM[246];
    assign memOut247 = MEM[247];
    assign memOut248 = MEM[248];
    assign memOut249 = MEM[249];
    assign memOut250 = MEM[250];
    assign memOut251 = MEM[251];
    assign memOut252 = MEM[252];
    assign memOut253 = MEM[253];
    assign memOut254 = MEM[254];
    assign memOut255 = MEM[255];
*/
  
integer i;

initial begin
  RD <= 0;
  for (i = 0; i < 256; i = i + 1) begin
    MEM[i] = i;
  end
end

always @(posedge Clk) begin
  //if MemRead high, load memory value into register
  if (MR == 1'b1) begin
    RD <= MEM[Addr[31:24]];
  end
  //if MemWrite high, write from register to memory
  if (MW == 1'b1) begin
    MEM[Addr[31:24]] <= WD;
  end
end

endmodule
