/*
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
В таблице складских запасов storehouses_products в поле value могут встречаться
 самые разные цифры: 0, если товар закончился и выше нуля, если на складе 
 имеются запасы.
*/

drop database if exists home;
create database home;
use home;

ALTER DATABASE `home`
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_roman_ci;


drop table if exists storehouses_products;
create table storehouses_products(
      id serial primary key, 
      name varchar(50),
      value int,
      created_at datetime default now(),
      updated_at datetime default now(),
      index (name)
);
 
insert into storehouses_products (name, value) values 
                 ('Printer 10',15),
                 ('Printer 15',35),
                 ('Printer 20',0),
                 ('Printer 25',4),
                 ('Printer 30',200),
                 ('Printer 40',120),
                 ('Printer 45',70),
                 ('Printer 50',58),
                 ('Printer 55',8),
                 ('Printer 60',0);

/* отсортировать записи таким образом, чтобы они выводились в порядке увеличения
 значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/               

 select name, value from storehouses_products ORDER BY
 case 
 when value!= 0 then value
 when value = 0 then 65000
 end ;

               

                         