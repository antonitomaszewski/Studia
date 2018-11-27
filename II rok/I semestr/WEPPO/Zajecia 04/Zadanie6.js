// var fs = require('fs');
//
// var data = '';
//
// var readStream = fs.createReadStream('strumien.txt', 'utf8');
//
//
// readStream.on('data', function(chunk) {
//   data += chunk;
// });
// readStream.on('end', function() {
//   console.log(data);
// });



var fs = require('fs');
var readableStream = fs.createReadStream('strumien.txt');
var data = '';
var chunk;

readableStream.on('readable', function() {
  while ((chunk = readableStream.read()) != null) {
    data += chunk;
  }
});

readableStream.on('end', function() {
  console.log(data);
});


//