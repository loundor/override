```
level06 : h4GtNnaMs2kZFN92ymTr2DcJHAzMfzLW25Ep59mq
```

![](Pasted%20image%2020240808233407.png)

```c
bool main(undefined4 param_1,undefined4 param_2)

{
  int iVar1;
  int in_GS_OFFSET;
  uint uStack_38;
  char local_34 [32];
  int local_14;
  
  local_14 = *(int *)(in_GS_OFFSET + 0x14);
  puts("***********************************");
  puts("*\t\tlevel06\t\t  *");
  puts("***********************************");
  printf("-> Enter Login: ");
  fgets(local_34,0x20,stdin);
  puts("***********************************");
  puts("***** NEW ACCOUNT DETECTED ********");
  puts("***********************************");
  printf("-> Enter Serial: ");
  __isoc99_scanf();
  iVar1 = auth(local_34,uStack_38);
  if (iVar1 == 0) {
    puts("Authenticated!");
    system("/bin/sh");
  }
  if (local_14 != *(int *)(in_GS_OFFSET + 0x14)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return iVar1 != 0;
}
```

```c
undefined4 auth(char *param_1,uint param_2)

{
  size_t index;
  undefined4 ret;
  long nRet;
  int i;
  uint local_14;
  
  index = strcspn(param_1,"\n");
  param_1[index] = '\0';
  index = strnlen(param_1,32);
  if ((int)index < 6) {
    ret = 1;
  }
  else {
    nRet = ptrace(PTRACE_TRACEME);
    if (nRet == -1) {
      puts("\x1b[32m.---------------------------.");
      puts("\x1b[31m| !! TAMPERING DETECTED !!  |");
      puts("\x1b[32m\'---------------------------\'");
      ret = 1;
    }
    else {
      local_14 = ((int)param_1[3] ^ 0x1337U) + 0x5eeded;
      for (i = 0; i < (int)index; i = i + 1) {
        if (param_1[i] < ' ') {
          return 1;
        }
        local_14 = local_14 + ((int)param_1[i] ^ local_14) % 1337;
      }
      if (param_2 == local_14) {
        ret = 0;
      }
      else {
        ret = 1;
      }
    }
  }
  return ret;
}
```

Le programe demande un Login et un Serial
Le Serial doit avoir une longueur comprise entre 6 et 32 caracteres.
On doit bypass le retour de ptrace pour pouvoir leak le mot passe a rentrer car
l'algo va crypter le Login en effectuant de XOR et des % pour ensuite comparer le resultat saisi dans Serial

```
b auth
c
```

![](Pasted%20image%2020240809015942.png)
```
gef➤  c
Continuing.
***********************************
*		level06		  *
***********************************
-> Enter Login: tototo
***********************************
***** NEW ACCOUNT DETECTED ********
***********************************
-> Enter Serial: 42
```

![](Pasted%20image%2020240809020126.png)
![](Pasted%20image%2020240809020153.png)
Nous retrouvons donc notre Login dans EAX et le Serial a la 7eme position de la stack (0xffffc4e4) suivi de argc a la 8eme.
Maintenant on bypass le ptrace pour effectuer le cryptage:

```
b *0x80487ba
c

```

![](Pasted%20image%2020240809021541.png)

Il nous faut change la valeur du registre EAX pour la remettre a 0 et éviter de rentrer dans la condition qui quitte de programme.

```
set $eax=0
```

![](Pasted%20image%2020240809021021.png)

Maintenant on break sur la comparaison après le cryptage

![](Pasted%20image%2020240809021304.png)

![](Pasted%20image%2020240809021625.png)

Nous voyons bien que EAX contient 0x2a ce qui correspond a notre 42 du secret.
La comparaison s effectue donc avec cette valeur plus la valeur "tototo" crypter.
Tototo crypter est dans la stack a la position EBP-0x10:

![](Pasted%20image%2020240809021847.png)

Maintenant nous avons besoin de passer la valeur en base 10.

```
0x005f1adb : 6232795
```

![](Pasted%20image%2020240809015717.png)

```
tototo : 6232795
```

![](Pasted%20image%2020240809015754.png)

```
level07 : GbcPDRgsFK77LNnnuh7QyFYA2942Gp8yKj9KrWD8
```