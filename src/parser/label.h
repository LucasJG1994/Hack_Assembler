#ifndef __map__h
#define __map__h

#if __cplusplus
extern "C" {
#endif

void label_add(const char* key, int data);
int  label_get(const char* key, int* data);

#if __cplusplus
}
#endif

#endif