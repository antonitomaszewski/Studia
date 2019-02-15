#include <iostream>
#include <map>
using std::cin;
using std::cout;

int main()
{
        std::ios_base::sync_with_stdio(false);
        int n;
        std::map <int, bool> mapka;
        cin >> n;
        for (int i = 0; i < n; i++) {
                int ai;
                cin >> ai;
                bool bolik = mapka[ai];
                mapka[ai] = !bolik;
        }
        for (std::map<int,bool>::iterator it = mapka.begin(); it!=mapka.end(); ++it) {
                if (it->second) {
                        cout << "Conan";
                        return 0;
                }
        }
        cout << "Agasa";
}
