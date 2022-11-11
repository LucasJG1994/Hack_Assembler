#include "scanner.h"
#include <stdio.h>
#include <iostream>
#include <regex>
#include <string>
#include <vector>
#include <map>

extern "C" {
#include "hasm.tab.h"
extern int line;
}

static char* curr;
static char* begin;
static char* source;

std::string yytext;

static std::map<std::string, int> keyword = {
	{"A", A},	{"a", A},
	{"D", D},	{"d", D},
	{"M", M},	{"m", M},
	{"AM",AM},	{"am",AM},
	{"AD",AD},	{"ad",AD},
	{"MD",MD},	{"md",MD},
	{"AMD",AMD},{"amd",AMD},
	
	{"JGT", JGT}, {"jgt", JGT},
	{"JEQ", JEQ}, {"jeq", JEQ},
	{"JGE", JGE}, {"jge", JGE},
	{"JLT", JLT}, {"jlt", JLT},
	{"JNE", JNE}, {"jne", JNE},
	{"JLE", JLE}, {"jle", JLE},
	{"JMP", JMP}, {"jmp", JMP},

	{"R0", R0},   {"r0", R0},
	{"R1", R1},   {"r1", R1},
	{"R2", R2},   {"r2", R2},
	{"R3", R3},   {"r3", R3},
	{"R4", R4},   {"r4", R4},
	{"R5", R5},   {"r5", R5},
	{"R6", R6},   {"r6", R6},
	{"R7", R7},   {"r7", R7},
	{"R8", R8},   {"r8", R8},
	{"R9", R9},   {"r9", R9},
	{"R10", R10}, {"r10", R10},
	{"R11", R11}, {"r11", R11},
	{"R12", R12}, {"r12", R12},
	{"R13", R13}, {"r13", R13},
	{"R14", R14}, {"r14", R14},
	{"R15", R15}, {"r15", R15},

	{"SP", SP},			{"sp", SP},
	{"LCL", LCL},		{"lcl", LCL},
	{"ARG", ARG},		{"arg", ARG},
	{"THIS", THIS},		{"this", THIS},
	{"THAT", THAT},		{"that", THAT},
	{"SCREEN", SCREEN},	{"screen", SCREEN},
	{"KBD", KBD},		{"kbd", KBD},

	{"0", ZERO}, {"1", ONE}
};

static std::vector<const char*> str_pool;

void yyinit(const char* file_name) {
	FILE* fp;
	size_t length;
	if(fopen_s(&fp, file_name, "rb") != 0){
		fp = nullptr;
		return;
	}

	fseek(fp, 0L, SEEK_END);
	length = ftell(fp);
	fseek(fp, 0L, SEEK_SET);

	source = new char[length + 1]{0};
	if (source == nullptr) {
		fclose(fp);
		return;
	}

	fread(source, sizeof(char), length, fp);
	fclose(fp);
	curr = source;
	begin = source;
}

void yyrestart(){
	curr = source;
	begin = source;
}

void yydestroy() {
	if(source != nullptr) delete[] source;
	source = nullptr;
	curr = nullptr;
	begin = nullptr;
	if (!str_pool.empty()) {
		const char* tmp = str_pool.front();
		str_pool.pop_back();
		delete[] tmp;
	}
}

void yyadv() {
	curr++;
}

bool is_digit(char c) {
	return c >= '0' && c <= '9';
}

bool is_alpha(char c) {
	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_' || c == '.' || c == '$';
}

void yy_lex() {
	while(is_digit(*curr) || is_alpha(*curr)) yyadv();
	yytext = std::string(begin, curr - begin);
}

bool yy_valid_id(std::string s) {
	return std::regex_match(s, std::regex("[a-zA-Z][a-zA-Z0-9_\\.\\$]*"));
}

bool yy_valid_num(std::string s) {
	return std::regex_match(s, std::regex("[0-9]+"));
}

int yylex(){
	yytext = "";
	while (*curr != 0) {
		switch (*curr) {
			case '=': { yyadv(); return EQ; }
			case ';': { yyadv(); return SEMI; }
			case '+': { yyadv(); return ADD; }
			case '-': { yyadv(); return SUB; }
			case '&': { yyadv(); return AND; }
			case '|': { yyadv(); return OR;  }
			case '!': { yyadv(); return NOT; }
			case '(': { yyadv(); return LP; }
			case ')': { yyadv(); return RP; }
			case '@': { yyadv(); return AT; }

			case '/':
				if(curr[1] == '/')
					while (curr[1] != '\n' && curr[1] != 0) yyadv();
				break;
			case ' ': break;
			case '\t': break;
			case '\r': 
			case '\n': line++; break;
			default: {
				begin = curr;
				yy_lex();
				if (keyword.find(yytext) != keyword.end()) {
					char* self = new char[yytext.length() + 1]{0};
					strcpy(self, yytext.c_str());
					yylval.sval = self;
					str_pool.push_back(self);
					return keyword[yytext];
				}
				else if (yy_valid_num(yytext)) {
					yylval.ival = std::atoi(yytext.c_str());
					return NUM;
				}
				else if (yy_valid_id(yytext)) {
					char* self = new char[yytext.length() + 1]{0};
					strcpy(self, yytext.c_str());
					yylval.sval = self;
					str_pool.push_back(self);
					return ID;
				}
				else std::cout << "Unkown Character... " << yytext << " (" << line << ")" << std::endl;
			}
		}
		yyadv();
	}
	return 0;
}