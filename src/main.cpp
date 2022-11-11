#include "parser_init.h"
#include "scanner.h"

#include <string>
#include <vector>

#include <iostream>
#include <stdio.h>

extern std::vector<std::string> ID;

bool second_pass = false;

int main(int argc, char** argv){
	if(argc == 2){
		yyinit(argv[1]);
		parser_init();
		yydestroy();

		std::cout << "1st PASS\n";

		second_pass = true;

		yyinit(argv[1]);
		parser_init();
		yydestroy();

		std::cout << "2nd PASS\n";

		std::cout << "Done...\n";
	} //else std::cout << "Usage: hasm <file_name>\n";

	yyinit("Release/Pong.asm");
	parser_init();
	yydestroy();

	std::cout << "1st PASS\n";

	for (int i = 0; i < ID.size(); i++) {
		std::cout << "KEY: " << ID[i] << std::endl;
	}

	second_pass = true;

	yyinit("Release/Pong.asm");
	parser_init();
	yydestroy();

	std::cout << "2nd PASS\n";

	std::cout << "Done...\n";

	return 0;
}