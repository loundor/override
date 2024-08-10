#include <stdio.h>
int		main(int ac, char **av, char**env)
{
	while (*env) {
		printf("%p - %s\n", *env, *env);
		env++;
	}
	return 0;
}