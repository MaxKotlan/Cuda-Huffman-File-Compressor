#ifndef CHARACTERFREQUENCY_H
#define CHARACTERFREQUENCY_H
#include <stdio.h>
#include <random>

struct CharacterFrequency{
    char character = 0;
    int frequency = 0;
};

void swap(CharacterFrequency& lhs, CharacterFrequency& rhs){
    CharacterFrequency temp = lhs;
    lhs = rhs;
    rhs = temp;
}

bool operator< (const CharacterFrequency& lhs, const CharacterFrequency& rhs){
    return lhs.frequency < rhs.frequency;
}

bool operator> (const CharacterFrequency& lhs, const CharacterFrequency& rhs){
    return rhs<lhs;
}

void print(CharacterFrequency cf){
    printf("\n\tcharacter: %c\nfrequency: %d\n\n", cf.character, cf.frequency);
}

#endif