var fibonacci = (function() {
  var memo = {};

  function f(n) {
    var value;

    if (n in memo) {
      value = memo[n];
    } else {
      if (n === 0 || n === 1)
        value = n;
      else
        value = f(n - 1) + f(n - 2);

      memo[n] = value;
    }

    return value;
  }

  return f;
})();

console.time();
fibonacci(500);
console.timeEnd();
console.time();
fibonacci(500);
console.timeEnd();



function memo(fn) {
  var cache = {};
  return function(n) {
    if (n in cache) {
      return cache[n];
    } else {
      result = fn(n);
      cache[n] = result;
      return result;
    }
  };
}

var fib = memo(
  function(n) {
    if (n < 2) {
      return n;
    } else {
      return fib(n - 1) + fib(n - 2);
    }
  }
);


console.time();
fib(50);
console.timeEnd();
console.time();
fib(50);
console.timeEnd();