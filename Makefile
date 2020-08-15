#TARGET = hello

#all: $(TARGET)
#
#$(TARGET).o: hello.asm
#	nasm -f elf64 hello.asm -o hello.o

#hello: OBJECTS .o
#	ld -o hello hello.o

AFLAGS = -s -f elf32
LIBS   = -m32
TARGET = hello
OBJFILES = \
	hello.o

all: $(TARGET)

$(TARGET): $(OBJFILES)
	gcc -o $(TARGET) $(OBJFILES) $(LIBS)

%.o: %.asm
	nasm -o $@ $< $(AFLAGS)

clean:
	rm -f $(OBJFILES) $(TARGET)
