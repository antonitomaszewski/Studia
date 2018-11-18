function map(a, f) {
  i = 0;
  while (a[i] != undefined) {
    a[i] = f(a[i]);
    i++;
  }
  return a;
}

function forEach(a, f) {
  i = 0;
  while (a[i] != undefined) {
    f(a[i]);
    i++;
  }
  return a;
}

function filter([x, ...xs], f) {
  if (x == undefined) {
    return [];
  } else if (f(x)) {
    return [x, ...filter(xs, f)];
  } else {
    return filter(xs, f);
  }
}
console.log(filter([1, 2, 3, 4, 5], x => x < 3));

// console.log(map([1, 2, 3, 4], _ => _ * _));
var a = [1, 2, 3, 4];
forEach(a, _ => {
  console.log(_);
});
console.log(filter(a, _ => _ < 3));
console.log(map(a, _ => _ * 2));
// console.log(a);
// console.log(...[1, 2, 3]);