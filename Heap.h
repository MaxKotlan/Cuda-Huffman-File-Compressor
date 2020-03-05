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
    if (root.leftChildIndex < heap.lastElementIndex){
        int compareIndex;
        if (root.rightChildIndex < heap.lastElementIndex)
            compareIndex = heap.elements[root.leftChildIndex].frequency < heap.elements[root.rightChildIndex].frequency ? root.leftChildIndex : root.rightChildIndex;
        else
            compareIndex = root.leftChildIndex;
            
        while (heap.elements[root.parentIndex].frequency > heap.elements[compareIndex].frequency){
            swap(heap.elements[root.parentIndex], heap.elements[compareIndex]);
            root = getHeapNodeFromIndex(compareIndex);
        }
    }
}

CharacterFrequency RemoveMinimumFrequencyFromHeap(FrequencyHeap &heap){
    printf("%d ", heap.elements[0].frequency);
    swap(heap.elements[0], heap.elements[heap.lastElementIndex]);
    heap.lastElementIndex--;
    DownHeapBubbleFromRoot(heap);
    return {};
}


#endif