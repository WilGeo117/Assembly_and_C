EXECUTABLE=Starter_Call_c_x32

all:
# Compile assembly file
	nasm -f elf32 starter_call_x32.asm -o starter_call_x32.o -l starter.lst
# Compile main file
	gcc -m32 -c main.c
# Link
	gcc -m32 main.o starter_call_x32.o -o $(EXECUTABLE)
# Run binary
	./$(EXECUTABLE)

#Clean folder
clean:
	rm -rf *o *.lst $(EXECUTABLE)