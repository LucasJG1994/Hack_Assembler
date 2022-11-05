%{
	#include "hasm.tab.h"
	extern int line;
%}

%option noyywrap 

%%

"="									{ return EQ;	};
"+"									{ return ADD;	};
"-"									{ return SUB;	};
"&"									{ return AND;	};
"|"									{ return OR;	};
"!"									{ return NOT;	};
";"									{ return SEMI;	};
"("									{ return LP;	};
")"									{ return RP;	};
"@"									{ return AT;	};

"A"|"a"								{ return A;		};
"M"|"m"								{ return M;		};
"D"|"d"								{ return D;		};
"AM"|"am"							{ return AM;	};
"AD"|"ad"							{ return AD;	};
"MD"|"md"							{ return MD;	};
"AMD"|"amd"							{ return AMD;	};

"JGT"|"jgt"							{ return JGT;	};
"JEQ"|"jeq"							{ return JEQ;	};
"JGE"|"jge"							{ return JGE;	};
"JLT"|"jlt"							{ return JLT;	};
"JNE"|"jne"							{ return JNE;	};
"JLE"|"jle"							{ return JLE;	};
"JMP"|"jmp"							{ return JMP;	};

"R0"|"r0"							{ return R0;  };
"R1"|"r1"							{ return R1;  };
"R2"|"r2"							{ return R2;  };
"R3"|"r3"							{ return R3;  };
"R4"|"r4"							{ return R4;  };
"R5"|"r5"							{ return R5;  };
"R6"|"r6"							{ return R6;  };
"R7"|"r7"							{ return R7;  };
"R8"|"r8"							{ return R8;  };
"R9"|"r9"							{ return R9;  };
"R10"|"r10"							{ return R10; };
"R11"|"r11"							{ return R11; };
"R12"|"r12"							{ return R12; };
"R13"|"r13"							{ return R13; };
"R14"|"r14"							{ return R14; };
"R15"|"r15"							{ return R15; };

"TEMP0"|"temp0"						{ return TEMP0; };
"TEMP1"|"temp1"						{ return TEMP1; };
"TEMP2"|"temp2"						{ return TEMP2; };
"TEMP3"|"temp3"						{ return TEMP3; };
"TEMP4"|"temp4"						{ return TEMP4; };
"TEMP5"|"temp5"						{ return TEMP5; };
"TEMP6"|"temp6"						{ return TEMP6; };
"TEMP7"|"temp7"						{ return TEMP7; };

"SP"|"sp"							{ return SP;	 };
"LCL"|"lcl"							{ return LCL;	 };
"ARG"|"arg"							{ return ARG;	 };
"THIS"|"this"						{ return THIS;	 };
"THAT"|"that"						{ return THAT;	 };
"SCREEN"|"screen"					{ return SCREEN; };
"KBD"|"kbd"							{ return KBD;	 };

"0"									{ return ZERO;								};
"1"									{ return ONE;								};
[0-9]+								{ yylval.ival = atoi(yytext); return NUM;	};
[a-zA-Z_\.$][a-zA-Z0-9_\.$]*		{ yylval.sval = yytext; return ID;			};
[\n\r]								{ line++;									};
[ \t]								{ /*pass*/									};
"//".*\n							{ /*pass*/									};

.									{ printf("Unknown Character %s...\n", yytext); };
