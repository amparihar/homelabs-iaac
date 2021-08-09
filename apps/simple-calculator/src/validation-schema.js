const Joi = require("joi");

const operationSchema = Joi.object({
  operand1: Joi.number().required(),
  operand2: Joi.number().required(),
});

const divisionOperationSchema = Joi.object({
  operand1: Joi.number().required(),
  operand2: Joi.number().not(0).required(),
});

module.exports = {
  operationSchema,
  divisionOperationSchema,
};
