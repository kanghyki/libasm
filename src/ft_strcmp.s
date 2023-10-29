  global  _ft_strcmp

  section .text
_ft_strcmp:
  mov     rcx, 0
  jmp     loop

increase:
  inc     rcx

loop:
  mov     r8b, BYTE [rsi + rcx]
  mov     r9b, BYTE [rdi + rcx]
  cmp     r8b, r9b
  jne     return
  cmp     r8b, 0
  je      return
  cmp     r9b, 0
  je      return
  jmp     increase

return:
  movzx   rcx, r8b
  movzx   rax, r9b
  sub     rax, rcx
  ret
