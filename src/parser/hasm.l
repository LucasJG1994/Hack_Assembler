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

"A"								{ return A;		};
"M"								{ return M;		};
"D"								{ return D;		};
"AM"							{ return AM;	};
"AD"							{ return AD;	};
"MD"							{ return MD;	};
"AMD"							{ return AMD;	};

"JGT"							{ return JGT;	};
"JEQ"							{ return JEQ;	};
"JGE"							{ return JGE;	};
"JLT"							{ return JLT;	};
"JNE"							{ return JNE;	};
"JLE"							{ return JLE;	};
"JMP"							{ return JMP;	};

"R0"							{ return R0;  };
"R1"							{ return R1;  };
"R2"							{ return R2;  };
"R3"							{ return R3;  };
"R4"							{ return R4;  };
"R5"							{ return R5;  };
"R6"							{ return R6;  };
"R7"							{ return R7;  };
"R8"							{ return R8;  };
"R9"							{ return R9;  };
"R10"							{ return R10; };
"R11"							{ return R11; };
"R12"							{ return R12; };
"R13"							{ return R13; };
"R14"							{ return R14; };
"R15"							{ return R15; };

"SP"							{ return SP;	 };
"LCL"							{ return LCL;	 };
"ARG"							{ return ARG;	 };
"THIS"							{ return THIS;	 };
"THAT"							{ return THAT;	 };
"SCREEN"						{ return SCREEN; };
"KBD"							{ return KBD;	 };

"0"								{ return ZERO;								};
"1"								{ return ONE;								};
[0-9]+							{ yylval.ival = atoi(yytext); return NUM;	};
[a-zA-Z_][a-zA-Z0-9_\.$]*		{ yylval.sval = yytext; return ID;			};
[\n\r]							{ line++;									};
[ \t]							{ /*pass*/									};
"//".*\n						{ /*pass*/line++;							};

.								{ printf("Unknown Character %s...\n", yytext); };
