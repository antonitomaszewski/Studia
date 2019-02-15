#include <iostream>
#include <vector>
using std::cin;
using std::cout;
using std::vector;


vector <int> drzewo [100001];
bool kolor [100001];
bool odwiedzon [100001];

void bfs(int node) {
        int kol = !kolor[node];

        for(auto somsiadXD : drzewo[node])
                if (!odwiedzon[somsiadXD])
                        kolor[somsiadXD] = kol;
        odwiedzon[node] = true;

        for (auto somsiadXS : drzewo[node])
                if (!odwiedzon[somsiadXS])
                        bfs(somsiadXS);
}

int main()
{
        std::ios_base::sync_with_stdio(false);
        int n;
        cin >> n;
        for (int k = 1; k < n; k++) {
                int i, j;
                cin >> i >> j;

                drzewo[i].push_back(j);
                drzewo[j].push_back(i);
        }

        kolor[1] = true;
        bfs(1);

        long long trues, falses;
        trues = falses = 0;
        for (int i = 1; i <= n; i++) {
                if (kolor[i]) {
                        trues++;
                } else {
                        falses++;
                }
        }

        cout << trues * falses - n + 1;

}
