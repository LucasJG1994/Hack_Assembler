#Cmake version
cmake_minimum_required(VERSION 2.8.11)
project(hasm)

include_directories(
	src/parser
	src
)

add_executable(hasm
	${hasm_SOURCE_DIR}/src/main.cpp
	${hasm_SOURCE_DIR}/src/parser/label.cpp
	${hasm_SOURCE_DIR}/src/custom_string.c
	${hasm_SOURCE_DIR}/src/parser/file_writer.c
	${hasm_SOURCE_DIR}/src/parser/lex.yy.c
	${hasm_SOURCE_DIR}/src/parser/hasm.tab.c
)

