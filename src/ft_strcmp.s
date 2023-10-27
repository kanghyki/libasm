section .text
  global _ft_strcmp

_ft_strcmp:
  mov rcx, 0
  jmp loop

increase:
  inc rcx

loop:
  cmp BYTE [rsi + rcx], 0
  je  return

compare:
  mov dl, BYTE [rdi + rcx]
  cmp BYTE [rsi + rcx], dl
  je  increase

return:
  mov dl, BYTE [rsi + rcx]
  sub dl, BYTE [rdi + rcx]
  ret
