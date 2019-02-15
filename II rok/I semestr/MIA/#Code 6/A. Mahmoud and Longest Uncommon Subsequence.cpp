#include <iostream>
#include <string>
using std::cin;
using std::cout;
using std::string;

int main()
{
        std::ios_base::sync_with_stdio(false);
        string a;
        string b;

        cin >> a;
        cin >> b;

        if (a==b) {
                cout << -1;
        } else {
                cout << std::max(a.length(), b.length());
        }
}
