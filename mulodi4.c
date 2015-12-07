#include "int_lib.h"

di_int __mulodi4(di_int a, di_int b, int* overflow) {
	*overflow = 0;
	return a * b;
}
