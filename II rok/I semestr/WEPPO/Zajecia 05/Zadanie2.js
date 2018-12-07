var http = require('http');
var express = require('express');
var app = express();
app.use((req, res) => {
  res.header('Content-disposition', 'attachment; filename="foo.txt"');
  res.end('tekst');
});

http.createServer(app)
  .listen(3000);