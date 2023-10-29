  global  _ft_read
  extern  ___error

  section .text
_ft_read:
  mov     rax, 0x2000003
  syscall
  jnc     return

error:
  mov     rdi, rax
  call    ___error
  mov     [rax], rdi
  mov     rax, -1

return:
  ret
