import { NextFunction, Request, Response, Router } from "express";
import { HttpException } from "../errorHandling/httpException";
import { insertUserRequestValidator } from "../middleware/validateSchema/insert_user.validator";
import { LoginRequestValidate } from "../middleware/validateSchema/login.validator";
import { loginService } from "../service/user.service";

export const userRoute = Router();
export const roleRoute = Router();
userRoute.post(
  "/insert",
  [insertUserRequestValidator],
  async (req: Request, res: Response, next: NextFunction) => {
    const result = await loginService(req.body.phone, req.body.code);
    if (result instanceof HttpException) return next(result);
    return res.status(200).send(result);
  }
);
roleRoute.post(
  "/insert",
  [insertUserRequestValidator],
  async (req: Request, res: Response, next: NextFunction) => {
    const result = await loginService(req.body.phone, req.body.code);
    if (result instanceof HttpException) return next(result);
    return res.status(200).send(result);
  }
);
roleRoute.get(
  "/getAll",
  [],
  async (req: Request, res: Response, next: NextFunction) => {
    const result = await loginService(req.body.phone, req.body.code);
    if (result instanceof HttpException) return next(result);
    return res.status(200).send(result);
  }
);
userRoute.get(
  "/getAll",
  [],
  async (req: Request, res: Response, next: NextFunction) => {
    const result = await loginService(req.body.phone, req.body.code);
    if (result instanceof HttpException) return next(result);
    return res.status(200).send(result);
  }
);
