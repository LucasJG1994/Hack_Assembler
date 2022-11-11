%{
	#include "parser_init.h"
	//#include "lex.yy.h"
	#include "scanner.h"
	#include "file_writer.h"
	#include "label.h"
	
	#include <stdio.h>
	
	int line;
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
%token _EOF_
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
		| start expr			{ if($2 != -1) {fw_write(($2 & 0xFF00) >> 8); fw_write($2 & 0xFF); fw_write_txt($2);} }
		;

expr:	  dst EQ cmp			{ $$ = (($1 << 3) | ($3 << 6)) | (7 << 13); op_count++;		}
		| dst EQ cmp SEMI jmp	{ $$ = (($1 << 3) | ($3 << 6) | $5) | (7 << 13); op_count++;}
		| cmp SEMI jmp			{ $$ = (($1 << 6) | $3) | (7 << 13); op_count++;			}
		| AT NUM 				{ $$ = $2;		op_count++;									}
		| AT ZERO				{ $$ = 0 ;		op_count++;									}
		| AT ONE				{ $$ = 1 ;		op_count++;									}
		| AT SP					{ $$ = 0;		op_count++;									}
		| AT LCL				{ $$ = 1;		op_count++;									}
		| AT ARG				{ $$ = 2;		op_count++;									}
		| AT THIS				{ $$ = 3;		op_count++;									}
		| AT THAT				{ $$ = 4;		op_count++;									}
		| AT R0					{ $$ = 0;		op_count++;									}
		| AT R1					{ $$ = 1;		op_count++;									}
		| AT R2					{ $$ = 2;		op_count++;									}
		| AT R3					{ $$ = 3;		op_count++;									}
		| AT R4					{ $$ = 4;		op_count++;									}
		| AT R5					{ $$ = 5;		op_count++;									}
		| AT R6					{ $$ = 6;		op_count++;									}
		| AT R7					{ $$ = 7;		op_count++;									}
		| AT R8					{ $$ = 8;		op_count++;									}
		| AT R9					{ $$ = 9;		op_count++;									}
		| AT R10				{ $$ = 10;		op_count++;									}
		| AT R11				{ $$ = 11;		op_count++;									}
		| AT R12				{ $$ = 12;		op_count++;									}
		| AT R13				{ $$ = 13;		op_count++;									}
		| AT R14				{ $$ = 14;		op_count++;									}
		| AT R15				{ $$ = 15;		op_count++;									}
		| AT SCREEN				{ $$ = 16384;	op_count++;									}
		| AT KBD				{ $$ = 24576;	op_count++;									}
		| AT ID					{ $$ = label_get($2); op_count++;				}
		| LP ID RP				{ $$ = -1; label_add($2, op_count);							}
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
		| A ADD D				{ $$ = 0b000010 ; }
        | D ADD M				{ $$ = 0b1000010; }
		| M ADD D				{ $$ = 0b1000010; }
        | D SUB A				{ $$ = 0b010011 ; }
        | D SUB M				{ $$ = 0b1010011; }
        | A SUB D				{ $$ = 0b000111 ; }
        | M SUB D				{ $$ = 0b1000111; }
        | D AND A				{ $$ = 0b000000 ; }
		| A AND D				{ $$ = 0b000000 ; }
        | D AND M				{ $$ = 0b1000000; }
		| M AND D				{ $$ = 0b1000000; }
        | D OR A				{ $$ = 0b010101 ; }
		| A OR D				{ $$ = 0b010101 ; }
        | D OR M				{ $$ = 0b1010101; }
		| M OR D				{ $$ = 0b1010101; }
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

void parser_init(){
	fw_init();

	line = 0;
	op_count = 0;
	
	yyparse();

	fw_write(0);
	fw_write(0);

	fw_close();
}

int yyerror(const char* msg){
	printf("%s (%d)\n", msg, line);
	return 0;
}