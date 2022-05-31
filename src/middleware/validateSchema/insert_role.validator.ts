import { NextFunction, Request, Response } from "express";
import Joi from "joi";
import { HttpException } from "../../errorHandling/httpException";

const roleSchema = Joi.object({
  name: Joi.string().max(50),
  key: Joi.string().max(50),
  roles: Joi.array().items(Joi.number()),
});
export const insertRoleValidator = (
  request: Request,
  resopone: Response,
  next: NextFunction
) => {
  const res = roleSchema.validate(request.body);
  if (res.error)
    return next(new HttpException(400, res.error.details[0].message));
  next();
};
