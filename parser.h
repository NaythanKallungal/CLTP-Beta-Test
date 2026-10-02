#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>

#define MAX_LEN 1024

typedef enum {
  OLD,
  NEW
} age_t;

struct listnode {
  int value;
  age_t age;
  struct listnode* next;
};

struct listnode* generate_list(FILE* );
void print_age(age_t age);
