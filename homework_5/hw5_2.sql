/*
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
Таблица users была неудачно спроектирована. Записи created_at и updated_at были
заданы типом VARCHAR и в них долгое время помещались значения в формате 
 "20.10.2017 8:10"
*/

drop database if exists home;
create database home;
use home;

ALTER DATABASE `home`
DEFAULT CHARACTER SET utf8
DEFAULT COLLATE utf8_roman_ci;


drop table if exists users;
create table users(
      id serial primary key, 
      firstname varchar(50),
      lastname varchar(50),
      
      created_at varchar(50),
      updated_at varchar(50),
      index (firstname,lastname)
);
 
insert into users (firstname, lastname, created_at, updated_at) values 
                 ('Игорь','Смирнов','20.10.2017 8:10','20.10.2017 8:10'),
                 ('Дмитрий','Волкопялов','25.11.2017 11:30','25.11.2017 11:30'),
                 ('Егор','Смолин','10.11.2017 12:15','10.11.2017 12:15'),
                 ('Наталья','Осина','10.01.2018 10:10','10.01.2018 10:10'),
                 ('Елена','Оськина','02.02.2018 16:00','02.02.2018 16:00'),
                 ('Игорь','Прохоров','15.03.2018 18:23','15.03.2018 18:23'),
                 ('Александра','Чернявина','24.04.2018 21:23','24.04.2018 21:23'),
                 ('Андрей','Прокопьев','16.05.2018 8:38','16.05.2018 8:38'),
                 ('Рудольф','Левин','14.06.2018 21:48','14.06.2018 21:48'),
                 ('Сергей','Селещук','01.07.2018 12:16','01.07.2018 12:16');

                
# Необходимо преобразовать поля к типу DATETIME, 
# сохранив введеные ранее значения.                

                
 # переименовываем created_at и updated_at               
alter table users change updated_at updated_drop varchar(50); 
alter table users change created_at created_drop varchar(50);

# создаем колонки created_at и updated_at с типом datetime            

alter table users add created_at DATETIME null;
alter table users add updated_at DATETIME null;

# Переносим данные в нужном формате
            
update users set 
created_at = CONCAT(STR_TO_DATE(LEFT(created_drop, 10), '%d.%m.%Y'),' ',
             RIGHT(created_drop, 5)),
updated_at = CONCAT(STR_TO_DATE(LEFT(updated_drop, 10), '%d.%m.%Y'),' ',
             RIGHT(updated_drop, 5));
# Удаляем переименованные колонки
alter table users drop column created_drop;
alter table users drop column updated_drop;

select * from users;
                         