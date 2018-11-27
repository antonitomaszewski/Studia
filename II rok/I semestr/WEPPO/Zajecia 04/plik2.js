var readline = require('readline');
var fs = require('fs');
var adresy = [];

function toString(a) {
  return '' + a;
}

function wyluskajAdres(line) {
  return toString(line.split(" ")[1]);
}

var myInterface = readline.createInterface({
  input: fs.createReadStream('strumien.txt'),
  output: process.stdout,
  terminal: false
});

var i = 0;
myInterface.on('line', function(line) {
  let addr = wyluskajAdres(line);
  // console.log(line);
  console.log(i);
  adresy.push(addr);
  console.log(addr);
  i++;
});
console.log(adresy);
myInterface.on('close', function() {
  console.log(adresy);
});


// console.log(adresy);