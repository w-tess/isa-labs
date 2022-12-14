/* Dadda Tree module
 * It performs the multioperand additions
 * in a CSA-style and provides two unsigned 
 * numbers for the final addition
 */

`include "comp_5_3.sv"

module dadda_tree (
	output logic [1:0][47:0] lev0,
	input wire logic [8:0][47:0] lev4 
);

	logic [5:0][47:0] lev3;
	logic [3:0][47:0] lev2;
	logic [2:0][47:0] lev1;

	/********************** FOURTH LEVEL **********************/

	// (5,3) compressors instantiated as arrays
	comp_5_3 comp_5_3_level4[11:0] (
		.a   (lev4[0][32:21]),
		.b   (lev4[1][32:21]),
		.c   (lev4[2][32:21]),
		.d   (lev4[3][32:21]),
		.tin (lev4[4][32:21]),
		.sum (lev3[0][32:21]),
		.tout(lev3[1][33:22]),
		.cout(lev3[2][33:22])
	);

	// full-adders instantiated as arrays
	fa fa_level4[11:0] (
		.cin ({lev4[0][35:33], lev4[5][29:24], lev4[0][20:18]}),
		.a   ({lev4[1][35:33], lev4[6][29:24], lev4[1][20:18]}),
		.b   ({lev4[2][35:33], lev4[7][29:24], lev4[2][20:18]}),
		.sum ({lev3[0][35:33], lev3[3][29:24], lev3[0][20:18]}),
		.cout({lev3[1][36:34], lev3[4][30:25], lev3[1][21:19]})
	);

	// half-adders instantiated as arrays
	ha ha_level4[14:0] (
		.a   ({
			lev4[0][37:36],	lev4[3][34:33],
			lev4[5][31:30],	lev4[5][23:21],
			lev4[3][20:18],	lev4[0][17:15]
		}),
		.b   ({
			lev4[1][37:36],	lev4[4][34:33],
			lev4[6][31:30],	lev4[6][23:21],
			lev4[4][20:18],	lev4[1][17:15]
		}),
		.sum ({
			lev3[0][37:36],	lev3[3][34:33],
			lev3[3][31:30],	lev3[3][23:21],
			lev3[3][20:18],	lev3[0][17:15]
		}),
		.cout({
			lev3[1][38:37],	lev3[4][35:34],
			lev3[4][32:31],	lev3[4][24:22],
			lev3[4][21:19],	lev3[1][18:16]
		})
	);

	/* Continuous assignments to provide dots
	 * not yet processed by combo logic to the
	 * lower level
	 */
	assign {lev3[5][47:39], lev3[4][47:39], 
			lev3[3][47:39], lev3[2][47:39],
			lev3[1][47:39], lev3[0][47:39]} = 
		   {lev4[5][47:39], lev4[4][47:39],
		    lev4[3][47:39], lev4[2][47:39],
			lev4[1][47:39], lev4[0][47:39]};
	assign {lev3[5][38], lev3[4][38], lev3[3][38],
			lev3[2][38], lev3[0][38]} = 
		   {lev4[4][38], lev4[3][38], lev4[2][38],
		   	lev4[1][38], lev4[0][38]};
	assign {lev3[5][37:36], lev3[4][37:36],
			lev3[3][37:36], lev3[2][37:36]} = 
		   {lev4[5][37:36], lev4[4][37:36],
		    lev4[3][37:36], lev4[2][37:36]};
	assign {lev3[5][35], lev3[3][35], lev3[2][35]} = 
		   {lev4[5][35], lev4[4][35], lev4[3][35]};
	assign {lev3[5][34], lev3[5][33], lev3[5][32],
			lev3[2][34], lev3[4][33], lev3[3][32]} = 
		   {lev4[6][34:32], lev4[5][34:32]};
	assign 	lev3[5][31:22] = {lev4[7][31:30], 
			lev4[8][29:24], lev4[7][23:22]};
	assign {lev3[5][21], lev3[2][21]} = 
		   {lev4[8][21], lev4[7][21]};
	assign {lev3[5][20:19], lev3[2][20:19]} = 
		   {lev4[6][20:19], lev4[5][20:19]};
	assign {lev3[5][18], lev3[4][18], lev3[2][18]} =  
		   {lev4[7][18], lev4[6][18], lev4[5][18]};
	assign {lev3[5][17:15], lev3[4][17:15],
			lev3[3][17:15], lev3[2][17:15]} = 
		   {lev4[5][17:15], lev4[4][17:15],
		    lev4[3][17:15], lev4[2][17:15]};
	assign  lev3[1][15]	= lev4[6][15];
	assign {lev3[5][14:0], lev3[4][14:0],
			lev3[3][14:0], lev3[2][14:0],
			lev3[1][14:0], lev3[0][14:0]} = 
		   {lev4[5][14:0], lev4[4][14:0],
		    lev4[3][14:0], lev4[2][14:0],
			lev4[1][14:0], lev4[0][14:0]};

	/********************** THIRD  LEVEL **********************/

	comp_5_3 comp_5_3_level3[23:0] (
		.a   (lev3[0][38:15]),
		.b   (lev3[1][38:15]),
		.c   (lev3[2][38:15]),
		.d   (lev3[3][38:15]),
		.tin (lev3[4][38:15]),
		.sum (lev2[0][38:15]),
		.tout(lev2[1][39:16]),
		.cout(lev2[2][39:16])
	);

	fa fa_level3[5:0] (
		.cin ({lev3[0][41:39], lev3[0][14:12]}),
		.a   ({lev3[1][41:39], lev3[1][14:12]}),
		.b   ({lev3[2][41:39], lev3[2][14:12]}),
		.sum ({lev2[0][41:39], lev2[0][14:12]}),
		.cout({lev2[1][42:40], lev2[1][15:13]})
	);

	ha ha_level3[9:0] (
		.a   ({
			lev3[0][43:42],	lev3[3][40:39],
			lev3[3][14:12],	lev3[0][11:9]
		}),
		.b   ({
			lev3[1][43:42], lev3[4][40:39],
			lev3[4][14:12],	lev3[1][11:9]
		}),
		.sum ({
			lev2[0][43:42],	lev2[2][40],
			lev2[3][39],    lev2[2][14:12],
			lev2[0][11:9]
		}),
		.cout({
			lev2[1][44:43],	lev2[3][41:40],
			lev2[3][15:13],	lev2[1][12:10]
		})
	);

	assign {lev2[3][47:45], lev2[2][47:45],
			lev2[1][47:45], lev2[0][47:45]} = 
		   {lev3[3][47:45], lev3[2][47:45],
		    lev3[1][47:45], lev3[0][47:45]};
	assign {lev2[3][44], lev2[2][44], lev2[0][44]} = 
		   {lev3[2][44], lev3[1][44], lev3[0][44]};
	assign {lev2[3][43:42], lev2[2][43:42]} = 
		   {lev3[3][43:42], lev3[2][43:42]};
	assign  lev2[2][41] = lev3[3][41];
	assign {lev2[3][38:16],	lev2[2][15]} = 
			lev3[5][38:15];
	assign  lev2[3][12] = lev3[5][12];
	assign {lev2[3][11:9], lev2[2][11:9]} = 
		   {lev3[3][11:9], lev3[2][11:9]};
	assign  lev2[1][9] = lev3[4][9];
	assign {lev2[3][8:0], lev2[2][8:0],
		    lev2[1][8:0], lev2[0][8:0]} = 
		   {lev3[3][8:0], lev3[2][8:0],
		    lev3[1][8:0], lev3[0][8:0]};

	/********************** SECOND LEVEL **********************/

	fa fa_level2[35:0] (
		.cin (lev2[0][44:9]),
		.a   (lev2[1][44:9]),
		.b   (lev2[2][44:9]),
		.sum (lev1[0][44:9]),
		.cout(lev1[1][45:10])
	);

	ha ha_level2[4:0] (
		.a   ({lev2[0][46:45], lev2[0][8:6]}),
		.b   ({lev2[1][46:45], lev2[1][8:6]}),
		.sum ({lev1[0][46:45], lev1[0][8:6]}),
		.cout({lev1[1][47:46], lev1[1][9:7]})
	);

	assign {lev1[2][47], lev1[0][47]} =
		   {lev2[1][47], lev2[0][47]};
	assign  lev1[2][46:6] = {lev2[2][46:45],
			lev2[3][44:9], lev2[2][8:6]};
	assign  lev1[1][6] = lev2[3][6];
	assign {lev1[2][5:0], lev1[1][5:0], lev1[0][5:0]} = 
		   {lev2[2][5:0], lev2[1][5:0], lev2[0][5:0]};

	/********************** FIRST  LEVEL **********************/
	
	logic last_cout; // cout of last fa is ignored

	fa fa_level1[41:0] (
		.cin (lev1[0][47:6]),
		.a   (lev1[1][47:6]),
		.b   (lev1[2][47:6]),
		.sum (lev0[0][47:6]),
		.cout({last_cout, lev0[1][47:7]})
	);

	ha ha_level1[2:0] (
		.a   (lev1[0][5:3]),
		.b   (lev1[1][5:3]),
		.sum (lev0[0][5:3]),
		.cout(lev0[1][6:4])
	);

	assign lev0[1][3] = lev1[2][3];
	assign lev0[1][2:0] = lev1[1][2:0];
	assign lev0[0][2:0] = lev1[0][2:0];

endmodule