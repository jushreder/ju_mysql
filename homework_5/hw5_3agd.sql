/*
Практическое задание теме “Агрегация данных”
3.(по желанию) Подсчитайте произведение чисел в столбце таблицы
*/

drop database if exists home;
create database home;
use home;

drop table if exists test;
create table test(
      value int);
 
insert into test (value) values (1),(2),(3),(4),(5);
                 

              
SELECT round(exp(SUM(log(value)))) FROM test;

               

                         