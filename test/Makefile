
FLAGS  = -g -Os

all: executable

# compile x86 program
executable: vulnerable.c Makefile
	@gcc $(FLAGS) -o vulnerable vulnerable.c

# compile object-file for AVR program and dump assembly code
dump:
	@avr-gcc $(FLAGS) -c -o vulnerable.o vulnerable.c
	@avr-objdump -d -r vulnerable.o > vulnerable.dump

clean:
	@rm -f *.o *.dump vulnerable
