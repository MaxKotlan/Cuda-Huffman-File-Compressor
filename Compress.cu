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

void getBinary(int n)
{
	int loop;
	/*loop=15 , for 16 bits value, 15th bit to 0th bit*/
    bool preceding = false;
    for(loop=15; loop>=0; loop--)
	{
		if( (1 << loop) & n){
            preceding = true;
            printf("1");
        }else if(preceding || (n==0 && loop ==0)){
            //if (preceding)
            printf("0");
        }
	}
}

int getBitCount(int n){
	/*loop=15 , for 16 bits value, 15th bit to 0th bit*/
    bool preceding = false;
    int count = 0;
    for(int loop=15; loop>=0; loop--)
	{
		if( (1 << loop) & n){
            preceding = true;
            count++;
            //printf("1");
        }else if(preceding || (n==0 && loop ==0)){
            //if (preceding)
            count++;
            //printf("0");
        }
    }
    return count;
}

int main(int argc, char** argv){
    FileContents f = LoadFile("lotr.txt");
    //printFileContents(f);
    printf("\nFile is %ld bytes long\n", f.length);

    //int hashmap[256];
    CharacterFrequency hashmap[256];

    for (int i = 0; i < f.length; i++){
        unsigned char letter = f.buffer[i];
        hashmap[letter].character=letter;
        hashmap[letter].frequency++;
    }
    qsort(hashmap, 256, sizeof(CharacterFrequency), cmp);

    //int frequencyTree[256*2 - 1];

    int freqencyIndex[256];

    for (int i = 0; i < 256; i++){
        //freqencyIndex[hashmap[i].character] = 0;
        if (hashmap[i].frequency > 0){
            //getBinary(i);
            freqencyIndex[hashmap[i].character] = i;
            //printf(" ");
            //printf(" %c %d \n", hashmap[i].character, hashmap[i].frequency);
        }
    }

    int compressedBits = 0;
    for (int i = 0; i < f.length; i++){
        unsigned char letter = f.buffer[i];
        compressedBits += getBitCount(freqencyIndex[letter]);
        //printf(" ");
    }

    printf("Compressed Bits: %d. Compressed Bytes: %d. Perentage: %f\n", compressedBits, compressedBits/8+1, (float)(compressedBits/8+1) / (float)f.length);

    //int frequencyTree[256*2 - 1];
    //for ()

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