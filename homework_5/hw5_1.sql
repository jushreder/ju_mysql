/*
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
1.Пусть в таблице users поля created_at и updated_at оказались незаполненными.
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
      created_at datetime,
      updated_at datetime,
      index (firstname,lastname)
);
 
insert into users (firstname, lastname) values 
                 ('Игорь','Смирнов'),
                 ('Дмитрий','Волкопялов'),
                 ('Егор','Смолин'),
                 ('Наталья','Осина'),
                 ('Елена','Оськина'),
                 ('Игорь','Прохоров'),
                 ('Александра','Чернявина'),
                 ('Андрей','Прокопьев'),
                 ('Рудольф','Левин'),
                 ('Сергей','Селещук');

#  Заполняем их текущими датой и временем.                
                
update users set created_at = now(), updated_at =now(); 

select * from users;