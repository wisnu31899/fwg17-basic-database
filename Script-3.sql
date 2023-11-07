create table if not exists "product"(
	"product_id" serial primary key,
	"product_name" varchar(255) not null,
	"category" varchar(50),
	"price" int not null,
	"many_supply" int not null,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);

insert into "product" ("product_name", "category", "price", "many_supply")
values 
	('cafe latte','coffe',20000,50),
	('long black','coffe',20000,45),
	('espresso','coffe',18000,40),
	('lemon tea','tea',20000,45),
	('lychee tea','tea',20000,40),
	('tea original','tea',15000,50),
	('french fries','food',15000,50),
	('fried rice','food',25000,30);

update "product" set
"product_name" = 'mie goreng',
"category" = 'food',
"price" = 10000,
"many_supply" = 60,
"updated_At" = now()
where "product_id" = 7;

/*delete banyak column dengan in ()*/
delete from "product" where "product_id"  in (9, 10, 11, 12, 13, 14, 15, 16);



create table if not exists "promo"(
	"promo_id" serial primary key,
	"promo_name" varchar(255) not null,
	"discount" decimal(5,2) not null,
	"start_date" date not null,
	"end_date" date not null,
	"description" text,
	"created_At" timestamp default now(),
	"updated_At" timestamp
);

insert into "promo" ("promo_name", "discount", "start_date", "end_date", "description")
values 
	('weekend price',0.20,'2023-11-11','2023-11-12','20% on all items for weekend'),
	('student price',0.15,'2023-11-06','2023-11-12','15% special discount on all items for student with student ID'),
	('couple price',0.25,'2021-11-06','2023-11-10','25% on all items with couple clothes');
	
update "promo" set
"promo_name" = 'two days coffe',
"discount" = 0.20,
"start_date" = '2023-11-07',
"end_date" = '2023-11-08',
"description" = '20% all coffe item because two days full in coffe',
"updated_At" = now()
where "promo_id" = 1;

delete from "promo" where "promo_id" in (4,5,6);
/*delete 1 column hanya dengan =*/
delete from "promo" where "promo_id" = 3;



create table if not exists "order"(
	"order_id" serial primary key,
	"costumer_name" varchar(255) not null,
	"order_date" date not null,
	"total" int not null,
	"status" varchar(50) default 'pending',
	"created_At" timestamp default now(),
	"updated_At" timestamp
);

insert into "order" ("costumer_name", "order_date", "total", "status")
values 
	('hilda','2023-11-06',63000,'completed'),
	('maulana','2023-11-08',60000,'pending'),
	('nadya','2023-11-11',100000,'pending');
	
update "order" set
"costumer_name" = 'fajri',
"order_date" = '2023-11-11',
"total" = '120000',
"status" = 'completed',
"updated_At" = now()
where "order_id" = 3;

delete from "order" where "id" in (4,5,6);
delete from "order" where "order_id" = 1;



create table if not exists "user"(
	"user_id" serial primary key,
	"user_name" varchar(255) not null,
	"password" varchar(50) not null,
	"fullname" varchar(255) not null,
	"email" varchar(255) not null,
	"gender" varchar(10) check ("gender" in ('Laki-laki', 'Perempuan')),
	"created_At\" timestamp default now(),
	"updated_At" timestamp
);

insert into "user" ("user_name", "password", "fullname", "email","gender")
values 
	('hilda_1','pw_1','hilda chintia','hilda.chintia@gmail.com','Perempuan'),
	('maulana_2','pw_2','maulana rido','maulana.rido@gmail.com','Laki-laki'),
	('nindya_3','px_3','nindya kurnia','nindya.kurnia@gmail.com','Perempuan');
	
update "user" set
"user_name" = 'fajri_4',
"password" = 'px_4',
"fullname" = 'fajri pangestu',
"email" = 'fajri.pangestu@gmail.com',
"gender" = 'Laki-laki',
"updated_At" = now()
where "user_id" = 3;

delete from "user" where "user_id" = 1;
delete from "user" where "user_id" in (4, 5, 6);

/*penggunaan alter*/
/*mengganti nama pada table "product*/
alter table "product" rename "many_supply" to "quantity";
alter table "product" rename "product_id" to "id";
alter table "promo" rename "promo_id" to "id";
alter table "order" rename "order_id" to "id";
alter table "user" rename "user_id" to "id";

/*menambah column pada table "product*/
alter table "product" add column "description" text;
alter table "product" add column "inAvaliable" bool;
alter table "promo" add column "category" varchar(50);
update "promo" set "category" = 'coffe' where "promo_id" = 1;
update "promo" set "category" = 'food' where "promo_id" = 2;
update "promo" set "description" = '15% special discount on food items for student with student ID' where "promo_id" = 2;

/*menghapus column pada table "product*/
alter table "product" drop column "inAvaliable";

/*mengganti tipe data column pada table "user"*/
alter table "user" alter column "gender" type varchar(50);

/*menambah batasan isi column pada table "user"*/
alter table "user" add constraint year_check check ("gender" in ('Laki-laki', 'Perempuan'));

/*penggunaan relation*/
/*pada table "order"*/
/*mengganti nama*/
alter table "order" rename "costumer_name" to "user_id";
/*ubah menjadi int = 0*/
update "order" set
"user_id" = 0
where "id" in (2,3);
/*definisikan int pada column "user_id"*/
alter table "order" alter column "user_id" type int using "user_id"::int;
/* buatkan reference antara "user_id" dengan "id" dari table "user" (masih error)*/
alter table "order" add column "user_id" int references "user" ("id");

/*penggunaan select & join*/
/* untuk ambil semua data (*) dengan sort (category = coffe)*/
select *from "product" where "category" = 'coffe';