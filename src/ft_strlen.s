  global  _ft_strlen

  section .text
_ft_strlen:
  mov     rax, 0
  jmp     loop

increase:
  inc     rax

loop:
  cmp     BYTE [rdi + rax], 0
  jne     increase

return:
  ret
