(function (utils) {

  utils.handleServerError = function (err, req, res, next) {
    var serverErr = {
      message: err.message,
      error: err,
    };
    console.error("server error =>", serverErr);
    res
      .status(err.status || 500)
      .send({ message: serverErr.error.friendlyMessage });
  };

  utils.handleBadRequest = function (err, req, res, next) {
    var validationErr = {
      message: err.message,
      error: err,
    };
    res.status(err.status || 400).send({ message: validationErr.message });
  };

  utils.handleSuccessResponse = function (res, body) {
    utils.handleResponse(res, 200, body);
  };

  utils.handleResponse = function (res, statusCode, body) {
    res.status(statusCode).send(body);
  };
})(module.exports);
