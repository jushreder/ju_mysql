
/*
1.Составьте список пользователей users, которые осуществили хотя бы один заказ 
orders в интернет магазине.
*/
use shop;


TRUNCATE TABLE orders;

INSERT INTO orders
  (user_id)
VALUES (1),
       (3),
       (5),
       (5),
       (1),
       (4),
       (1);


select id, name from users 
where id in (SELECT DISTINCT user_id from orders);



 



