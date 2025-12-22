#include <stddef.h>

#ifndef WORKSPACES_PUZZLE_BOX_LIB_C_PB_HELPERS_H
#define WORKSPACES_PUZZLE_BOX_LIB_C_PB_HELPERS_H

char* any(int num);
int pb_cmp_asc(const void *a, const void *b);
void pb_scanf(const char *input, const char *format, ...);
void pb_memset(void *ptr, int value, size_t num);

#endif /* WORKSPACES_PUZZLE_BOX_LIB_C_PB_HELPERS_H */
