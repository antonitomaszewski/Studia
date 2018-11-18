var memo = {
  callCount: 0,
  cache: {},
};

var fib = memo;
Object.defineProperty(fib, 'fun', {
  value: function(n) {
    this.callCount += 1;
    if (n in this.cache) {
      return this.cache[n];
    } else {
      if (n < 2) {
        this.cache[n] = n;
        return n;
      } else {
        var result = this.fun(n - 1) + this.fun(n - 2);
        this.cache[n] = result;
        return result;
      }
    }
  }
});
console.log(fib);
console.log(memo);
fib.fun(5);
console.log(memo);
console.log(fib);
fib.fun(5);
console.log(fib);

console.time();
fib.fun(1000);
console.timeEnd();
console.time();
fib.fun(1000);
console.timeEnd();