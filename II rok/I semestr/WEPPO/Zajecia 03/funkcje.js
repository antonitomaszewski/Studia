// https://medium.com/dailyjs/functional-js-with-es6-recursive-patterns-b7d0813ef9e3
const head = ([x]) => x;
const tail = ([, ...xs]) => xs;
const def = x => typeof x != "undefined";
const undef = x => !def(x);
const copy = array => [...array];
const length = ([x, ...xs], len = 0) => (def(x) ? length(xs, len + 1) : len);
const reverse = ([x, ...xs]) => (def(x) ? [...reverse(xs), x] : []);
const first = ([x, ...xs], n = 1) => def(x) && n ? [x, ...first(xs, n - 1)] : [];
const last = (xs, n = 1) => reverse(first(reverse(xs), n));
const slice = ([x, ...xs], i, y, curr = 0) =>
  def(x) ?
  curr === i ? [y, x, ...xs] : [x, ...slice(xs, i, y, curr + 1)] : [];
const isArray = x => Array.isArray(x);
const flatten = ([x, ...xs]) => def(x) ?
  isArray(x) ? [...flatten(x), ...flatten(xs)] : [x, ...flatten(xs)] : [];
let a = [1, 2, 3, 4, 5];
a = slice(a, 2, 10);
console.log(a);
console.log([1, ]);