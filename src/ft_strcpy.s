section .text
  global _ft_strcpy

_ft_strcpy:
  mov rcx, 0
  jmp loop

increase:
  inc rcx

loop:
  cmp BYTE [rsi + rcx], 0
  je  return

copy:
  mov dl, BYTE [rsi + rcx]
  mov BYTE [rdi + rcx], dl
  jmp increase

return:
  mov dl, BYTE [rsi + rcx]
  mov BYTE [rdi + rcx], dl
  mov rax, rdi
  ret
