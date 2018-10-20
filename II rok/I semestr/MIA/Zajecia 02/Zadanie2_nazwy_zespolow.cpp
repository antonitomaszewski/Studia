#include <iostream>
#include <string>
using std::string;
using std::cout;
using std::cin;

void partition(string *nazwy[][4],int i,int  j,int nr_pola) {
  int indeks_pivota = i + (i+j)/2;
  string pivot = *(nazwy[i][nr_pola]);
  string aux;
  aux = 
  i++;
  while (i <= j) {

  }
}


int main()
{
  unsigned int n;
  cin >> n;
  string nazwa, miasto;
  // nazwa miasto wynik nr_początkowy
  string teams[n][4];

  for (unsigned int i = 0; i < n; i++) {
    cin >> nazwa >> miasto;
    teams[i][0] = nazwa.substr(0,3);
    teams[i][1] = miasto.substr(0,1);
    // teams[i][3] = to_string((char) i);
  }


}
