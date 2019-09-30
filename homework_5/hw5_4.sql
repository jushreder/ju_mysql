/*
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
4.(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся 
в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
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
      birthday varchar(50),
      created_at datetime DEFAULT now(),
      updated_at datetime DEFAULT now(),
      index (firstname,lastname)
);
 
insert into users (firstname, lastname, birthday) values 
                 ('Игорь','Смирнов','10 december 2003'),
                 ('Дмитрий','Волкопялов','12 april 2001'),
                 ('Егор','Смолин','3 august 2006'),
                 ('Наталья','Осина','21 december 1989'),
                 ('Елена','Оськина','9 may 2000'),
                 ('Игорь','Прохоров','8 mart 1999'),
                 ('Александра','Чернявина','29 april 1966'),
                 ('Андрей','Прокопьев','15 april 1964'),
                 ('Рудольф','Левин','15 may 2001'),
                 ('Сергей','Селещук','19 august 1973');

select * from users 
where
birthday LIKE '%august%'
or 
birthday LIKE '%may%';
    
