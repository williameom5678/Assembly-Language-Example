;For Linux i386 on Intel x86
;(Not)Made By Me
;Nanun Barboda.
section .data
	msg db "Hello, World!",0x0A
	len equ $ - msg

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80
