import { PrismaClient, users } from "@prisma/client";
import { includes } from "lodash";
import { HttpException } from "../../errorHandling/httpException";

const db = new PrismaClient();
export async function loginRepository(
  phone: string
): Promise<users | HttpException> {
  const user = await db.users.findFirst({
    where: {
      phone,
    },
    include: {
      role: {
        include: {
          permisions_of_roles: {
            include: {
              permision: true,
            },
          },
        },
      },
    },
  });
  if (user) return user;
  return new HttpException(404, "user with this phone doesnt exist");
}
export async function getAllUsers() {
  const user = db.users.findMany();
  return user;
}
