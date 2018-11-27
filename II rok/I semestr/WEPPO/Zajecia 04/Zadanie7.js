var readline = require('readline');
var fs = require('fs');

Object.prototype.isEmpty = function() {
  for (var key in this) {
    if (this.hasOwnProperty(key))
      return false;
  }
  return true;
};

function wyluskajAdresy(plik, ile) {
  function toString(a) {
    return '' + a;
  }

  function maximum(a, b) {
    return a > b ? a : b;
  }

  function minimum(a, b) {
    return a < b ? a : b;
  }

  function wyluskajAdres(line) {
    return toString(line.split(" ")[1]);
  }


  // A[key] = undefined;
  // A = JSON.parse(JSON.stringify(A ));


  function dzialaj(adresy) {
    function dodajAdres(addr) {
      let ile = addr_liczba[addr] = addr_liczba[addr] + 1 || 1;

      if (liczba_addr[toString(ile - 1)]) {
        delete liczba_addr[toString(ile - 1)][addr];
        if (liczba_addr[toString(ile - 1)].isEmpty()) {
          console.log(1);
          delete liczba_addr[toString(ile - 1)];
        }
      }
      if (liczba_addr[toString(ile)]) {
        liczba_addr[toString(ile)][addr] = ile;
      } else {
        liczba_addr[toString(ile)] = {};
        liczba_addr[toString(ile)][addr] = ile;
      }
      if (ile > max) {
        max = ile;
      }
    }

    function wybierzNNajczestszych(n) {
      let result = [];
      let i = maximum(max, adresy.length);
      while (n > 0) {
        let ilength = liczba_addr[toString(i)];
        for (let add in ilength) {
          result.push([add, ilength[toString(add)]]);
          n--;
          if (n == 0) {
            break;
          }
        }
        i--;
      }
      return result;
    }

    function wypisz(res) {
      for (let indeks in res) {
        console.log(res[indeks][0], " ", res[indeks][1]);
      }
    }
    var addr_liczba = {};
    var liczba_addr = {};
    var max = 0;

    for (let a in adresy) {
      dodajAdres(adresy[a]);
    }

    let wynik = wybierzNNajczestszych(minimum(ile, Object.keys(addr_liczba)
      .length));
    wypisz(wynik);
  }







  function wczytaj(plik) {
    var adresy = [];

    var myInterface = readline.createInterface({
      input: fs.createReadStream('strumien.txt')
    });

    myInterface.on('line', function(line) {
      let addr = wyluskajAdres(line);
      adresy.push(addr);
    });
    // dzialaj(adresy);
    // return adresy;
    myInterface.on('close', function() {
      dzialaj(adresy);
    });
  }


  a = wczytaj(plik);
  console.log(a);
}

wyluskajAdresy('./strumien.txt', 5);








// function dodajAdres(addr) {
//   let ile = addr_liczba[addr] = addr_liczba[addr] + 1 || 1;
//
//   if (liczba_addr[toString(ile - 1)]) {
//     delete liczba_addr[toString(ile - 1)][addr];
//   }
//   if (liczba_addr[toString(ile)]) {
//     liczba_addr[toString(ile)][addr] = ile;
//   } else {
//     liczba_addr[toString(ile)] = {};
//     liczba_addr[toString(ile)][addr] = ile;
//   }
//   if (ile > max) {
//     max = ile;
//   }
// }



// var myInterface = readline.createInterface({
//   input: fs.createReadStream('strumien.txt')
// });
//
// myInterface.on('line', function(line) {
//     let addr = wyluskajAdres(line);
//     adresy.push(addr);
//   })
//   .on('close', function() {
//     return adresy;
//   });

// for (let a in adresy) {
//   dodajAdres(adresy[a]);
// }

// let wynik = wybierzNNajczestszych(1);

// return wynik;