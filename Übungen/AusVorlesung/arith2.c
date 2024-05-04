long arith2 (long x, long y, long z);

int main ()
{
	long result_of_arith2 = arith2(3l, 2l, 1l);

	return 0;
}

long arith2 (long x, long y, long z)
{
	return z - ( ~ ( ( x | y ) / 8 ) );
}
