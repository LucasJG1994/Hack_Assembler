#include "file_writer.h"
#include <stdio.h>

static FILE* fp;

void fw_init(){
	fp = fopen("hack.bin", "wb");
	if(fp == NULL) return;
}

void fw_write(char byte){
	if(fp == NULL) return;
	fputc(byte, fp);
}

void fw_close(){
	if(fp == NULL) return;
	fclose(fp);
}