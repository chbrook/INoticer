const http = require('http');

http.createServer((req, res) => {
  console.log('request received', req.url);
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(8080)