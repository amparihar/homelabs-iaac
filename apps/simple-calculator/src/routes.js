const controller = require("./calculatorController");
const validationSchema = require("./validation-schema");
const utils = require("./utils");

async function validateOperationSchema(req, res, next) {
  try {
    await validationSchema.operationSchema.validateAsync(req.body, {
      abortEarly: true,
    });
    return next();
  } catch (err) {
    utils.handleBadRequest(err, req, res, next);
  }
}

async function validateDivisionOperationSchema(req, res, next) {
  try {
    await validationSchema.divisionOperationSchema.validateAsync(req.body, {
      abortEarly: true,
    });
    return next();
  } catch (err) {
    utils.handleBadRequest(err, req, res, next);
  }
}

var routes = function (app, handlerfn) {
  app.route("/api/calculator/ping").get(handlerfn, controller.ping);

  app
    .route("/api/calculator/add")
    .post([handlerfn, validateOperationSchema], controller.add);

  app
    .route("/api/calculator/subtract")
    .post([handlerfn, validateOperationSchema], controller.subtract);

  app
    .route("/api/calculator/multiply")
    .post([handlerfn, validateOperationSchema], controller.multiply);

  app
    .route("/api/calculator/divide")
    .post([handlerfn, validateDivisionOperationSchema], controller.divide);
};

module.exports = routes;
