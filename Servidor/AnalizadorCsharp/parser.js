var fs = require('fs'); 
var parser = require('./GramaticaCsh');


fs.readFile('./ejemplo.txt', (err, data) => {
    if (err) throw err;
    parser.parse(data.toString());
    console.log(parser.parse(data.toString()));
});
