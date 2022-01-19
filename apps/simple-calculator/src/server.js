console.log("Initializing simple Calculator microservice");

const fs = require("fs").promises;
const path = require("path");
const express = require("express");
const cors = require("cors");
const utils = require("./utils");

const AWSXRay = require("aws-xray-sdk");
const XRayExpress = AWSXRay.express;

const calculator = {
  routes: require("./routes"),
};

var app = express();
app.set("port", 9001);
app.use(cors());

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.use(XRayExpress.openSegment("Simple Calculator Microservice"));

function handlerFn(req, res, next) {
  const dataPath = path.join(process.env.DATA_PATH || "./data.txt");
  fs.readFile(dataPath)
  .then(buffer => {
    const data = buffer.toString();
    writeTo(dataPath, +data + 1);
  })
  .catch(e => {
    console.log("file not found, writing '0' to a new file");
    writeTo(dataPath, 0);
  });
  next();
}

const writeTo = (dataPath, data) => {
  fs.writeFile(dataPath, data.toString()).catch(console.error);
};

// Initial Route
app.get("/", handlerFn, function (req, res) {
  res.redirect("/api");
});

app.route("/api").get(handlerFn, function (req, res) {
  var __path = path.resolve("./");
  res.sendFile(__path + "/public/api.html");
});

// Setup app routes
calculator.routes(app, handlerFn);

// 404 route
app.use(function (req, res) {
  res
    .status(404)
    .send(
      "No matching route found for " +
        req.protocol +
        "://" +
        req.get("host") +
        req.originalUrl
    );
});

app.use(utils.handleServerError);

app.use(XRayExpress.closeSegment());

// start server
app.listen(app.get("port"), function () {
  console.log(
    "simple calculator microservice started on port " + app.get("port")
  );
});
