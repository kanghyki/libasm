section .text
  global  _ft_strdup
  extern  _malloc

_ft_strdup:
  mov   rcx, 0
  jmp   ft_strlen

ft_strlen_increase:
  inc   rcx

ft_strlen:
  cmp   BYTE [rdi + rcx], 0
  jne   ft_strlen_increase
  inc   rcx

allocate:
  push  rdi
  mov   rdi, rcx
  call  _malloc
  pop   rdi
  cmp   rax, 0
  je    error
  mov   rcx, 0
  jmp   ft_strcpy

ft_strcpy_increase:
  inc   rcx

ft_strcpy:
  cmp   BYTE [rdi + rcx], 0
  je    return

copy:
  mov   dl, BYTE [rdi + rcx]
  mov   BYTE [rax + rcx], dl
  jmp   ft_strcpy_increase

error:
  mov   rax, 0
  ret

return:
  ret
