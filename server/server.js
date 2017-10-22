var express = require("express")
var app = express()
var path = require("path")
var request = require('request');
var bodyParser = require("body-parser")
var https = require("https")
var http = require("http")
https.post = require("https-post")
http.post = require("http-post")
var $;
require('jsdom/lib/old-api').env("", (err, window) => {
    if (err) {
        console.error(err);
        return;
    }

    $ = require("jquery")(window);
});

app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "./static")))

// require('./config/mongoose')
// require("./config/routes")(app)

app.get('/', function (req, res) {
	res.send('Hello Wald!')
})

app.get('/loyalty', function (req, resp) {

	var data = {
	  "accountNumber": 1337,
	  "sku": "item-1234",
	  "totalPriceRequested": 50
	};

	request({
	    url: "https://syf2020.syfwebservices.com/v1_0/loyalty",
	    method: "POST",
	    json: true,   // <--Very important!!!
	    body: data,
	    headers: {
	    	"content-type": "application/json"
	    }
	}, function (error, response, body){
	    resp.send(response.body);
	});

})

app.post('/loyalty', function (req, resp) {
	console.log(req.body)

	request({
	    url: "https://syf2020.syfwebservices.com/v1_0/loyalty",
	    method: "POST",
	    json: true,   // <--Very important!!!
	    body: req.body,
	    headers: {
	    	"content-type": "application/json"
	    }
	}, function (error, response, body){
	    resp.send(response.body);
	});

})

app.post('/amazon', function (req, resp) {
	console.log(req.body.url)

	request({
	    url: req.body.url,
	    method: "GET",
	    json: true,   // <--Very important!!!
	    headers: {
	    	"content-type": "text/html"
	    }
	}, function (error, response, body){
	    // resp.send(response.body);
	    let str = $(response.body).find('#productTitle').text().trim();
	    console.log(str);
	    resp.send(str);
	});
})


app.listen(8000, () => {
	console.log("Hailing frequenices open on port 8000")
})