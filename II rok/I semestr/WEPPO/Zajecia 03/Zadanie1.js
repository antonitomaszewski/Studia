console.log("obiekt");
var obiekt = {
  v: 1,
  double: function() {
    return 2 * this.v;
  },
  get f() {
    return this.v;
  },
  set f(v) {
    this.v = v;
    return;
  }
};

console.log(obiekt.double());
console.log(obiekt.f);
obiekt.f = 5;
console.log(obiekt.f);



console.log("\ndrugi");
var drugi = {

};

Object.defineProperty(drugi, 'v', {
  value: 3,
  writable: true
});
Object.defineProperty(drugi, 'double', {
  value: function() {
    return this.v * 2;
  }
});
Object.defineProperty(drugi, 'fv', {
  get: function() {
    return this.v;
  },
  set: function(v) {
    this.v = v;
  }
});
console.log("v = ", drugi.v);
drugi.fv = 4;
console.log("v = ", drugi.fv);
console.log(drugi.double());



console.log("\ntrzeci");
var trzeci = {};
trzeci.v = 11;
// trzeci['v'] = 12;
console.log(trzeci);
trzeci.double = function() {
  return this.v * 2;
};
console.log(trzeci.double());