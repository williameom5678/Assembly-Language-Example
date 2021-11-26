;made by williameom
;
;    <HOW TO ASSEMBLE & LINK>
; #> nasm -f elf game.asm
; #> ld -I/lib/ld-linux.so.2 -lc game.o -o game
;
extern scanf
extern printf

segment .data
  asdf db '%d', 0
  left_makju db 'Beer Left => %d Bottles', 10, 0
  no_makju db 'NO BEER LEFT', 10, 0
  chumuk db 'Drank 1 Beer', 10, 0

section .bss

segment .text
global start
start:
  mov ebx, 100 ;bottles + 1
  mov ecx, ebx
makju:
  sub ebx, 1
  push ebx
  push left_makju
  call printf

  push chumuk
  call printf

  cmp ebx, 1
  je end
  loop makju

end:
  mov ecx, 0
  push no_makju
  call printf

  mov eax, 1
  mov ebx, 0
  int 0x80

