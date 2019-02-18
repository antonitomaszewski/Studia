#include <iostream>
#include <iomanip>
using namespace std;

double temp[50][50];
double weights[50][50];
bool visited[50];
int n;
int flow;

bool dfs(int i) {
  if (i == n-1)
    return true;
  if (visited[i])
    return false;

  visited[i] = true;

  for (int j = 0; j < n; j++)
    if (temp[i][j] >= flow && dfs(j)) {
      temp[i][j] -= flow;
      temp[j][i] += flow;
      return true;
    }
  return false;
}


int main()
{
  int m, x;
  cin >> n >> m >> x;

  for (int i = 0; i < m; i++) {
    int ai, bi, ci;
    cin >> ai >> bi >> ci;
    ai--;
    bi--;
    weights[ai][bi] = ci;
  }

  double left = 0, right = 1e6;

  for (int i = 0; i < 100; i++) {
    double middle = (left + right) / 2;

    for (int ai = 0; ai < n; ai++)
      for (int bi = 0; bi < n; bi++)
        temp[ai][bi] = weights[ai][bi]/middle;

    long long bear = 0, f = 1e9;

    while (f) {
      for (int ai = 0; ai < n; ai++) {
        visited[ai] = false;
      }
      flow = f;
      if (dfs(0))
        bear += f;
      else
        f /= 2;
    }

    if (bear >= x)
      left = middle;
    else
      right = middle;
  }

  cout << setprecision(10) << left * x;
}
