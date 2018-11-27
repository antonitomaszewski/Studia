let std = 'Witaj ';
process.stdin.write("Podaj imię i nazwisko ");

process.stdin.on('data', function(chunk) {
   process.stdin.end(std + chunk);
});


  // if (String(chunk).slice(-1) == '\n') {
  //   // console.log('Witaj ', std);
  //   // std = "Witaj"
  //   process.stdin.end(std + chunk);
  // } else {
  //   std += String(chunk);
  // }




// process.stdin.setEncoding('utf8');

// process.stdin.write("Podaj imię i nazwisko");
// process.stdin.on('readable', () => {
//   var chunk = process.stdin.read();
//   while (chunk == null) {
//     chunk = process.stdin.read();
//   }
//   // if (chunk != '\n') {
//   //   process.stdout.write(`data: ${chunk}`);
//   // }

//   process.stdout.write(`data: ${chunk}`);

//   process.stdin.on('end', () => {
//     process.stdout.write('end');
//   });
//   process.stdin.end();
// });

// process.stdin.on('end', () => {
//   process.stdout.write('end');
// });