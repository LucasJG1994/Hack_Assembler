#include "label.h"
#include <map>
#include <vector>
#include <string>
#include <iostream>

static std::map<std::string, int> LABEL;
static std::map<std::string, int> VAR;
std::vector<std::string> ID;

#define FIND(M, K) M.find(K) != M.end()
#define DEL(M, K) M.erase(K)

extern bool second_pass;

extern "C" {

void label_add(const char* key, int data){
	std::string k(key);
	if(FIND(LABEL, k)) return;
	
	if(!second_pass){
		auto it = ID.begin();
		while (it != ID.end()) {
			if (k == *it) {
				ID.erase(it);
				break;
			}
			it++;
		}
	}

	LABEL[k] = data;
}

int label_get(const char* key){
	std::string k(key);
	if(FIND(LABEL, k)) return LABEL[k];

	if (second_pass) {
		for (int i = 0; i < ID.size(); i++) {
			if(k == ID[i]) return 16 + i;
		}
		return 0;
	}

	for (int i = 0; i < ID.size(); i++) {
		if(k == ID[i]) return 0;
	}
	ID.push_back(k);
	return 0;
}

}