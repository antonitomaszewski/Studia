function fib() {
  var a = -1;
  var b = 1;
  var n = 0;
  return {
    next: function() {
      let aux = a;
      a = b;
      b += aux;
      n++;

      return {
        value: b,
        done: n > 10,
      };
    }
  };
}

var foo = {
  [Symbol.iterator]: fib
};

console.log("Zwykłe, var of");
for (var f of foo)
  console.log(f);
// To nie działa
// for (var f of fib())
//   console.log(f);

var it1 = fib();
console.log("\nZwykłe, it.next()");
for (var res; res = it1.next(), !res.done;) {
  console.log(res.value);
}


function* fibY() {
  var a = 0;
  var b = 1;
  var n = 0;

  while (n < 10) {
    yield a;
    let aux = a;
    a = b;
    b += aux;
    n++;
  }
}
var fY = {
  [Symbol.iterator]: fibY
};

console.log("\nYield, var of fY");
for (var f of fY)
  console.log(f);

var it2 = fibY();
console.log("\nYield, it.next()");
for (var res; res = it2.next(), !res.done;) {
  console.log(res.value);
}
// console.log(it2.next());

console.log("\nYield, var of fibY()");
for (var f of fibY())
  console.log(f);