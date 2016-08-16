var mysql = require('mysql');
var connection = mysql.createConnection({
    host: 'property.coz6tg30r0u1.us-east-1.rds.amazonaws.com',
    user: 'useruser',
    password: 'UserUser1',
    database: 'property',
    multipleStatements: true
});
var request = require('request');

var sqlQuery = 'SELECT * FROM NYCPluto WHERE TRIM(lat) IS NULL LIMIT 1';
//console.log(sqlQuery);

connection.query(sqlQuery, function(err, rows) {
  	
  	//console.log(rows);

	for (var i = 0; i < 1; i++) {
		request('http://nominatim.openstreetmap.org/search?q=14%20washington%20place%20nyc&format=json&polygon=0&addressdetails=1', function (error, response, body) {
		  if (!error && response.statusCode == 200) {
		    var formattedResponse = JSON.parse(body);
		    console.log(formattedResponse[0].lon);
		  }
		})
	}


  	//console.log(rows);
  	//return rows;
  	//connection.end();
});

