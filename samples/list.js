var path  = require('path');
var Gyazo = require(path.resolve()); // load this repos

// var Gyazo = require('gyazo-api'); // load from npm

var client = new Gyazo(process.env.GYAZO_TOKEN);

client.list()
.then(function(res){
  console.log(res);
  console.log(res[0]);
})
.catch(function(err){
  console.error(err);
});
