%{
	#include "parser_init.h"
	#include "lex.yy.h"
	#include "file_writer.h"
	#include "label.h"
	
	#include <stdio.h>
	
	int line;
	int var_count;
	int op_count;
%}

%union{
	int ival;
	char* sval;
}

%token A M D AD AM MD AMD AT LP RP
%token EQ SEMI ADD SUB AND OR NOT
%token JGT JEQ JGE JLT JNE JLE JMP
%token R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15
%token SP LCL ARG THIS THAT KBD SCREEN
%token TEMP0 TEMP1 TEMP2 TEMP3 TEMP4 TEMP5 TEMP6 TEMP7
%token <ival> ZERO 
%token <ival> ONE
%token <ival> NUM
%token <sval> ID

%type <ival> start
%type <ival> expr
%type <ival> dst
%type <ival> cmp
%type <ival> jmp

%%

start:							{}
		| start expr			{ fw_write(($2 & 0xFF00) >> 8); fw_write($2 & 0xFF); }
		;

expr:	  dst EQ cmp			{ $$ = (($1 << 3) | ($3 << 6)) | (7 << 13); op_count+=2;	}
		| dst EQ cmp SEMI jmp	{ $$ = (($1 << 3) | ($3 << 6) | $5) | (7 << 13); op_count+=2;}
		| cmp SEMI jmp			{ $$ = (($1 << 6) | $3) | (7 << 13); op_count+=2;			}
		| AT NUM 				{ $$ = $2; op_count+=2;										}
		| AT ZERO				{ $$ = 0 ; op_count+=2;										}
		| AT ONE				{ $$ = 1 ; op_count+=2;										}
		| AT SP					{ $$ = 0;													}
		| AT LCL				{ $$ = 1;													}
		| AT ARG				{ $$ = 2;													}
		| AT THIS				{ $$ = 3;													}
		| AT THAT				{ $$ = 4;													}
		| AT R0					{ $$ = 0;													}
		| AT R1					{ $$ = 1;													}
		| AT R2					{ $$ = 2;													}
		| AT R3					{ $$ = 3;													}
		| AT R4					{ $$ = 4;													}
		| AT R5					{ $$ = 5;													}
		| AT R6					{ $$ = 6;													}
		| AT R7					{ $$ = 7;													}
		| AT R8					{ $$ = 8;													}
		| AT R9					{ $$ = 9;													}
		| AT R10				{ $$ = 10;													}
		| AT R11				{ $$ = 11;													}
		| AT R12				{ $$ = 12;													}
		| AT R13				{ $$ = 13;													}
		| AT R14				{ $$ = 14;													}
		| AT R15				{ $$ = 15;													}
		| AT SCREEN				{ $$ = 16384;												}
		| AT KBD				{ $$ = 24576;												}
		| AT TEMP0				{ $$ = 5;													}
		| AT TEMP1				{ $$ = 6;													}
		| AT TEMP2				{ $$ = 7;													}
		| AT TEMP3				{ $$ = 8;													}
		| AT TEMP4				{ $$ = 9;													}
		| AT TEMP5				{ $$ = 10;													}
		| AT TEMP6				{ $$ = 11;													}
		| AT TEMP7				{ $$ = 12;													}
		| AT ID					{ $$ = label_get($2, var_count++); op_count+=2;				}
		| LP ID RP				{ label_add($2, op_count); printf("(%s)\n", $2);			}
		;

dst:	  A						{ $$ = 0b0100; }
		| M						{ $$ = 0b0001; }
		| D						{ $$ = 0b0010; }
		| AM					{ $$ = 0b0101; }
		| AD					{ $$ = 0b0110; }
		| MD					{ $$ = 0b0011; }
		| AMD					{ $$ = 0b0111; }
		;
		
cmp:	  ZERO 					{ $$ = 0b101010 ; }
        | ONE					{ $$ = 0b111111 ; }
        | SUB ONE				{ $$ = 0b111010 ; }
        | D						{ $$ = 0b001100 ; }
        | A						{ $$ = 0b110000 ; }
        | M						{ $$ = 0b1110000; }
        | NOT D					{ $$ = 0b001101 ; }
        | NOT A					{ $$ = 0b110001 ; }
        | NOT M					{ $$ = 0b1110001; }
        | SUB D					{ $$ = 0b001111 ; }
        | SUB A					{ $$ = 0b110011 ; }
        | SUB M					{ $$ = 0b1110011; }
        | D ADD ONE				{ $$ = 0b011111 ; }
        | A ADD ONE				{ $$ = 0b110111 ; }
        | M ADD ONE				{ $$ = 0b1110111; }
        | D SUB ONE				{ $$ = 0b001110 ; }
        | A SUB ONE				{ $$ = 0b110010 ; }
        | M SUB ONE				{ $$ = 0b1110010; }
        | D ADD A				{ $$ = 0b000010 ; }
        | D ADD M				{ $$ = 0b1000010; }
        | D SUB A				{ $$ = 0b010011 ; }
        | D SUB M				{ $$ = 0b1010011; }
        | A SUB D				{ $$ = 0b000111 ; }
        | M SUB D				{ $$ = 0b1000111; }
        | D AND A				{ $$ = 0b000000 ; }
        | D AND M				{ $$ = 0b1000000; }
        | D OR A				{ $$ = 0b010101 ; }
        | D OR M				{ $$ = 0b1010101; }
		;
		
jmp:	  JGT					{ $$ = 0b0001; }
		| JEQ					{ $$ = 0b0010; }
		| JGE					{ $$ = 0b0011; }
		| JLT					{ $$ = 0b0100; }
		| JNE					{ $$ = 0b0101; }
		| JLE					{ $$ = 0b0110; }
		| JMP					{ $$ = 0b0111; }
		;

%%

void parser_init(const char* buffer){
	fw_init();

	line = 0;
	op_count = 2;
	var_count = 16;
	
	yy_scan_string(buffer);
	yyparse();
	
	fw_close();
}

int yyerror(const char* msg){
	printf("%s (%s) (%d)\n", msg, yytext, line);
	return 0;
}