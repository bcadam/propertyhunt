
var mysql = require('mysql');
var express = require('express');
var app = express();
var apiRouter = express.Router();
var fs  = require('fs');

app.use('/api', apiRouter);
app.set('port', (process.env.PORT || 5000));
app.use(express.static(__dirname + '/public'));
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');


var websiteInfo = {title:"PropertyHunt"};


app.get('/', function(request, response) {
    response.render('pages/index', {root: __dirname, websiteInfo: websiteInfo});
});

app.get('/about', function(request, response) {
    response.render('pages/about', {root: __dirname, websiteInfo: websiteInfo});
});

app.get('/tos', function(request, response) {
    response.render('pages/tos', {root: __dirname, websiteInfo: websiteInfo});
});

var connection = mysql.createConnection({
    host: 'property.coz6tg30r0u1.us-east-1.rds.amazonaws.com',
    user: 'useruser',
    password: 'UserUser1',
    database: 'property',
    multipleStatements: true
});

function turnBoroghWordToAbbreviation(boroughword){
	switch(boroughword) {
	    case "Manhattan":
	        return "MN";
	        break;
	    case "Staten Island":
	        return "SI";
	        break;
	    case "Brooklyn":
	        return "BK";
	        break;
	    case "Bronx":
	        return "BX";
	        break;
	    case "Queens":
	        return "QN";
	        break;
	    default:
	    	return boroughword;
	        break;
	}
}

function getPluto(boroughword,zipcode,lot,address){
	// { number: '70',
	//  streetaddress: 'Battery Place',
	//  boroughword: 'Manhattan',
	//  zipcode: '10280',
	//  lot: '20',
	//  address: '70 BATTERY PLACE',
	//  boroughcode: '1' }



    var sqlQuery = 'SELECT * FROM NYCPluto WHERE Address = "' + address + '" AND Borough = "'+ turnBoroghWordToAbbreviation(boroughword) +'" AND ZipCode = "' + zipcode + '" AND Lot="'+ lot +'" LIMIT 10';
    //console.log(sqlQuery);

    connection.query(sqlQuery, function(err, rows) {
	  	//console.log(rows);
	  	return rows;
	  	//connection.end();
	});
}

function getPlutoAndBuildingAndMarket(query,response){
	// { number: '70',
	//  streetaddress: 'Battery Place',
	//  boroughword: 'Manhattan',
	//  zipcode: '10280',
	//  lot: '20',
	//  address: '70 BATTERY PLACE',
	//  boroughcode: '1' }

    var connection = mysql.createConnection({
        host: 'property.coz6tg30r0u1.us-east-1.rds.amazonaws.com',
        user: 'useruser',
        password: 'UserUser1',
        database: 'property',
		multipleStatements: true
    });

    var plutoQuery = 'SELECT * FROM NYCPluto WHERE Address = "' + query.address + '" AND Borough = "'+ turnBoroghWordToAbbreviation(query.boroughword) +'" AND ZipCode = "' + query.zipcode + '" AND Lot="'+ query.lot +'" LIMIT 10;';
    // console.log(plutoQuery);
    var buildingQuery = 'SELECT * FROM NYCBuildings WHERE lhnd <= "'+ query.number + '" AND hhnd >= "' + query.number + '" AND stname = "' + query.streetaddress + '" AND boro = "'+ query.boroughcode +'" AND ZipCode = "' + query.zipcode + '" LIMIT 10;';
    // console.log(buildingQuery);
    var marketQuery = 'SELECT * FROM NYCFarmersMarket WHERE ZipCode = "'+ query.zipcode + '" LIMIT 10;';
    //console.log(marketQuery);

    var combinedSearchString = plutoQuery + buildingQuery + marketQuery;

    connection.query(combinedSearchString, function(err, results) {

    	//console.log(results[2][0]);

	  	if (err) throw err;
	  	var result={};
	  	for(var key in results[0][0]) result[key]=results[0][0][key];
		for(var key in results[1][0]) result[key]=results[1][0][key];
		//for(var key in results[2]) result[key]=results[2][key];
		result.farmersMarkets = results[2];

		//console.log(result);
		//console.log(buildingInfo);
		//return(buildingInfo);
	  	// console.log(results[1]); // [{2: 2}]

	  	// console.log("query");
	  	//console.log(query);
	  	// console.log("result");
	  	//console.log(result);
	  	response.render('pages/report', {root: __dirname, cat:'steven', data:query, result: result, websiteInfo : websiteInfo});
	});
}

