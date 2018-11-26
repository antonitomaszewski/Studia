// (() => 'use strict')();

function createFs(n) {
  var fs = [];
  for (var i = 0; i < n; i++) {
    fs[i] =
      function() {
        return i;
      };
  }
  return fs;
}
var myfs = createFs(10);

console.log(myfs[0]());
console.log(myfs[2]());
console.log(myfs[7]());

// var wiąże na całą funkcję, let w danym bloku
// hoisting -> wszystkie definicje są inicjowane na początku funkcji
// przypisania są tam gdzie w kodzie są

function createMyFs(n) {
  var fs = [];

  for (var i = 0; i < n; i++) {
    (i => {
      fs[i] = (() => i);
    })(i);
  }
  return fs;
}

var myfs1 = createMyFs(10);
console.log(myfs1[0]());
// console.log(myfs1[0]()());
console.log(myfs1[2]());
console.log(myfs1[7]());