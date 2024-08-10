```
level 03: Hh74RPnuQ9sa5JAEXgNWCqz7sXGnh5J5M9KfPg3H
```

![](Pasted%20image%2020240808130711.png)

![](Pasted%20image%2020240808135432.png)

```c
undefined4 main(void)

{
  uint __seed;
  int iStack_14;
  
  __seed = time((time_t *)0x0);
  srand(__seed);
  puts("***********************************");
  puts("*\t\tlevel03\t\t**");
  puts("***********************************");
  printf("Password:");
  __isoc99_scanf();
  test(iStack_14,322424845);
  return 0;
}
```

```c
void test(int param_1,int param_2)

{
  EVP_PKEY_CTX *pEVar1;
  uchar *in_stack_ffffffd8;
  size_t *in_stack_ffffffdc;
  uchar *in_stack_ffffffe0;
  size_t in_stack_ffffffe4;
  
  pEVar1 = (EVP_PKEY_CTX *)(param_2 - param_1);
  switch(pEVar1) {
  default:
    pEVar1 = (EVP_PKEY_CTX *)rand();
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x1:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x2:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x3:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x4:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x5:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x6:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x7:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x8:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x9:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x10:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x11:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x12:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x13:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x14:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
    break;
  case (EVP_PKEY_CTX *)0x15:
    decrypt(pEVar1,in_stack_ffffffd8,in_stack_ffffffdc,in_stack_ffffffe0,in_stack_ffffffe4);
  }
  return;
}
```

```c
int decrypt(EVP_PKEY_CTX *ctx,uchar *out,size_t *outlen,uchar *in,size_t inlen)

{
  char cVar1;
  uint uVar2;
  int iVar3;
  undefined4 *puVar4;
  byte *pbVar5;
  int in_GS_OFFSET;
  bool bVar6;
  bool bVar7;
  uint local_2c;
  undefined4 local_21;
  undefined4 local_1d;
  undefined4 local_19;
  undefined4 local_15;
  undefined local_11;
  int local_10;
  
  Canary = *(int *)(in_GS_OFFSET + 0x14);
  local_21 = 0x757c7d51;
  local_1d = 0x67667360;
  local_19 = 0x7b66737e;
  local_15 = 0x33617c7d;
  local_11 = 0;
  uVar2 = 0xffffffff;
  puVar4 = &local_21;
  do {
    if (uVar2 == 0) break;
    uVar2 = uVar2 - 1;
    cVar1 = *(char *)puVar4;
    puVar4 = (undefined4 *)((int)puVar4 + 1);
  } while (cVar1 != '\0');
  local_2c = 0;
  while( true ) {
    bVar6 = local_2c < ~uVar2 - 1;
    bVar7 = local_2c == ~uVar2 - 1;
    if (!bVar6) break;
    *(byte *)((int)&local_21 + local_2c) = (byte)ctx ^ *(byte *)((int)&local_21 + local_2c);
    local_2c = local_2c + 1;
  }
  iVar3 = 0x11;
  puVar4 = &local_21;
  pbVar5 = (byte *)"Congratulations!";
  do {
    if (iVar3 == 0) break;
    iVar3 = iVar3 + -1;
    bVar6 = *(byte *)puVar4 < *pbVar5;
    bVar7 = *(byte *)puVar4 == *pbVar5;
    puVar4 = (undefined4 *)((int)puVar4 + 1);
    pbVar5 = pbVar5 + 1;
  } while (bVar7);
  if ((!bVar6 && !bVar7) == bVar6) {
    iVar3 = system("/bin/sh");
  }
  else {
    iVar3 = puts("\nInvalid Password");
  }
  if (Canary == *(int *)(in_GS_OFFSET + 0x14)) {
    return iVar3;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}
```

![](Pasted%20image%2020240808151823.png)

![](Pasted%20image%2020240808151849.png)

![](Pasted%20image%2020240808151906.png)

![](Pasted%20image%2020240808151919.png)

local _21 serai le pointeur de la chaine qui serait composee de 4 mots 4 Caracteres
```
Q}|u`fsg~sf{}|a3
```

```c
while (true) {
    bool bVar4 = local_2c < ~uVar2 - 1; // Vérifie si local_2c est inférieur à ~uVar2 - 1
    bool bVar5 = local_2c == ~uVar2 - 1; // Vérifie si local_2c est égal à ~uVar2 - 1
    if (!bVar4) break; // Si local_2c n'est pas inférieur à ~uVar2 - 1, sortir de la boucle
    local_21[local_2c] = key ^ local_21[local_2c]; // Effectue une opération XOR entre key et le byte à la position local_2c
    local_2c++; // Incrémente le compteur local_2c
}
```

cette routine va xor avec argv1 chaque charactere de local_21

```c
  iVar3 = 0x11;
  puVar4 = &local_21;
  pbVar5 = (byte *)"Congratulations!";
  do {
    if (iVar3 == 0) break;
    iVar3 = iVar3 + -1;
    bVar6 = *(byte *)puVar4 < *pbVar5;
    bVar7 = *(byte *)puVar4 == *pbVar5;
    puVar4 = (undefined4 *)((int)puVar4 + 1);
    pbVar5 = pbVar5 + 1;
  } while (bVar7);
  if ((!bVar6 && !bVar7) == bVar6) {
    iVar3 = system("/bin/sh");
  }
  else {
    iVar3 = puts("\nInvalid Password");
  }
```

ensuite ici on va avoir un strncmp qui va check local_21( qui a ete xor ) avec "Congratulations!"
ce qui nous donne:
```
Q}|u`fsg~sf{}|a3 ^ argv1 = Congratulations!

si cette condition est rempli nous auront on shell
```

![](Pasted%20image%2020240808152946.png)
![](Pasted%20image%2020240808153045.png)

on voit ici l'appel a la fonction decrypt:
on a un switch case sur N (param2 - param1)
si N est compri entre 1 et 21 on appel decrypt avec comme argv1 N sinon N est random

donc on va devoir trouver N pour que le xor coresponde et ensuite faire en sorte que 0 < ( param2 - param1 == N ) < 21

calcul de N:

```
Q}|u`fsg~sf{}|a3 ^ argv1 = Congratulations!
```

```python
def xor_string(input_string, key):
    return ''.join(chr(ord(char) ^ key) for char in input_string)

input_string = "Q}|u`fsg~sf{}|a3"

for key in range(1, 22):
    result = xor_string(input_string, key)
    print(f"Key {key}: {result}")
```

![](Pasted%20image%2020240808153811.png)

comme on peut le voir la clef et de 18

calcul de param1

![](Pasted%20image%2020240808153919.png)

```
322424845 - param1 = 18
param1 = 322424845 - 18
param1 = 322424827
```

![](Pasted%20image%2020240808154215.png)

```
level04 : kgv3tkEb9h2mLkRsPkXRfc2mHbjMxQzvb2FrgKkf
```