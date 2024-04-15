#include <stdio.h>

signed char get_first_equations_result ();
signed char get_second_equations_result ();

int main ()
{
	printf("%i\n", (int)get_first_equations_result());

	printf("%i\n", (int)get_second_equations_result());

	return 0;
}

signed char get_first_equations_result ()
{
	signed char a = -23;
	signed char b = '\0';

	signed char result = a || b;

	return result;
}

signed char get_second_equations_result ()
{
	signed char a = 5;
	signed char b = 0;

	signed char result = (a | b) || (a & b) && (a ^ b);

	return result;
}
