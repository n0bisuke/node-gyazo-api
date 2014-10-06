var path = require('path');
var Gyazo = require(path.resolve()); // load this repos

// var Gyazo = require('gyazo-api'); // load from npm

var client = new Gyazo(process.env.GYAZO_TOKEN);

var img_path = process.argv[2];

client.upload(img_path)
.then(function(res){
  console.log(res.data);
  console.log(res.data.permalink_url);
})
.catch(function(err){
  console.error(err);
});
