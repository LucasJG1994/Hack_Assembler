@echo off
bison -d hasm.y
flex --nounistd --header-file=lex.yy.h hasm.l
pause
@echo on