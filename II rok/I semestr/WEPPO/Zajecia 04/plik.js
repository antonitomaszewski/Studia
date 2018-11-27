// var readline = require('readline');
// var fs = require('fs');
//
// var myInterface = readline.createInterface({
//   input: fs.createReadStream('strumien.txt')
// });
// // console.log(myInterface);
// myInterface.on('line', function(line) {
//   console.log(line);
// });
//
//
// var t = {};
// t['a'] = t['a'] + 1 || 1;
// t['a'] = t['a'] + 1 || 1;
// console.log(t);
// for (var i = 0; i < 10; i++) {
//   let s = '' + i;
//   t[s] = {};
// }
// // delete t['b'];
// console.log(t);
// var a = {
//   '1': {},
//   '2': 2
// };
// if (a['1']) {
//   console.log(32);
// }
// console.log(Object.keys({ '1': 1, '2': 2 })
//   .length);
//
// console.log([
//   [1, 2],
//   [3, 4]
// ]);
// for (var k in t) {
//   console.log(k, " ", t[k]);
// }
//
//
// for (var a in [1, 2, 3, 4]) {
//   console.log(a, " ", [1, 2, 3, 4][a]);
// }

Object.prototype.isEmpty = function() {
  for (var key in this) {
    if (this.hasOwnProperty(key))
      return false;
  }
  return true;
};

function toString(a) {
  return '' + a;
}

function wyluskajAdres(line) {
  return toString(line.split(" ")[1]);
}

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
let a1 = wyluskajAdres("Dsadsaddsafsfg 123 Antoni");
let a2 = wyluskajAdres("fdsgdgdfgf 554.19");
let a3 = wyluskajAdres("godzina 12.0009.9");

console.log(a1, a2, a3);

var liczba_addr = {};
var addr_liczba = {};
var max = 0;

dodajAdres(a1);
dodajAdres(a1);
dodajAdres(a2);
dodajAdres(a2);
dodajAdres(a2);
dodajAdres(a2);
dodajAdres(a3);
dodajAdres(a1);
console.log(liczba_addr);
console.log(addr_liczba);
console.log(max);




function wybierzNNajczestszych(n) {
  let result = [];
  let i = max;
  while (n > 0) {
    let ilength = liczba_addr[toString(i)];
    for (let add in ilength) {
      result.push([add, ilength[add]]);
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
var wynik = wybierzNNajczestszych(3);
console.log(wynik);
wypisz(wynik);
// console.log(typeof a1 === 'string');


var weq = [];
weq.push(1);
console.log(weq);