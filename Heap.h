#ifndef HEAP_H
#define HEAP_H
#include "CharacterFrequency.h"

struct FrequencyHeap{
    CharacterFrequency* elements;
    int lastElementIndex;
};

struct HeapNode{
    int parentIndex = 0;
    int leftChildIndex = 1;
    int rightChildIndex = 2;
};

HeapNode getHeapNodeFromIndex(int index){
    return {
        index,
        index*2 + 1,
        index*2 + 2
    };
}


void DownHeapBubbleFromRoot(FrequencyHeap heap){
    HeapNode root = getHeapNodeFromIndex(0);
    int compareIndex;
    do {
    if (root.leftChildIndex < heap.lastElementIndex){
        if (root.rightChildIndex < heap.lastElementIndex)
            compareIndex = heap.elements[root.leftChildIndex].frequency < heap.elements[root.rightChildIndex].frequency ? root.leftChildIndex : root.rightChildIndex;
        else
            compareIndex = root.leftChildIndex;

        
        swap(heap.elements[root.parentIndex], heap.elements[compareIndex]);
        root.parentIndex = compareIndex;
        root.leftChildIndex = compareIndex*2 + 1;
        root.rightChildIndex = compareIndex*2 + 1;
    }
     } while (heap.elements[root.parentIndex].frequency > heap.elements[compareIndex].frequency);
    
}

/*
void DownHeapBubbleFromRoot(FrequencyHeap heap){
    HeapNode root = getHeapNodeFromIndex(0);
    while (root.leftChildIndex < heap.lastElementIndex && heap.elements[root.parentIndex].frequency > heap.elements[compareIndex].frequency){
        printf("%d", heap.elements[root.leftChildIndex] < heap.elements[root.rightChildIndex]);
    }
}*/

CharacterFrequency RemoveMinimumFrequencyFromHeap(FrequencyHeap &heap){
    printf("%d ", heap.elements[0].frequency);

    /*for (int i = 0; i < heap.lastElementIndex; i++){
        printf("%d ", heap.elements[i].frequency);
    }
    printf("\n\n");*/

    swap(heap.elements[0], heap.elements[heap.lastElementIndex]);
    heap.lastElementIndex--;
    DownHeapBubbleFromRoot(heap);


    /*for (int i = 0; i < heap.lastElementIndex; i++){
        printf("%d ", heap.elements[i].frequency);
    }
    printf("\n\n");*/

    return {};
}


#endif