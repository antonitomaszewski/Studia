function createGenerator(s, e) {
  var _state = s;
  return (() => {
    return {
      next: function() {
        return {
          value: _state,
          done: _state++ >= e
        };
      }
    };
  });
}

var foo = {
  // [Symbol.iterator]: (createGenerator),
  [Symbol.iterator]: createGenerator(5, 10)
};
for (var f of foo)
  console.log(f);
console.log(foo);

// console.log(createGenerator()(4, 7));
// console.log(createGenerator()(4, 7)
//   .next()
//   .next);
// console.log(createGenerator(4, 5)()
//   .next());