function getBinInfo(bin,response){
	// { number: '70',
	//  streetaddress: 'Battery Place',
	//  boroughword: 'Manhattan',
	//  zipcode: '10280',
	//  lot: '20',
	//  address: '70 BATTERY PLACE',
	//  boroughcode: '1' }

    var dobComplaints = 'SELECT * FROM DOBComplaints WHERE BIN = "' + bin + '" LIMIT 20;';
    var permitIssuance = 'SELECT * FROM DOBPermitIssuance WHERE Bin = "' + bin + '" LIMIT 20;';
	var maintenanceCodeViolations = 'SELECT * FROM HousingMaintenanceCodeViolations WHERE BuildingId = "' + bin + '" LIMIT 20;';
    
    // console.log(permitIssuance);
    // console.log(dobComplaints);
    // console.log(maintenanceCodeViolations);

    var combinedSearchString = dobComplaints + permitIssuance + maintenanceCodeViolations;

    connection.query(combinedSearchString, function(err, results) {
	  	if (err) throw err;
	 //  	var result={};
	 //  	for(var key in results[0][0]) result[key]=results[0][0][key];
		// for(var key in results[1][0]) result[key]=results[1][0][key];
		//for(var key in results[2]) result[key]=results[2][key];
		//result.farmersMarkets = results[2][0];

	  	//console.log(results);
	  	response.json({complaints:results[0], permits: results[1], violations :results[2]});
	});
};

app.get('/report', function(request, response) {
	var query = require('url').parse(request.url,true).query;
	getPlutoAndBuildingAndMarket(query,response);
});

apiRouter.get('/bin/:bin', function(request, response) {
    getBinInfo(request.params.bin,response);
}); 

apiRouter.get('/test', function(request, response) {
    var sqlQuery = 'SELECT * FROM NYCPluto LIMIT 10';
    //console.log(sqlQuery);

    connection.query(sqlQuery, function(err, rows) {
    	if(err){console.log(err)};
	  	console.log(rows);
	  	response.json(rows);
	  	//connection.end();
	});
}); 

apiRouter.get('/pluto/:number/:street?/:borough?/:zipcode?', function(request, response) {
	var number = request.params.number;
	var street = request.params.street;
	var borough = request.params.borough;
	var zipcode = request.params.zipcode;

	switch(borough) {
	    case "Manhattan":
	        borough = "MN";
	        break;
	    case "Staten Island":
	        borough = "SI";
	        break;
	    case "Brooklyn":
	        borough = "BK";
	        break;
	    case "Bronx":
	        borough = "BX";
	        break;
	    case "Queens":
	        borough = "QN";
	        break;
	    default:
	        break;
	}

	//console.log(street);

    var sqlQuery = 'SELECT * FROM NYCPluto WHERE Address = "'+ number + " " + street + '" AND Borough = "'+ borough +'" AND ZipCode = "' + zipcode + '" LIMIT 10';
    //console.log(sqlQuery);


    connection.query(sqlQuery, function(err, rows) {
	  	// connected! (unless `err` is set)
	  	// console.log(rows);
	  	response.json(rows);
	  	//connection.end();
	});   
});

apiRouter.get('/building/:number/:street?/:borough?/:zipcode?', function(request, response) {
	var number = request.params.number;
	var street = request.params.street;
	var borough = request.params.borough;
	var zipcode = request.params.zipcode;

	switch(borough) {
	    case "MN":
	        borough = "1";
	        break;
	    case "SI":
	        borough = "5";
	        break;
	    case "BK":
	        borough = "3";
	        break;
	    case "BX":
	        borough = "2";
	        break;
	    case "QN":
	        borough = "4";
	        break;
	    default:
	        break;
	}

	console.log(street);

	//SELECT * FROM NYCBuildings WHERE lhnd = "70" AND boro = "1" AND stname = "Battery Place" LIMIT 10

    var sqlQuery = 'SELECT * FROM NYCBuildings WHERE lhnd <= "'+ number + '" AND hhnd >= "' + number + '" AND stname = "' + street + '" AND boro = "'+ borough +'" AND ZipCode = "' + zipcode + '" LIMIT 10';
    //console.log(sqlQuery);


    connection.query(sqlQuery, function(err, rows) {
  	// connected! (unless `err` is set)
  	// console.log(rows);
  	response.json(rows);
  	//connection.end();
	}); 
});

apiRouter.get('/violations/:bin', function(request, response) {
	//SELECT * FROM NYCBuildings WHERE lhnd = "70" AND boro = "1" AND stname = "Battery Place" LIMIT 10
    var sqlQuery = 'SELECT * FROM HousingMaintenanceCodeViolations WHERE BuildingID = "' + request.params.bin + '" LIMIT 10';
    // console.log(sqlQuery);

    connection.query(sqlQuery, function(err, rows) {
  	// connected! (unless `err` is set)
  	// console.log(rows);
  	response.json(rows);
  	//connection.end();
	});   
});

app.listen(app.get('port'), function() {
    console.log('Node app is running on port', app.get('port'));
});

Number.prototype.formatMoney = function(c, d, t){
var n = this, 
    c = isNaN(c = Math.abs(c)) ? 2 : c, 
    d = d == undefined ? "." : d, 
    t = t == undefined ? "," : t, 
    s = n < 0 ? "-" : "", 
    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
    j = (j = i.length) > 3 ? j % 3 : 0;
   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
 };


