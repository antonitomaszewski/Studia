var readline = require('readline');
var fs = require('fs');

var B;

function toString(a) {
  return '' + a;
}

function wyluskajAdres(line) {
  return toString(line.split(" ")[1]);
}

function podwoj(adres) {
  var w = [];
  for (let a in adres) {
    w.push(adres[a]);
    w.push(adres[a]);
  }
  console.log(w);
}

function wczytaj(plik) {
  var adresy = [];

  var myInterface = readline.createInterface({
    input: fs.createReadStream('strumien.txt')
  });

  myInterface.on('line', function(line) {
    let addr = wyluskajAdres(line);
    adresy.push(addr);
    console.log(adresy);
  });
  myInterface.on('close', function() {
    // return adresy;
    // console.log(data);
    console.log(adresy);
    podwoj(adresy);
    (_ => B = _)(adresy);
  });
  return adresy;
}

var A = wczytaj('strumien.txt');
console.log(A);
console.log(B);