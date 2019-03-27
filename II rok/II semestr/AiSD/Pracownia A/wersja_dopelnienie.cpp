#include <iostream>
using namespace std;
int main()
{
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  unsigned int n;
  cin >> n;
  unsigned int ns[n];
  unsigned long long suma = 0;
  for (unsigned int i = 0; i < n; i++) {
    unsigned int ni;
    cin >> ni;
    ns[i] = ni;
    suma += ni;
  }
  unsigned long long maksymalny = suma / 2;

  unsigned int i = 0, j = 0;
  unsigned long long obecna = 0, obecneMaksimum = 0;
  while (j < n) {
    if (obecna > maksymalny) {
      obecna -= ns[i];
      i++;
    } else if (obecna < maksymalny) {
      obecna += ns[j];
      j++;
    }
    unsigned long long obecnaVSdopelnienie = min(obecna, suma-obecna);
    // cout << obecnaVSdopelnienie << '\n';
    if ((obecneMaksimum < obecnaVSdopelnienie) && (obecnaVSdopelnienie <= maksymalny)) {
      obecneMaksimum = obecnaVSdopelnienie;
      if (obecneMaksimum == maksymalny) {
          cout << obecneMaksimum;
          return 0;
      }
    }
  }
  cout << obecneMaksimum;

  return 0;
}
