AS=nasm #Assembly Compiler
ASFLAGS=-f elf64 -g -l starter.lst #Assembly flags 64 Bit (create linux elf)
LD=ld #Lmainker
LDFLAGS= #Linker flags
SOURCES=$(wildcard ./*.asm) #Sources
OBJECTS=$(SOURCES:.asm=.o) #Object files
EXECUTABLE=Project_II

#Check version
all:$(SOURCES) $(EXECUTABLE)

#Create executable
$(EXECUTABLE): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $@
	./${EXECUTABLE}

#Compile assembly program
$(OBJECTS): $(SOURCES)
	@clear
	$(AS) $(ASFlAGS) $(SOURCES)

#Clean folder
clean:
	rm -rf *o *.lst $(EXECUTABLE)
