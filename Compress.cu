#include <stdio.h>
#include <cuda.h>
#include <time.h>

#include "FileContents.h"
#include "CharacterFrequency.h"
#include "Heap.h"

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

int main(int argc, char** argv){
    FileContents f = LoadFile("lotr.txt");
    //printFileContents(f);
    printf("\nFile is %ld bytes long\n", f.length);

    /*Using a Hashmap, find the frequency of each character in the file*/
    const int hashmapsize = 256;
    CharacterFrequency hashmap[hashmapsize];

    for (int i = 0; i < f.length; i++){
        unsigned char letter = f.buffer[i];
        hashmap[letter].character=letter;
        hashmap[letter].frequency++;
    }

    /*Convert Hashmap into a Heap Using Bottom Up Heap Construction*/
    for (int i = hashmapsize/2 -1; i >= 0; i--){
        int parentIndex = i;
        int leftChildIndex = parentIndex * 2 +1;
        int rightChildIndex = parentIndex * 2 +2;
        
        int compareIndex = leftChildIndex;
        if (rightChildIndex < hashmapsize && hashmap[rightChildIndex].frequency < hashmap[leftChildIndex].frequency)
            compareIndex = rightChildIndex;

        if (hashmap[parentIndex].frequency > hashmap[compareIndex].frequency)
            swap(hashmap[parentIndex], hashmap[compareIndex]);
    }

    FrequencyHeap fh = {hashmap, hashmapsize};
    
    CharacterFrequency freq = RemoveMinimumFrequencyFromHeap(fh);
    while (fh.lastElementIndex > 0) {
        //printf("%d ", freq.frequency);
        RemoveMinimumFrequencyFromHeap(fh);
    };
    //RemoveMinimumFrequencyFromHeap(fh);
    //printf("Removed %d \n", RemoveMinimumFrequencyFromHeap(fh).frequency);

    //
    //for (int i = 0; i < fh.lastElementIndex; i++){
    //    printf("%d ", fh.elements[i].frequency);
    //}
}