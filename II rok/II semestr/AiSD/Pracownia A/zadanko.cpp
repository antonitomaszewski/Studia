#include <iostream>
using namespace std;
int main()
{
  ios_base::sync_with_stdio(false);
  cin.tie(nullptr);
  unsigned int n;
  cin >> n;
  unsigned int ns[2*n];
  unsigned long long suma = 0;
  for (unsigned int i = 0, j = n; i < n; i++, j++) {
    unsigned int ni;
    cin >> ni;
    ns[i] = ni;
    ns[j] = ni;
    suma += ni;
  }
  unsigned long long maksymalny = suma / 2;

  unsigned int i = 0, j = 0;
  unsigned long long obecna = 0, obecneMaksimum = 0;
  while (i < n) {
    if (obecna == maksymalny) {
      cout << obecna;
      return 0;
    } else if (obecna > maksymalny) {
      obecna -= ns[i];
      i++;
    } else if (obecna < maksymalny) {
      obecna += ns[j];
      j++;
    }
    if ((obecneMaksimum < obecna) && (obecna <= maksymalny)) {
      obecneMaksimum = obecna;
    }
  }
  cout << obecneMaksimum;

  return 0;
}
