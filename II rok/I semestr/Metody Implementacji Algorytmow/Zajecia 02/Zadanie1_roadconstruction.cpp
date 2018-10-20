#include <iostream>
using namespace std;

int main() {
  int n, m;
  cin >> n >> m;
  int niepary[2][m];
  bool joker[n];

  for (int i = 0; i < m; i++) {
    cin >> niepary[0][i] >> niepary[1][i];
  }
  for (int i = 0; i < n; i++) {
    joker[i] = false;
  }
  for (int i = 0; i < m; i++) {
    joker[niepary[0][i]-1] = true;
    joker[niepary[1][i]-1] = true;
  }


  int jok = -1;
  int i = 0;
  while (jok == -1) {
    if (!joker[i]) {
      jok = i+1;
    } else {
      i++;
    }
  }
  cout<<n-1<<endl;
  for (int i = 0; i < n; i++) {
    if ((i+1)!=jok) {
      cout << jok << " " << i+1 << endl;
    }
  }




}
