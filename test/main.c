#include <stdio.h>

extern int my_asm();

int main() {
  printf("Hello, libasm!\n");
  printf("my_asm: %d\n", my_asm());

  return 0;
}
