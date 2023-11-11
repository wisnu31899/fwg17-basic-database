-- Active: 1699586113023@@127.0.0.1@5432@Coffe Shop@public
CREATE TYPE "roles" AS ENUM ('admin', 'staff', 'customer');
CREATE TABLE "users" (
	"id" SERIAL PRIMARY KEY,
	"fullName" VARCHAR(100) NOT NULL,
	"email" VARCHAR(100) NOT NULL,
	"password" VARCHAR(100) NOT NULL,
	"address" TEXT,
	"picture" VARCHAR(255),
	"phoneNumber" VARCHAR(15) NOT NULL,
	"role" "roles",
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TABLE "products" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL UNIQUE,
    "price" NUMERIC(12,2) NOT NULL,
    "quantity" INT,
    "isAvaiable" BOOLEAN,
    "description" TEXT,
    "image" VARCHAR(100),
    "createdAt" TIMESTAMP DEFAULT now(),
    "updatedAt" TIMESTAMP
);
ALTER TABLE "products" DROP COLUMN "quantity";
ALTER TABLE "products" RENAME "isAvaiable" TO "isAvailable";
CREATE TABLE "categories" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "createdAt" TIMESTAMP DEFAULT now(),
    "updatedAt" TIMESTAMP
);
CREATE TABLE "productCategories"(
    "id" SERIAL PRIMARY KEY,
    "productId" INT REFERENCES "products"("id"),
    "categoriesId" INT REFERENCES "categories"("id"),
    "createdAt" TIMESTAMP DEFAULT now(),
    "updatedAt" TIMESTAMP
);
CREATE TABLE "promo"(
	"id" SERIAL PRIMARY KEY,
	"name" VARCHAR(100) NOT NULL,
	"code" VARCHAR(100) NOT NULL,
	"description" TEXT,
	"percentage" NUMERIC(3,2) NOT NULL,
	"expiredAt" TIMESTAMP NOT NULL,
	"maximumPromo" INT,
	"minimumAmount" INT,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
CREATE TYPE "orderStatus" AS ENUM ('ON-PROCCES', 'DELIVERED', 'CANCELED','READY-TO-PICK');
CREATE TABLE "orders" (
	"id" SERIAL PRIMARY KEY,
	"userId" INT REFERENCES "users"("id"),
    "productCategoriesId" INT REFERENCES "productCategories"("id"),
	"orderNumber" VARCHAR(100) NOT NULL,
	"promoId" INT REFERENCES "promo"("id"),
	"total" INT,
	"taxAmount" INT,
	"status" "orderStatus",
	"deliveryAddress" TEXT,
	"fullName" VARCHAR(100) NOT NULL,
	"created_At" TIMESTAMP DEFAULT now(),
	"updated_At" TIMESTAMP
);
SELECT * FROM "orders";
ALTER TABLE "orders" ALTER COLUMN "total" TYPE NUMERIC(12,2);
ALTER TABLE "orders" ALTER COLUMN "total" SET NOT NULL;
ALTER TABLE "orders" ALTER COLUMN "taxAmount" TYPE NUMERIC(12,2);
INSERT INTO "users"("fullName","email","password","address","picture","phoneNumber","role")
VALUES
	('Agus Setiawan','agussetiawan@gmail.com','agus123','Jl. Merdeka No. 12, Bukit Kecil, Palembang',NULL,'+6281234567890','admin'),
	('Budi Santoso','budisantoso@yahoo.com','budi456','Jl. Raya No. 34, Bukit Kecil, Palembang',NULL,'+6282345678901','staff'),
	('Cici Nurul','cicinurul@hotmail.com','cici789','Jl. Kebun No. 56, Bukit Kecil, Palembang',NULL,'+6283456789012','customer'),
	('Dedi Pratama','dedipratama@outlook.com','dedi012','Jl. Mangga No. 78, Bukit Kecil, Palembang',NULL,'+6284567890123','staff'),
	('Eka Putri','ekaputri@gmail.com','eka345','Jl. Nanas No. 90, Bukit Kecil, Palembang',NULL,'+6285678901234','customer'),
	('John Doe','john.doe@example.com','hashed_password_1','123 Main St, City',NULL,'+6281234567890','admin'),
	('Jane Smith','jane.smith@example.com','hashed_password_2','456 Oak St, Town',NULL,'+6289876543210','staff'),
	('Bob Johnson','bob.johnson@example.com','hashed_password_3','789 Pine St, Village',NULL,'+6281112223333','customer'),
	('Alice Lee','alice.lee@example.com','hashed_password_4','999 Elm St, Hamlet',NULL,'+6284445556666','customer'),
	('David Wang','david.wang@example.com','hashed_password_5','567 Birch St, Suburb',NULL,'+6285556667777','admin');
SELECT * FROM "users" WHERE "password" ILIKE 'agu%';
SELECT * FROM "users" WHERE "password" ILIKE '%123';

INSERT INTO "products" ("name","price","isAvailable","description","image")
VALUES
    ('Espresso', 13000, NULL, NULL, NULL),
    ('Latte', 15000, NULL, NULL, NULL),
    ('Cappuccino', 18000, NULL, NULL, NULL),
    ('Tomato Basil Soup', 25000, NULL, NULL, NULL),
    ('Steak and Arugula Salad', 20000, NULL, NULL, NULL),
    ('Citrus Punch Fizz', 13000, NULL, NULL, NULL),
    ('Berry Hibiscus Cooler', 15000, NULL, NULL, NULL),
    ('Green Tea Mojito', 18000, NULL, NULL, NULL);

SELECT * FROM "products";

INSERT INTO "categories" ("name")
VALUES
    ('coffee'),
    ('food'),
    ('nonCoffe');

INSERT INTO "productCategories" ("productId","categoriesId")
VALUES
    (1,1),
    (2,1),
    (3,1),
    (4,2),
    (5,2),
    (6,3),
    (7,3),
    (8,3);

INSERT INTO "promo" ("name","code","description","percentage","expiredAt","maximumPromo","minimumAmount")
VALUES
    ('Fazz Food 11-11', 'FAZZFOOD50', NULL, 0.5, now() + INTERVAL '1 day', 50000, 20000),
    ('Ditraktir 11-11', 'DITRAKTIR60', NULL, 0.6, now() + INTERVAL '1 day', 35000, 10000);
INSERT INTO "orders"("userId", "orderNumber", "promoId", "total", "taxAmount", "status", "deliveryAddress", "fullName")
VALUES
    (1, '#001-10112023-0001', NULL, (
        (SELECT "price" FROM "products" WHERE "id" = 1) + 
        (SELECT "price" FROM "products" WHERE "id" = 4) + 
        (SELECT "price" FROM "products" WHERE "id" = 8)), 0, 
        'ON-PROCCES', 
        'Jl. Merdeka No. 12, Bukit Kecil, Palembang', 
        'Agus Setiawan');

SELECT * FROM "orders";