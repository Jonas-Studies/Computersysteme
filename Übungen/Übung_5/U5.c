#include <stdio.h>

//windows

int main(int argc, char const *argv[])
{
    long long x = 61 / 5 * 7 / (-17);
    printf("%lld\n", x);
    
    long long y = 61%5 + (61/5*7)%(-17);
    printf("%lld\n", y);
    
    return 0;
}