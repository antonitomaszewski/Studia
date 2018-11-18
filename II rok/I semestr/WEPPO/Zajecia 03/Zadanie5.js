function sum() {
  let sum = 0;
  let i = 0;
  while (arguments[i] != undefined) {
    sum += arguments[i];
    i++;
  }
  return sum;
}
console.log(sum(1, 2, 3));
console.log(sum(1, 2, 3, 4, 5));