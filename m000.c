/* m000.c - Pitagorean name number

   This program takes the a person full name read from standard input
   and output its Pitagorean Number as shown in referece 

   E.g.

      command line    : John Doe
      expected output : 35

   Directions:

      Please, edit function roman();
      do no not change function main().

 */

#include <stdio.h>
#include <stdlib.h>

#define MAX 255

/* Write the number 'n' in Roman numerals.*/

int pitagorean (char *s)
{
  return 0;
}

/* Do not edit function main. */

int main (int argc, char **argv)
{
  int n;
  char name[MAX];

  fgets (name, MAX-1, stdin);
  
  n = pitagorean (name);
  
  printf ("%d\n", n);

  return 0;
}

/*  
    [1] Pitagorean name number:
    https://en.wikipedia.org/wiki/Numerology#Pythagorean_system
*/
