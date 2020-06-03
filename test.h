#ifndef TEST_H
#define TEST_H

#include <stdlib.h>

int main_test(int, char**);
void _start(int argc, char **argv)
{
  main_test(argc, argv);
  exit(0);
}

#endif
