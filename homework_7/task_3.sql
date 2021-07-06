/*
3.(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и 
таблица городов cities (label, name). Поля from, to и 
label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE table flights (
       id SERIAL PRIMARY KEY,
       `from` VARCHAR(50), 
       `to` VARCHAR(50));
      
INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');

 
DROP TABLE IF EXISTS cities;
CREATE table cities (
     label VARCHAR(50),
     name VARCHAR(50));

INSERT INTO cities (label, name) VALUES
  ('moscow','Москва'),
  ('irkutsk','Иркутск'),
  ('novgorod','Новгород'),
  ('omsk','Омск'),
  ('kazan','Казань');

 
 SELECT id, 
        (select name from cities where `from`= label) as 'from', 
        (select name from cities where `to` = label) as 'to' 
 from flights;
