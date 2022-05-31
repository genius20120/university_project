import express, { Request, Response } from "express";
import { loginRoute } from "./controller/login.router";
import cors from "cors";
import { ErrorHandlingMiddleware } from "./errorHandling/httpException";
import { roleRoute, userRoute } from "./controller/user_role.router";


const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.get("/", (req, res) => res.send("ok"));
app.use(loginRoute);
app.use("/user", userRoute);
app.use("/role", roleRoute);
app.use(ErrorHandlingMiddleware);
console.log("its here");

app.listen(4000, () => {
  console.log("server running");
});
