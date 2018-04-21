`timescale 1 ns / 1 ns

module tb();

	parameter tck = 10; // clock tick

	reg clk;
	reg MR, MW;
	reg [31:0] Addr;
	reg [31:0] WD;

	wire [31:0] RD; // ReadData output
	
	integer seed = 1;
	
	wire [31:0] memOut0;
	wire [31:0] memOut1;
	wire [31:0] memOut2;
	wire [31:0] memOut3;
	wire [31:0] memOut4;
	wire [31:0] memOut5;
	wire [31:0] memOut6;
	wire [31:0] memOut7;
	wire [31:0] memOut8;
	wire [31:0] memOut9;
	wire [31:0] memOut10;
	wire [31:0] memOut11;
	wire [31:0] memOut12;
	wire [31:0] memOut13;
	wire [31:0] memOut14;
	wire [31:0] memOut15;
	wire [31:0] memOut16;
	wire [31:0] memOut17;
	wire [31:0] memOut18;
	wire [31:0] memOut19;
	wire [31:0] memOut20;
	wire [31:0] memOut21;
	wire [31:0] memOut22;
	wire [31:0] memOut23;
	wire [31:0] memOut24;
	wire [31:0] memOut25;
	wire [31:0] memOut26;
	wire [31:0] memOut27;
	wire [31:0] memOut28;
	wire [31:0] memOut29;
	wire [31:0] memOut30;
	wire [31:0] memOut31;
	wire [31:0] memOut32;
	wire [31:0] memOut33;
	wire [31:0] memOut34;
	wire [31:0] memOut35;
	wire [31:0] memOut36;
	wire [31:0] memOut37;
	wire [31:0] memOut38;
	wire [31:0] memOut39;
	wire [31:0] memOut40;
	wire [31:0] memOut41;
	wire [31:0] memOut42;
	wire [31:0] memOut43;
	wire [31:0] memOut44;
	wire [31:0] memOut45;
	wire [31:0] memOut46;
	wire [31:0] memOut47;
	wire [31:0] memOut48;
	wire [31:0] memOut49;
	wire [31:0] memOut50;
	wire [31:0] memOut51;
	wire [31:0] memOut52;
	wire [31:0] memOut53;
	wire [31:0] memOut54;
	wire [31:0] memOut55;
	wire [31:0] memOut56;
	wire [31:0] memOut57;
	wire [31:0] memOut58;
	wire [31:0] memOut59;
	wire [31:0] memOut60;
	wire [31:0] memOut61;
	wire [31:0] memOut62;
	wire [31:0] memOut63;
	wire [31:0] memOut64;
	wire [31:0] memOut65;
	wire [31:0] memOut66;
	wire [31:0] memOut67;
	wire [31:0] memOut68;
	wire [31:0] memOut69;
	wire [31:0] memOut70;
	wire [31:0] memOut71;
	wire [31:0] memOut72;
	wire [31:0] memOut73;
	wire [31:0] memOut74;
	wire [31:0] memOut75;
	wire [31:0] memOut76;
	wire [31:0] memOut77;
	wire [31:0] memOut78;
	wire [31:0] memOut79;
	wire [31:0] memOut80;
	wire [31:0] memOut81;
	wire [31:0] memOut82;
	wire [31:0] memOut83;
	wire [31:0] memOut84;
	wire [31:0] memOut85;
	wire [31:0] memOut86;
	wire [31:0] memOut87;
	wire [31:0] memOut88;
	wire [31:0] memOut89;
	wire [31:0] memOut90;
	wire [31:0] memOut91;
	wire [31:0] memOut92;
	wire [31:0] memOut93;
	wire [31:0] memOut94;
	wire [31:0] memOut95;
	wire [31:0] memOut96;
	wire [31:0] memOut97;
	wire [31:0] memOut98;
	wire [31:0] memOut99;
	wire [31:0] memOut100;
	wire [31:0] memOut101;
	wire [31:0] memOut102;
	wire [31:0] memOut103;
	wire [31:0] memOut104;
	wire [31:0] memOut105;
	wire [31:0] memOut106;
	wire [31:0] memOut107;
	wire [31:0] memOut108;
	wire [31:0] memOut109;
	wire [31:0] memOut110;
	wire [31:0] memOut111;
	wire [31:0] memOut112;
	wire [31:0] memOut113;
	wire [31:0] memOut114;
	wire [31:0] memOut115;
	wire [31:0] memOut116;
	wire [31:0] memOut117;
	wire [31:0] memOut118;
	wire [31:0] memOut119;
	wire [31:0] memOut120;
	wire [31:0] memOut121;
	wire [31:0] memOut122;
	wire [31:0] memOut123;
	wire [31:0] memOut124;
	wire [31:0] memOut125;
	wire [31:0] memOut126;
	wire [31:0] memOut127;
	wire [31:0] memOut128;
	wire [31:0] memOut129;
	wire [31:0] memOut130;
	wire [31:0] memOut131;
	wire [31:0] memOut132;
	wire [31:0] memOut133;
	wire [31:0] memOut134;
	wire [31:0] memOut135;
	wire [31:0] memOut136;
	wire [31:0] memOut137;
	wire [31:0] memOut138;
	wire [31:0] memOut139;
	wire [31:0] memOut140;
	wire [31:0] memOut141;
	wire [31:0] memOut142;
	wire [31:0] memOut143;
	wire [31:0] memOut144;
	wire [31:0] memOut145;
	wire [31:0] memOut146;
	wire [31:0] memOut147;
	wire [31:0] memOut148;
	wire [31:0] memOut149;
	wire [31:0] memOut150;
	wire [31:0] memOut151;
	wire [31:0] memOut152;
	wire [31:0] memOut153;
	wire [31:0] memOut154;
	wire [31:0] memOut155;
	wire [31:0] memOut156;
	wire [31:0] memOut157;
	wire [31:0] memOut158;
	wire [31:0] memOut159;
	wire [31:0] memOut160;
	wire [31:0] memOut161;
	wire [31:0] memOut162;
	wire [31:0] memOut163;
	wire [31:0] memOut164;
	wire [31:0] memOut165;
	wire [31:0] memOut166;
	wire [31:0] memOut167;
	wire [31:0] memOut168;
	wire [31:0] memOut169;
	wire [31:0] memOut170;
	wire [31:0] memOut171;
	wire [31:0] memOut172;
	wire [31:0] memOut173;
	wire [31:0] memOut174;
	wire [31:0] memOut175;
	wire [31:0] memOut176;
	wire [31:0] memOut177;
	wire [31:0] memOut178;
	wire [31:0] memOut179;
	wire [31:0] memOut180;
	wire [31:0] memOut181;
	wire [31:0] memOut182;
	wire [31:0] memOut183;
	wire [31:0] memOut184;
	wire [31:0] memOut185;
	wire [31:0] memOut186;
	wire [31:0] memOut187;
	wire [31:0] memOut188;
	wire [31:0] memOut189;
	wire [31:0] memOut190;
	wire [31:0] memOut191;
	wire [31:0] memOut192;
	wire [31:0] memOut193;
	wire [31:0] memOut194;
	wire [31:0] memOut195;
	wire [31:0] memOut196;
	wire [31:0] memOut197;
	wire [31:0] memOut198;
	wire [31:0] memOut199;
	wire [31:0] memOut200;
	wire [31:0] memOut201;
	wire [31:0] memOut202;
	wire [31:0] memOut203;
	wire [31:0] memOut204;
	wire [31:0] memOut205;
	wire [31:0] memOut206;
	wire [31:0] memOut207;
	wire [31:0] memOut208;
	wire [31:0] memOut209;
	wire [31:0] memOut210;
	wire [31:0] memOut211;
	wire [31:0] memOut212;
	wire [31:0] memOut213;
	wire [31:0] memOut214;
	wire [31:0] memOut215;
	wire [31:0] memOut216;
	wire [31:0] memOut217;
	wire [31:0] memOut218;
	wire [31:0] memOut219;
	wire [31:0] memOut220;
	wire [31:0] memOut221;
	wire [31:0] memOut222;
	wire [31:0] memOut223;
	wire [31:0] memOut224;
	wire [31:0] memOut225;
	wire [31:0] memOut226;
	wire [31:0] memOut227;
	wire [31:0] memOut228;
	wire [31:0] memOut229;
	wire [31:0] memOut230;
	wire [31:0] memOut231;
	wire [31:0] memOut232;
	wire [31:0] memOut233;
	wire [31:0] memOut234;
	wire [31:0] memOut235;
	wire [31:0] memOut236;
	wire [31:0] memOut237;
	wire [31:0] memOut238;
	wire [31:0] memOut239;
	wire [31:0] memOut240;
	wire [31:0] memOut241;
	wire [31:0] memOut242;
	wire [31:0] memOut243;
	wire [31:0] memOut244;
	wire [31:0] memOut245;
	wire [31:0] memOut246;
	wire [31:0] memOut247;
	wire [31:0] memOut248;
	wire [31:0] memOut249;
	wire [31:0] memOut250;
	wire [31:0] memOut251;
	wire [31:0] memOut252;
	wire [31:0] memOut253;
	wire [31:0] memOut254;
	wire [31:0] memOut255;

	DataMemory dut
	(
		.MR(MR),
		.MW(MW),
		.Addr(Addr),
		.WD(WD),
		.Clk(clk),
		.RD(RD),
		.memOut0(memOut0),
		.memOut1(memOut1),
		.memOut2(memOut2),
		.memOut3(memOut3),
		.memOut4(memOut4),
		.memOut5(memOut5),
		.memOut6(memOut6),
		.memOut7(memOut7),
		.memOut8(memOut8),
		.memOut9(memOut9),
		.memOut10(memOut10),
		.memOut11(memOut11),
		.memOut12(memOut12),
		.memOut13(memOut13),
		.memOut14(memOut14),
		.memOut15(memOut15),
		.memOut16(memOut16),
		.memOut17(memOut17),
		.memOut18(memOut18),
		.memOut19(memOut19),
		.memOut20(memOut20),
		.memOut21(memOut21),
		.memOut22(memOut22),
		.memOut23(memOut23),
		.memOut24(memOut24),
		.memOut25(memOut25),
		.memOut26(memOut26),
		.memOut27(memOut27),
		.memOut28(memOut28),
		.memOut29(memOut29),
		.memOut30(memOut30),
		.memOut31(memOut31),
		.memOut32(memOut32),
		.memOut33(memOut33),
		.memOut34(memOut34),
		.memOut35(memOut35),
		.memOut36(memOut36),
		.memOut37(memOut37),
		.memOut38(memOut38),
		.memOut39(memOut39),
		.memOut40(memOut40),
		.memOut41(memOut41),
		.memOut42(memOut42),
		.memOut43(memOut43),
		.memOut44(memOut44),
		.memOut45(memOut45),
		.memOut46(memOut46),
		.memOut47(memOut47),
		.memOut48(memOut48),
		.memOut49(memOut49),
		.memOut50(memOut50),
		.memOut51(memOut51),
		.memOut52(memOut52),
		.memOut53(memOut53),
		.memOut54(memOut54),
		.memOut55(memOut55),
		.memOut56(memOut56),
		.memOut57(memOut57),
		.memOut58(memOut58),
		.memOut59(memOut59),
		.memOut60(memOut60),
		.memOut61(memOut61),
		.memOut62(memOut62),
		.memOut63(memOut63),
		.memOut64(memOut64),
		.memOut65(memOut65),
		.memOut66(memOut66),
		.memOut67(memOut67),
		.memOut68(memOut68),
		.memOut69(memOut69),
		.memOut70(memOut70),
		.memOut71(memOut71),
		.memOut72(memOut72),
		.memOut73(memOut73),
		.memOut74(memOut74),
		.memOut75(memOut75),
		.memOut76(memOut76),
		.memOut77(memOut77),
		.memOut78(memOut78),
		.memOut79(memOut79),
		.memOut80(memOut80),
		.memOut81(memOut81),
		.memOut82(memOut82),
		.memOut83(memOut83),
		.memOut84(memOut84),
		.memOut85(memOut85),
		.memOut86(memOut86),
		.memOut87(memOut87),
		.memOut88(memOut88),
		.memOut89(memOut89),
		.memOut90(memOut90),
		.memOut91(memOut91),
		.memOut92(memOut92),
		.memOut93(memOut93),
		.memOut94(memOut94),
		.memOut95(memOut95),
		.memOut96(memOut96),
		.memOut97(memOut97),
		.memOut98(memOut98),
		.memOut99(memOut99),
		.memOut100(memOut100),
		.memOut101(memOut101),
		.memOut102(memOut102),
		.memOut103(memOut103),
		.memOut104(memOut104),
		.memOut105(memOut105),
		.memOut106(memOut106),
		.memOut107(memOut107),
		.memOut108(memOut108),
		.memOut109(memOut109),
		.memOut110(memOut110),
		.memOut111(memOut111),
		.memOut112(memOut112),
		.memOut113(memOut113),
		.memOut114(memOut114),
		.memOut115(memOut115),
		.memOut116(memOut116),
		.memOut117(memOut117),
		.memOut118(memOut118),
		.memOut119(memOut119),
		.memOut120(memOut120),
		.memOut121(memOut121),
		.memOut122(memOut122),
		.memOut123(memOut123),
		.memOut124(memOut124),
		.memOut125(memOut125),
		.memOut126(memOut126),
		.memOut127(memOut127),
		.memOut128(memOut128),
		.memOut129(memOut129),
		.memOut130(memOut130),
		.memOut131(memOut131),
		.memOut132(memOut132),
		.memOut133(memOut133),
		.memOut134(memOut134),
		.memOut135(memOut135),
		.memOut136(memOut136),
		.memOut137(memOut137),
		.memOut138(memOut138),
		.memOut139(memOut139),
		.memOut140(memOut140),
		.memOut141(memOut141),
		.memOut142(memOut142),
		.memOut143(memOut143),
		.memOut144(memOut144),
		.memOut145(memOut145),
		.memOut146(memOut146),
		.memOut147(memOut147),
		.memOut148(memOut148),
		.memOut149(memOut149),
		.memOut150(memOut150),
		.memOut151(memOut151),
		.memOut152(memOut152),
		.memOut153(memOut153),
		.memOut154(memOut154),
		.memOut155(memOut155),
		.memOut156(memOut156),
		.memOut157(memOut157),
		.memOut158(memOut158),
		.memOut159(memOut159),
		.memOut160(memOut160),
		.memOut161(memOut161),
		.memOut162(memOut162),
		.memOut163(memOut163),
		.memOut164(memOut164),
		.memOut165(memOut165),
		.memOut166(memOut166),
		.memOut167(memOut167),
		.memOut168(memOut168),
		.memOut169(memOut169),
		.memOut170(memOut170),
		.memOut171(memOut171),
		.memOut172(memOut172),
		.memOut173(memOut173),
		.memOut174(memOut174),
		.memOut175(memOut175),
		.memOut176(memOut176),
		.memOut177(memOut177),
		.memOut178(memOut178),
		.memOut179(memOut179),
		.memOut180(memOut180),
		.memOut181(memOut181),
		.memOut182(memOut182),
		.memOut183(memOut183),
		.memOut184(memOut184),
		.memOut185(memOut185),
		.memOut186(memOut186),
		.memOut187(memOut187),
		.memOut188(memOut188),
		.memOut189(memOut189),
		.memOut190(memOut190),
		.memOut191(memOut191),
		.memOut192(memOut192),
		.memOut193(memOut193),
		.memOut194(memOut194),
		.memOut195(memOut195),
		.memOut196(memOut196),
		.memOut197(memOut197),
		.memOut198(memOut198),
		.memOut199(memOut199),
		.memOut200(memOut200),
		.memOut201(memOut201),
		.memOut202(memOut202),
		.memOut203(memOut203),
		.memOut204(memOut204),
		.memOut205(memOut205),
		.memOut206(memOut206),
		.memOut207(memOut207),
		.memOut208(memOut208),
		.memOut209(memOut209),
		.memOut210(memOut210),
		.memOut211(memOut211),
		.memOut212(memOut212),
		.memOut213(memOut213),
		.memOut214(memOut214),
		.memOut215(memOut215),
		.memOut216(memOut216),
		.memOut217(memOut217),
		.memOut218(memOut218),
		.memOut219(memOut219),
		.memOut220(memOut220),
		.memOut221(memOut221),
		.memOut222(memOut222),
		.memOut223(memOut223),
		.memOut224(memOut224),
		.memOut225(memOut225),
		.memOut226(memOut226),
		.memOut227(memOut227),
		.memOut228(memOut228),
		.memOut229(memOut229),
		.memOut230(memOut230),
		.memOut231(memOut231),
		.memOut232(memOut232),
		.memOut233(memOut233),
		.memOut234(memOut234),
		.memOut235(memOut235),
		.memOut236(memOut236),
		.memOut237(memOut237),
		.memOut238(memOut238),
		.memOut239(memOut239),
		.memOut240(memOut240),
		.memOut241(memOut241),
		.memOut242(memOut242),
		.memOut243(memOut243),
		.memOut244(memOut244),
		.memOut245(memOut245),
		.memOut246(memOut246),
		.memOut247(memOut247),
		.memOut248(memOut248),
		.memOut249(memOut249),
		.memOut250(memOut250),
		.memOut251(memOut251),
		.memOut252(memOut252),
		.memOut253(memOut253),
		.memOut254(memOut254),
		.memOut255(memOut255)
	);
	  
	integer num_iter = 0;
	always #(tck/2) clk <= ~clk; // clocking device
	  
	initial begin
		$dumpfile("Data_Memory_ah.vcd"); 
		$dumpvars (-1, dut);
	end

	initial begin
		clk = 0; MR = 0; MW = 0;
		Addr = 32'd0;
		WD = 32'd0;
	end
	
	always @(posedge clk) begin
		MR  = $random(seed);
		MW  = $random(seed);
		WD  = $random(seed);
		Addr = $random(seed);

		num_iter = num_iter + 1;
	end
	
	always @(negedge clk) begin
		if (num_iter > 5000)
			$finish;
	end
  
endmodule
