const prometheus = require("prom-client");
const utils = require("./utils");

const register = new prometheus.Registry();
// Add a default label which is added to all metrics
register.setDefaultLabels({
  app: 'simple-calculator'
});
// Enable the collection of default metrics
prometheus.collectDefaultMetrics({ register });

const no_of_add_api_requests = new prometheus.Counter({
  name : "no_of_add_api_requests",
  help: "no_of_add_api_requests"
});
register.registerMetric(no_of_add_api_requests);

var ping = async (req, res, next) => {
  utils.handleSuccessResponse(
    res,
    "Pong reply from Simple Calculator microservice"
  );
};

var metrics = async (req, res, next) => {
  res.status(200).set('Content-Type', 'text/plain');
  res.end(await register.metrics());
}

var add = async (req, res, next) => {
  try {
    no_of_add_api_requests.inc();
    var { operand1, operand2 } = req.body;
    var result = operand1 + operand2;
    utils.handleSuccessResponse(res, { result });
  } catch (err) {
    next({
      ...err,
      friendlyMessage: "An error occurred. Please try later",
    });
  }
};

var subtract = async (req, res, next) => {
  try {
    var { operand1, operand2 } = req.body;
    var result = operand1 - operand2;
    utils.handleSuccessResponse(res, { result });
  } catch (err) {
    next({
      ...err,
      friendlyMessage: "An error occurred. Please try later",
    });
  }
};

var multiply = async (req, res, next) => {
  try {
    var { operand1, operand2 } = req.body;
    var result = operand1 * operand2;
    utils.handleSuccessResponse(res, { result });
  } catch (err) {
    next({
      ...err,
      friendlyMessage: "An error occurred. Please try later",
    });
  }
};

var divide = async (req, res, next) => {
  try {
    var { operand1, operand2 } = req.body;
    var result = operand1 / operand2;
    utils.handleSuccessResponse(res, { result });
  } catch (err) {
    next({
      ...err,
      friendlyMessage: "An error occurred. Please try later",
    });
  }
};

const controller = {
  ping,
  metrics,
  add,
  subtract,
  multiply,
  divide,
};

module.exports = controller;
