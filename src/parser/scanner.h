#ifndef __scanner__h
#define __scanner__h

#if __cplusplus
extern "C" {
#endif

void yyinit(const char* file_name);
void yyrestart();

int yylex();

void yydestroy();

#if __cplusplus
}
#endif

#endif