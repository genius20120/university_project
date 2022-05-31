-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "last_name" VARCHAR(50) NOT NULL,
    "phone" VARCHAR(20) NOT NULL,
    "national_id" INTEGER NOT NULL,
    "personal_id" INTEGER NOT NULL,
    "birthday" TIMESTAMP(3) NOT NULL,
    "entery_year" SMALLINT,
    "study_field" VARCHAR(50),
    "photo" VARCHAR(100),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assigned_by" INTEGER NOT NULL,
    "role_id" SMALLINT NOT NULL,
    "assigned_projects" INTEGER,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "account_status" (
    "id" INTEGER NOT NULL,
    "status" VARCHAR(10) NOT NULL,
    "description" VARCHAR(100),
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "account_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SMALLSERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permisions" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "key" VARCHAR(50) NOT NULL,

    CONSTRAINT "permisions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permisions_of_roles" (
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "permision_id" INTEGER NOT NULL,
    "role_id" SMALLINT NOT NULL,

    CONSTRAINT "permisions_of_roles_pkey" PRIMARY KEY ("permision_id","role_id")
);

-- CreateTable
CREATE TABLE "project_helper" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,

    CONSTRAINT "project_helper_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_student" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "student_id" INTEGER NOT NULL,

    CONSTRAINT "project_student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_process" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(50) NOT NULL,
    "description" VARCHAR(2000) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "project_id" INTEGER,

    CONSTRAINT "project_process_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_defence_details" (
    "id" SERIAL NOT NULL,
    "place" VARCHAR(50) NOT NULL,
    "time" TIMESTAMP NOT NULL,
    "description" VARCHAR(1000) NOT NULL,
    "project_id" INTEGER NOT NULL,

    CONSTRAINT "project_defence_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_defence" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "project_defence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_permisionsToroles" (
    "A" INTEGER NOT NULL,
    "B" SMALLINT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "account_status_user_id_key" ON "account_status"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "permisions_name_key" ON "permisions"("name");

-- CreateIndex
CREATE UNIQUE INDEX "permisions_key_key" ON "permisions"("key");

-- CreateIndex
CREATE UNIQUE INDEX "project_helper_project_id_key" ON "project_helper"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "project_student_project_id_key" ON "project_student"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "project_student_student_id_key" ON "project_student"("student_id");

-- CreateIndex
CREATE UNIQUE INDEX "project_defence_details_project_id_key" ON "project_defence_details"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "_permisionsToroles_AB_unique" ON "_permisionsToroles"("A", "B");

-- CreateIndex
CREATE INDEX "_permisionsToroles_B_index" ON "_permisionsToroles"("B");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_assigned_projects_fkey" FOREIGN KEY ("assigned_projects") REFERENCES "project_helper"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "account_status" ADD CONSTRAINT "account_status_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permisions_of_roles" ADD CONSTRAINT "permisions_of_roles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permisions_of_roles" ADD CONSTRAINT "permisions_of_roles_permision_id_fkey" FOREIGN KEY ("permision_id") REFERENCES "permisions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_helper" ADD CONSTRAINT "project_helper_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project_defence"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_student" ADD CONSTRAINT "project_student_student_id_fkey" FOREIGN KEY ("student_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_student" ADD CONSTRAINT "project_student_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project_defence"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_process" ADD CONSTRAINT "project_process_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project_defence"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_defence_details" ADD CONSTRAINT "project_defence_details_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project_defence"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permisionsToroles" ADD CONSTRAINT "_permisionsToroles_A_fkey" FOREIGN KEY ("A") REFERENCES "permisions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_permisionsToroles" ADD CONSTRAINT "_permisionsToroles_B_fkey" FOREIGN KEY ("B") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
