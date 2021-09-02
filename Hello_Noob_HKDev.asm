;
section .data
    msg db "Hello Nebie",0x0A
    msg1 db "Welcome To HKDev",0x0

section .text
    global _start

_start:

    ;msg output
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 12
    int 0x80

    ;msg1 output
    mov eax, 6
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 18
    int 0x80 ;RUNSUNGMAN

    ;end program
    mov eax, 1
    mov ebx, 0
    int 0x80
