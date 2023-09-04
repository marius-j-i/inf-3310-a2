
#include <stdio.h>
#include <stdlib.h>

/**
 * @brief Return low confidential computation (supposedly) without leakage from high confidential variables.
 * 
 * @param secret High confidentiality
 * @param public Low confidentiality
 * @return Low confidentiality
 */
int 
vulnerable(int secret, int public) {
	int out = public;
	if(public != 4) {
		out += secret * 0;
	} else {
		/* `out` reveals secret to be odd or even. */
		out += secret & 1; /* equivalent to `+= secret % 2`, but modulo is not a SCF supported operator */
	}
	return out;
}

int 
main(int argc, const char **argv) {
	int secret, public, out;
	
	if(argc < 3) {
		printf("Usage: %s <secret:int> <public:int> \n", argv[0]);
		return 1;
	}
	secret = atoi(argv[1]);
	public = atoi(argv[2]);

	out = vulnerable(secret, public);
	printf("vulnerable(secret=%d, public=%d) -> %d \n", secret, public, out);
	
	return 0;
}
