/* m012.c - Arabic to Roman.

   This program takes a non-zero positive integer read as a command 
   line argument and outputs its value in Roman numerals. The number
   is guarateed to be between 1 and 3999.

   E.g.

      command line    : m012 42
      expected output : XLII

   Directions:

      Please, edit function roman();
      do no not change function main().

 */

#include <stdio.h>
#include <stdlib.h>

#define USAGE "m012 <number>\n"

/* Write the number 'n' in Roman numerals.*/

void roman (int n)
{
  printf ("I\n");
}

/* Do not edit function main. */

int main (int argc, char **argv)
{
  int n;

  if (argc < 2)
    {
      printf (USAGE);
      exit(1);
    }
  
  n = atoi(argv[1]);

  roman (n);

  return 0;
}
