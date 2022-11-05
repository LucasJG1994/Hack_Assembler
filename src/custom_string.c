#include "custom_string.h"
#include <stdlib.h>
#include <string.h>

void cs_copy(char* s1, char* s2){
	if(s1 != NULL) free(s1);
	s1 = (char*)calloc(strlen(s2), sizeof(char));
	if(s1 == NULL) return;
	strcpy(s1, s2);
}