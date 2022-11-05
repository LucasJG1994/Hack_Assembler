#include "parser_init.h"
#include <iostream>
#include <stdio.h>

int main(int argc, char** argv){
	if(argc == 2){
		FILE* fp;
		if(fopen_s(&fp, argv[1], "r") != 0){
			std::cout << "Failed to open file " << argv[1] << "...\n";
			return 0;
		}
		
		fseek(fp, 0L, SEEK_END);
		long length = ftell(fp);
		fseek(fp, 0L, SEEK_SET);
		
		char* buffer = new char[length];
		if(buffer == nullptr){
			fclose(fp);
			std::cout << "Failed to allocate memory...\n";
			return 0;
		}
		
		fread(buffer, sizeof(char), length, fp);
		fclose(fp);
		
		buffer[length] = 0;

		//First Pass
		parser_init(buffer);
		//Second Pass
		parser_init(buffer);
		
		delete[] buffer;
		std::cout << "Done...\n";
	} else std::cout << "Usage: hasm <file_name>\n";
	return 0;
}