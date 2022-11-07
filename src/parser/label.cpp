#include "label.h"
#include <map>
#include <queue>
#include <string>
#include <iostream>

static std::map<std::string, int> LABEL;
static std::map<std::string, int> VAR;
static std::queue<int> USED_VAR;

#define FIND(M, K) M.find(K) != M.end()
#define DEL(M, K) M.erase(K)
#define PUSH(I) USED_VAR.push(I)
#define POP USED_VAR.front(); USED_VAR.pop()

extern "C" {

void label_add(const char* key, int data){
	std::string k(key);
	k.pop_back();
	if(FIND(LABEL, k)) return;
	if(FIND(VAR, k)){
		PUSH(VAR[k]);
		DEL(VAR, k);
		LABEL[k] = data;
		return;
	}
	
	LABEL[k] = data;
}

int label_get(const char* key, int* data){
	std::string k(key);
	if(FIND(LABEL, k)) return LABEL[k];
	if(FIND(VAR, k)) return VAR[k];

	if(!USED_VAR.empty()){
		VAR[k] = USED_VAR.front(); - 1;
		USED_VAR.pop();
		return VAR[k];
	}

	VAR[k] = *data;
	(*data)++;
	std::cout << "KEY: " << k << " " << VAR[k] << std::endl;
	return VAR[k];
}

}