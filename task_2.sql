/*
Создайте SQL-запрос, который помещает в таблицу users миллион записей.
 */

DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

 
DELIMITER //
CREATE PROCEDURE user1000000 ()
begin
DECLARE i INT DEFAULT 1;
WHILE i<=1000000 DO
INSERT INTO users (name, birthday_at) VALUES('Мария', '1992-08-29');
SET i=i+1;
END WHILE;
end //

CALL user1000000();
