#include <iostream>

int main()
{
        unsigned long long a;
        unsigned long long b;
        unsigned int c;

        std::cin >> a >> b >> c;
        if (a-b >= c) {
                std::cout << 0;
                return 0;
        }
        else {
                unsigned long long res = 1;
                b++;
                while (b <= a) {
                        res *= (b % c);
                        res %= c;
                        b++;
                }
                std::cout << res;
        }
}
