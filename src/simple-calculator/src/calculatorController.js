const utils = require("./utils");

var ping = async (req, res, next) => {
  utils.handleSuccessResponse(
    res,
    "Pong reply from Simple Calculator microservice"
  );
};

var add = async (req, res, next) => {
  try {
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
  add,
  subtract,
  multiply,
  divide,
};

module.exports = controller;
