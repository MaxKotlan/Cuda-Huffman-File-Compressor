#ifndef FILE_H
#define FILE_H
#include <stdio.h>
#include <stdlib.h> 

struct FileContents{
    char *buffer;
    unsigned long length;
};


FileContents LoadFile(char *filepath)
{
	FILE *file;
    FileContents contents;

	file = fopen(filepath, "rb");
	if (!file) {
		fprintf(stderr, "Unable to open file %s", filepath);
		exit(1);
	}
	
	fseek(file, 0, SEEK_END);
	contents.length=ftell(file);
	fseek(file, 0, SEEK_SET);

	contents.buffer=(char *)malloc(contents.length+1);
	if (!contents.buffer)
	{
		fprintf(stderr, "Memory error occured when loading %s", filepath);
        fclose(file);
		exit(1);
	}

	fread(contents.buffer, contents.length, 1, file);
	fclose(file);
    return contents;
}

void printFileContents(FileContents contents){
	for (int i = 0; i < contents.length; i++)
		printf("%c", contents.buffer[i]);
}


#endif