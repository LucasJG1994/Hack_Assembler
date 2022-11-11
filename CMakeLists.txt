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
	${hasm_SOURCE_DIR}/src/parser/file_writer.c
	${hasm_SOURCE_DIR}/src/parser/hasm.tab.c
	${hasm_SOURCE_DIR}/src/parser/scanner.cpp

	${hasm_SOURCE_DIR}/src/parser_init.h
	${hasm_SOURCE_DIR}/src/parser/hasm.tab.h
	${hasm_SOURCE_DIR}/src/parser/hasm.l
	${hasm_SOURCE_DIR}/src/parser/hasm.y
	${hasm_SOURCE_DIR}/src/parser/label.h
	${hasm_SOURCE_DIR}/src/parser/scanner.h
)

