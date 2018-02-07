var fs = require('fs');
const testFolder = '../matrices/';
var names = [];

fs.readdirSync(testFolder).forEach(file => {
    names.push(file.toString());
});
console.log(names)
for (i = 0; i < names.length; i++) {
    fs.readFile('../matrices/'+names[i], function(err, buf) {
    console.log(buf.toString());
    });
}