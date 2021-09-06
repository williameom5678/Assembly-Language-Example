section .data
    msg dw "Hello, Newbie!",0x0A
    msg1 dw "Welcome To mycom!",0x0A

section .text
    global _start

_start:

    ;msg output
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 16
    int 0x80

    mov eax, 6 ;needs to clear eax regester

    ;msg1 output
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 19
    int 0x80 ;RUNSUNGMAN

    ;end program
    mov eax, 1
    mov ebx, 0
    int 0x80
;BaeKimun Dweginda
