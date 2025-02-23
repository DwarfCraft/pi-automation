#!/bin/bash
# Set the assembler source and output file names
ASM_SOURCE_FILE="hello-world.asm"
ASM_OUTPUT_FILE="hello-world-asm"

# Assemble the source file
nasm -f elf64 $ASM_SOURCE_FILE -o ${ASM_OUTPUT_FILE}.o

# Link the object file
ld ${ASM_OUTPUT_FILE}.o -o $ASM_OUTPUT_FILE

# Check if the assembly and linking were successful
if [ $? -eq 0 ]; then
    echo "Assembly and linking successful. Running the assembler program..."
    # Run the assembled program
    ./$ASM_OUTPUT_FILE
else
    echo "Assembly or linking failed."
fi