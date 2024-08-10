
![](Pasted%20image%2020240806233057.png)

![](Pasted%20image%2020240806233415.png)

![](Pasted%20image%2020240806233516.png)

```c
bool main(void)

{
  int local_14 [4];
  
  puts("***********************************");
  puts("* \t     -Level00 -\t\t  *");
  puts("***********************************");
  printf("Password:");
  __isoc99_scanf(&DAT_08048636,local_14);
  if (local_14[0] != 0x149c) {
    puts("\nInvalid Password!");
  }
  else {
    puts("\nAuthenticated!");
    system("/bin/sh");
  }
  return local_14[0] != 0x149c;
}
```

![](Pasted%20image%2020240806233746.png)

![](Pasted%20image%2020240806233815.png)

```
cat /home/users/level01/.pass
uSq2ehEGT6c9S24zbshexZQBXUGrncxn5sD5QfGL

level01:uSq2ehEGT6c9S24zbshexZQBXUGrncxn5sD5QfGL
```