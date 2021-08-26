var http = require("http");
var Dispatcher = require("httpdispatcher");
var mysql = require("mysql");

var dispatcher = new Dispatcher();
var port = 9080;

dispatcher.on("get", /^\/ratings\/[0-9]*/, function (req, res) {
  var productIdStr = req.url.split("/").pop();
  var productId = parseInt(productIdStr);

  if (Number.isNaN(productId)) {
    res.writeHead(400, { "Content-type": "application/json" });
    res.end(JSON.stringify({ error: "please provide numeric product ID" }));
  } else {
    var connection = mysql.createConnection({
      host: process.env.MYSQL_DB_HOST,
      port: process.env.MYSQL_DB_PORT || 3306,
      user: process.env.MYSQL_DB_USER,
      password: process.env.MYSQL_DB_PASSWORD,
      database: process.env.MYSQL_DATABASE || "bookdb",
    });

    connection.connect(function (err) {
      if (err) {
        res.end(
          JSON.stringify({
            error: "could not connect to ratings database",
            trace: err,
          })
        );
        return;
      }
      connection.query(
        "SELECT Rating FROM ratings",
        function (err, results, fields) {
          if (err) {
            res.writeHead(500, { "Content-type": "application/json" });
            res.end(
              JSON.stringify({ error: "could not perform select", trace: err })
            );
          } else {
            if (results[0]) {
              firstRating = results[0].Rating;
            }
            if (results[1]) {
              secondRating = results[1].Rating;
            }
            var result = {
              id: productId,
              ratings: {
                Reviewer1: firstRating,
                Reviewer2: secondRating,
              },
            };
            res.writeHead(200, { "Content-type": "application/json" });
            res.end(JSON.stringify(result));
          }
        }
      );
      // close the connection
      connection.end();
    });
  }
});

dispatcher.on("get", "/health", function (req, res) {
  res.writeHead(200, { "Content-type": "application/json" });
  res.end(JSON.stringify({ status: "Ratings is healthy" }));
});

function handleRequest(request, response) {
  try {
    console.log(request.method + " " + request.url);
    dispatcher.dispatch(request, response);
  } catch (err) {
    console.log(err);
  }
}

var server = http.createServer(handleRequest);

server.listen(port, function () {
  console.log("Ratings server listening on port %s", port);
});
