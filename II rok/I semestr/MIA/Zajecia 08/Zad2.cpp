#include <iostream>
#include <string>
// #include <cmath>
using std::cin;
using std::cout;
using std::string;

void check(string str, int len) {
        std::ios_base::sync_with_stdio(false);
        int s = 0;
        int e = len-1;
        int dist;
        while(s<e) {
                dist = abs(int(str[s]) - int(str[e]));
                if (dist != 0 && dist != 2) {
                        // cout << s << " " << e << " " << str[s] << " " << str[e] << '\n';
                        cout << "NO\n";
                        return;
                }
                s++;
                e--;
        }
        cout << "YES\n";
        return;
}

int main()
{
        std::ios_base::sync_with_stdio(false);
        int n;
        string s;
        int len;
        cin >> n;
        // n++;
        while (n--) {
                cin >> len;
                cin >> s;
                check(s,len);
        }
}
