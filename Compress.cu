#include <stdio.h>
#include <cuda.h>
#include <time.h>
#include "FileContents.h"

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

struct CharacterFrequency{
    char character = 0;
    int frequency = 0;
};

int cmp(const void *a, const void *b){
    return ((CharacterFrequency *)b)->frequency - ((CharacterFrequency *)a)->frequency;
}

int main(int argc, char** argv){
    FileContents f = LoadFile("lotr.txt");
    //printFileContents(f);
    printf("\nFile is %ld bytes long\n", f.length);

    //int hashmap[256];
    CharacterFrequency hashmap[256];



    for (int i = 0; i < f.length; i++){
        char letter = f.buffer[i];
        hashmap[letter].character=letter;
        hashmap[letter].frequency++;
    }


    qsort(hashmap, 256, sizeof(CharacterFrequency), cmp);

    for (int i = 0; i < 256; i++){
        if (hashmap[i].frequency > 0){
            printf(" %c %d \n", hashmap[i].character, hashmap[i].frequency);
        }
    }

    /*
    int bytesUsed = 0;
    int columnwidth = 15;
    for (int i = 0; i < 256; i++){
        if (hashmap[i] != 0){
            bytesUsed++;
            printf("%c: %d, ", i, hashmap[i]);
            if (bytesUsed%10 == 0) printf("\n");
        }
    }*/

    //printf("\n\nElements in Hashmap Used: %d / 256\n", bytesUsed);
}