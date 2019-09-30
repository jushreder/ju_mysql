/*
Практическое задание теме “Агрегация данных”
2.Подсчитайте количество дней рождения, 
которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
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
      birthday date,
      created_at datetime DEFAULT now(),
      updated_at datetime DEFAULT now(),
      index (firstname,lastname)
);
 
insert into users (firstname, lastname, birthday) values 
                 ('Игорь','Смирнов','1974-12-10'),
                 ('Дмитрий','Волкопялов','1973-07-15'),
                 ('Егор','Смолин','1965-09-12'),
                 ('Наталья','Осина','1989-06-15'),
                 ('Елена','Оськина','1999-01-01'),
                 ('Игорь','Прохоров','1997-09-14'),
                 ('Александра','Чернявина','1987-07-10'),
                 ('Андрей','Прокопьев','1964-04-15'),
                 ('Рудольф','Левин','2001-05-15'),
                 ('Сергей','Селещук','1973-08-19');

select 
       DAYNAME(CONCAT(YEAR(now()),DATE_FORMAT(birthday ,'-%m-%d'))) as value,
       count(*)
from users
group by value;
