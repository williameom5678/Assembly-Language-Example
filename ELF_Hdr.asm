[BITS 32]

	org 0x08048000

ehdr:						                ; elf32_ehdr
	  db 0x7F, "ELF", 1, 1, 1, 0	; e_ident
	times 8 db 0
		dw 2				                 ; e_type
		dw 3				                 ; e_machine
		dd 1				                 ; e_version
		dd _start			                 ; e_entry
		dd phdr - $$			           	 ; e_phoff
		dd 0				                 ; e_shoff
		dd 0 				                 ; e_flags
		dw ehdrsize			                 ; e_ehsize
		dw phdrsize			                 ; e_phentsize
		dw 1				                 ; e_phnum
		dw 0				                 ; e_shentsize
		dw 0				                 ; e_shnum
		dw 0				                 ; e_shstrndx

ehdrsize 	equ $ - ehdr

phdr:						                 ; elf32_Phdr
		dd 1				                 ; p_type
		dd 0				                 ; p_offset
		dd $$				                 ; p_vaddr
		dd $$				                 ; p_paddr
		dd filesize			                 ; p_filesz
		dd filesize			                 ; p_memsz
		dd 5				                 ; p_flags
		dd 0x1000			                 ; p_align

phdrsize	equ $ - phdr

		msg db "Hello World", 0x0A
		len equ $ - msg
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80

filesize	equ $ - $$	
