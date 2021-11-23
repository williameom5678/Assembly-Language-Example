%include "init0.inc"

[org 0x10000]
[bits 32]

PM_start:
	mov bx, SysDataSelector
	mov ds, bx
	mov es, bx
	mov fs, bx
	mov gs, bx
	mov ss, bx

	lea esp, [PM_start]

	mov edi, 0
	lea esi, [msgPMode]
	call printf

	cld
	mov ax, SysDataSelector
	mov es, ax
	xor eax, eax
	xor ecx, ecx
	mov ax, 256
	mov edi, 0

loop_idt:
	lea esi, [idt_ignore]
	mov cx, 8
	rep movsb
	dec ax
	jnz loop_idt

	mov edi, 8*0x20
	lea esi, [idt_timer]
	mov cx, 8
	rep movsb

	mov edi, 8*0x21
	lea esi, [idt_keyboard]
	mov cx, 8
	rep movsb

	lidt[idtr]

	mov al, 0xFC
	out 0x21, al
	sti

	jmp $

;===서브루틴===

printf:
	push eax
	push es
	mov ax, VideoSelector
	mov es, ax

printf_loop:
	mov al, byte [esi]
	mov byte [es:edi], al
	inc edi
	mov byte [es:edi], 0x06
	inc esi
	inc edi
	or al, al
	jz printf_end
	jmp printf_loop

printf_end:
	pop es
	pop eax
	ret

;===데이타 영역===

msgPMode db "We are in Protected Mode", 0
msg_isr_ignore db "This is an ignorable interrupt", 0
msg_isr_32_timer db ".This is the timer interrupt", 0
msg_isr_33_keyboard db ".This is the Keyboard interrupt", 0

;===인터럽트 서비스 루틴===

isr_ignore:
	push gs
	push fs
	push es
	push ds
	pushad
	pushfd

	mov al, 0x20
	out 0x20, al

	mov ax, VideoSelector
	mov es, ax
	mov edi, (80*7*2)
	lea esi, [msg_isr_ignore]
	call printf

	popfd
	popad
	pop ds
	pop es
	pop fs
	pop gs

	iret

isr_32_timer:
	push gs
	push fs
	push es
	push ds
	pushad
	pushfd

	mov al, 0x20
	out 0x20, al

	mov ax, VideoSelector
	mov es, ax
	mov edi, (80*2*2)
	lea esi, [msg_isr_32_timer]
	call printf
	inc byte [msg_isr_32_timer]
	
	popfd
	popad
	pop ds
	pop es
	pop fs
	pop gs

	iret

isr_33_keyboard:
	pushad
	push gs
	push fs
	push es
	push ds
	pushfd

	in al, 0x60

	mov al, 0x20
	out 0x20, al

	mov ax, VideoSelector
	mov es, ax
	mov edi, (80*4*2)
	lea esi, [msg_isr_33_keyboard]
	call printf
	inc byte [msg_isr_33_keyboard]

	popfd
	pop ds
	pop es
	pop gs
	popad
	iret

;===IDT===

idtr:
	dw 256*8-1
	dd 0

idt_ignore:
	dw isr_ignore
	dw 0x08
	db 0
	db 0x8E
	dw 0x001

idt_timer:
	dw isr_32_timer
	dw 0x08
	db 0
	db 0x8E
	dw 0x0001

idt_keyboard:
	dw isr_33_keyboard
	dw 0x08
	db 0
	db 0x8E
	dw 0x001

times 512-($-$$) db 0
	
