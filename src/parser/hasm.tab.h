/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_HASM_TAB_H_INCLUDED
# define YY_YY_HASM_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     A = 258,
     M = 259,
     D = 260,
     AD = 261,
     AM = 262,
     MD = 263,
     AMD = 264,
     AT = 265,
     LP = 266,
     RP = 267,
     EQ = 268,
     SEMI = 269,
     ADD = 270,
     SUB = 271,
     AND = 272,
     OR = 273,
     NOT = 274,
     JGT = 275,
     JEQ = 276,
     JGE = 277,
     JLT = 278,
     JNE = 279,
     JLE = 280,
     JMP = 281,
     R0 = 282,
     R1 = 283,
     R2 = 284,
     R3 = 285,
     R4 = 286,
     R5 = 287,
     R6 = 288,
     R7 = 289,
     R8 = 290,
     R9 = 291,
     R10 = 292,
     R11 = 293,
     R12 = 294,
     R13 = 295,
     R14 = 296,
     R15 = 297,
     SP = 298,
     LCL = 299,
     ARG = 300,
     THIS = 301,
     THAT = 302,
     KBD = 303,
     SCREEN = 304,
     _EOF_ = 305,
     ZERO = 306,
     ONE = 307,
     NUM = 308,
     ID = 309
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 14 "hasm.y"

	int ival;
	char* sval;


/* Line 2058 of yacc.c  */
#line 117 "hasm.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_HASM_TAB_H_INCLUDED  */
