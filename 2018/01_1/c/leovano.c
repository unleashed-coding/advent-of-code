#include <stdio.h>
#include <unistd.h>

int main(int argc, char const **argv) {
  FILE *fp;

  if (argc < 2) {
    fprintf(stderr, "Arg1\n");
    return 1;
  } else if (!(fp = fopen(argv[1], "r"))) {
    fprintf(stderr, "FileFail\n");
    return 2;
  }

  int v = 0, r;
  while (fscanf(fp, "%d", &r) == 1) v += r;
  printf("%d\n", v);

  fclose(fp);
  return 0;
}
