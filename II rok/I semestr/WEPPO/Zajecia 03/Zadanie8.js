function* fib() {
  var a = 0;
  var b = 1;

  while (true) {
    yield a;
    let aux = a;
    a = b;
    b += aux;
  }
}

var it = fib();

function* take(it, top) {
  for (var res; res = it.next(), !res.done, top != 0;) {
    yield res.value;
    top--;
  }
}

function prin(tab) {
  for (var num of tab) {
    console.log(num);
  }
}
prin(take(it, 5));


function fib2() {
  var a = -1;
  var b = 1;

  return {
    next: function() {
      let aux = a;
      a = b;
      b += aux;

      return {
        value: b,
        done: false
      };
    }
  };
}

var foo = fib2();
prin(take(foo, 5));



// function* take5(it, top = 100) {
//   for (var res = it.next(); top != 0; res = it.next()) {
//     yield(res.value);
//     top--;
//   }
// }
// prin(take5(it, 5));


// console.log(take5(foo));