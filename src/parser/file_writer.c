#include "file_writer.h"
#include <stdio.h>

static FILE* fp;
static FILE* fp2;

void fw_init(){
	fp = fopen("hack.bin", "wb");
	if(fp == NULL) return;

	fp2 = fopen("out.hack", "w");
	if(fp2 == NULL) return;
}

void fw_write(char byte){
	if(fp == NULL) return;
	fputc(byte, fp);
}

void fw_write_txt(unsigned short data){
	if(fp2 == NULL) return;

	char bits[17] = { 0 };
	unsigned short table[] = {32768, 16384, 8192, 4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1};

	for(int i = 0; i < 16; i++){
		bits[i] = (table[i] & data) ? '1' : '0';
	}

	fputs(bits, fp2); fputc('\n', fp2);
}

void fw_close(){
	if(fp == NULL) return;
	fclose(fp);

	if(fp2 == NULL) return;
	fclose(fp2);
}