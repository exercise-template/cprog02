/* m006.c - Cross product.

   This program reads the coordinates of two 3-dimensional
   integer vectors and outputs their cross (vector) product. 
   Vectors' coordinates are read as blank-separate real
   numbers.


   E.g.

      command line    :  m006
      standard input  :  1  2  3
                         4  5  6
      expected output : -3  6 -3

   Directions:

      Please, edit function crossprod();
      do no not change function main().

*/

#include <stdio.h>
#include <stdlib.h>

/* Compute the corss product of vectors 'a' and 'b', 
   and store the result in vector 'c'. */

void crossprod (int a[3], int b[3], int c[3])
{
}



/* Do not edit this function. */

int main (int argc, char **argv)
{
  int u[3], v[3], z[3];
  
  /* Read matrix lines. */
  
  scanf ("%d %d %d", &u[0], &u[1], &u[2]);
  scanf ("%d %d %d", &v[0], &v[1], &v[2]);

  crossprod (u, v, z);
  
  printf ("%d %d %d\n", z[0], z[1], z[2]);
  
  return 0;
}
