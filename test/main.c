#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void toBeEqaulNumber(long long t1, long long t2);
static void toBeEqaulString(const char* s1, const char* s2);

extern size_t ft_strlen(const char* s);
extern char* ft_strcpy(char* dst, const char* src);
extern int ft_strcmp(const char* s1, const char* s2);
extern ssize_t ft_read(int fildes, void* buf, size_t nbyte);
extern ssize_t ft_write(int fildes, const void* buf, size_t nbyte);
extern char* ft_strdup(const char* s1);

int main() {
  /*
   * ft_strlen
   */
  printf("[%s]\t", "ft_strlen");
  {
    const char* s1 = "ft_strlen test string";
    const char* s2 = "Hello, world!";

    toBeEqaulNumber(strlen(s1), ft_strlen(s1));
    toBeEqaulNumber(strlen(s2), ft_strlen(s2));
  }
  printf("OK\n");

  /*
   * ft_strcpy
   */
  printf("[%s]\t", "ft_strcpy");
  {
    const char* s1 = "ft_strcpy";
    char buf[500] = {0};
    ft_strcpy(buf, s1);
    toBeEqaulString(buf, s1);

    const char* s2 = "carry overflow";
    ft_strcpy(buf, s2);
    toBeEqaulString(buf, s2);
  }
  printf("OK\n");

  /*
   * ft_strcmp
   */
  printf("[%s]\t", "ft_strcmp");
  {
    const char* s1 = "Hello, world!";
    const char* s2 = "Hello, libasm!";

    toBeEqaulNumber(ft_strcmp(s1, s1), 0);
    toBeEqaulNumber(ft_strcmp("", ""), 0);
    toBeEqaulNumber(strcmp(s1, s2), ft_strcmp(s1, s2));
    toBeEqaulNumber(strcmp(s2, s1), ft_strcmp(s2, s1));
  }
  printf("OK\n");

  /*
   * ft_strdup
   */
  printf("[%s]\t", "ft_strdup");
  {
    const char* s1 = "libasm-ft_strdup";
    char* ptr = NULL;
    char* ptr2 = NULL;

    ptr = ft_strdup(s1);
    ptr2 = strdup(s1);
    toBeEqaulString(s1, ptr);
    toBeEqaulString(ptr, ptr2);

    /* teardown */
    free(ptr);
    free(ptr2);
  }
  printf("OK\n");

  /*
   * ft_write
   * ft_read
   */
  {
    const char* s1 = "Hello, world!";
    const char* file_path = "./ft_rw.txt";

    /* ft_write */
    printf("[%s]\t", "ft_write");
    {
      ssize_t ret;
      int fd = open(file_path, O_WRONLY | O_CREAT, 400);
      if (fd < 0) {
        printf("File open failed\n");
        abort();
      }
      ret = ft_write(fd, s1, strlen(s1));
      toBeEqaulNumber(ret, strlen(s1));

      ret = ft_write(-1, s1, strlen(s1));
      toBeEqaulNumber(ret, -1);
      toBeEqaulNumber(errno, EBADF);

      /* teardown */
      close(fd);
      errno = 0;
    }
    printf("OK\n");

    /* ft_read */
    printf("[%s]\t", "ft_read");
    {
      ssize_t ret;
      char buf[500] = {0};
      int fd = open(file_path, O_RDONLY);

      if (fd < 0) {
        printf("File open failed\n");
        abort();
      }
      ret = ft_read(fd, buf, strlen(s1));
      buf[ret] = 0;
      toBeEqaulString(buf, s1);
      toBeEqaulNumber(ret, strlen(s1));

      ret = ft_read(-1, buf, strlen(s1));
      toBeEqaulNumber(ret, -1);
      toBeEqaulNumber(errno, EBADF);

      /* teardown */
      close(fd);
      remove(file_path);
      errno = 0;
    }
    printf("OK\n");
  }

  return 0;
}

void toBeEqaulNumber(long long n1, long long n2) {
  if (n1 != n2) {
    printf("n1: %lld, n2: %lld\t", n1, n2);
    abort();
  }
}

void toBeEqaulString(const char* s1, const char* s2) {
  size_t s1_len = strlen(s1);
  size_t s2_len = strlen(s2);

  if (s1_len != s2_len) {
    printf("s1_len: %ld, s2_len: %ld\t", s1_len, s2_len);
    abort();
  }

  for (size_t i = 0; i < s1_len; i++) {
    if (s1[i] != s2[i]) {
      printf("s1[%ld]: %c, s2[%ld]: %c\t", i, s1[i], i, s2[i]);
      abort();
    }
  }
}
