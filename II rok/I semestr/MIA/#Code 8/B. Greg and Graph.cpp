#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

int main()
{
  int n;
  cin >> n;
  int dist[n][n];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      cin >> dist[i][j];
    }
  }
  int xs[n];
  for (int i = 0; i < n; i++) {
    int xi;
    cin >> xi;
    xi--;
    xs[i] = xi;
  }

  long long result[n];
  for (int i = n-1; i >= 0; i--) {
    int xi = xs[i];

    for (int vi = 0; vi < n; vi++) {
      for (int vj = 0; vj < n; vj++) {
        dist[vi][vj] = min(dist[vi][vj], dist[vi][xi] + dist[xi][vj]);
      }
    }

    long long s = 0;
    for (int k = i; k < n; k++) {
      int vk = xs[k];
      for (int j = i; j < n; j++) {
        int vj = xs[j];
        s += dist[vk][vj];
      }
    }
    result[i] = s;
  }

  for (int i = 0; i < n; i++) {
    cout << to_string(result[i]) << " ";
  }
}
