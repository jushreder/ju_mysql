/*
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
5.(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
 SELECT * FROM catalogs WHERE id IN (5, 1, 2);
 Отсортируйте записи в порядке, заданном в списке IN.
*/

drop database if exists home;
create database home;
use home;

ALTER DATABASE `home`
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_roman_ci;


drop table if exists catalogs;
create table catalogs(
      id serial primary key, 
      name varchar(50),
      value int,
      created_at datetime default now(),
      updated_at datetime default now(),
      index (name)
);
 
insert into catalogs (name, value) values 
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

              
select * from catalogs WHERE id IN (5, 1, 2)   
ORDER BY field(id,5,1,2);


               

                         