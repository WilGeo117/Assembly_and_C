EXECUTABLE=Starter_Call_c_x32

all:
	nasm -f elf32 starter_call_x32.asm -o starter_call_x32.o -l starter.lst
	gcc -m32 starter_call_x32.o -o $(EXECUTABLE)
	./$(EXECUTABLE)

#Clean folder
clean:
	rm -rf *o *.lst $(EXECUTABLE)