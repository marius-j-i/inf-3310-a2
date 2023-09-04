
#include <stdio.h>
#include <stdlib.h>

/* Cannot be static because analyzer needs to see it.
 * static */ int 
vulnerable(int secret, int public) {
	int out = 0;
	if(public != 4) {
		out += secret * 0;
	} else {
		out += secret & 1; /* equivalent to `+= secret % 2` */
	}
	return out;
}

int 
main(int argc, const char **argv) {
	int secret, public, out;
	
	if(argc < 2) {
		printf("Usage: %s <secret:int> <public:int> \n", argv[0]);
		return 1;
	}
	secret = atoi(argv[1]);
	public = atoi(argv[2]);

	out = vulnerable(secret, public);
	printf("vulnerable(secret=%d, public=%d) -> %d \n", secret, public, out);
	
	return 0;
}
