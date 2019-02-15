#include <iostream>
#include <vector>
using std::cin;
using std::cout;
using std::vector;

vector <int> drzewo [100001];
int glebokosc [100001];

void vfs(int node, int depth) {
        glebokosc[node] = depth;

        for (auto somsiadXD : drzewo[node])
                if (glebokosc[somsiadXD] == 0) {
                        vfs(somsiadXD, depth+1);
                }
}


int main()
{
        cout.precision(30);
        std::ios_base::sync_with_stdio(false);
        int n;
        cin >> n;
        for (int k = 1; k < n; k++) {
                int i, j;
                cin >> i >> j;

                drzewo[i].push_back(j);
                drzewo[j].push_back(i);
        }

        vfs(1, 1);
        double res = 0;
        for (int i = 1; i <= n; i++) {
                res += (1./glebokosc[i]);
        }
        cout << res;
}
