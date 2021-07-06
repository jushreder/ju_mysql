/*
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах
 users, catalogs и products в таблицу logs помещается время и дата создания записи,
 название таблицы, идентификатор первичного ключа и содержимое поля name.
*/


DROP DATABASE IF EXISTS meeting;
CREATE DATABASE meeting DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
USE meeting;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50) not null comment 'имя',
    patronymic VARCHAR(50) not null comment 'отчество',
    lastname VARCHAR(50) not null comment 'фамилия',
    email VARCHAR(120) UNIQUE,
    phone BIGINT,
    status  ENUM('true', 'false') DEFAULT 'false',
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX users_email_idx(email),
    INDEX users_name_idx(firstname, patronymic, lastname)
   );

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
    gender VARCHAR(3),
    birthday DATE,	
    passport_series VARCHAR(5),
    passport_number VARCHAR(6),
    date_of_issue date,
    issued VARCHAR(255),
    code VARCHAR(7),
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict);

  
  

DROP TABLE IF EXISTS regions;
CREATE TABLE regions (	 
	code_reg int PRIMARY KEY,
	region VARCHAR(60),
	created_at DATETIME DEFAULT NOW(),
	INDEX region_idx(region),
	INDEX code_reg_idx(region)
	);


DROP TABLE IF EXISTS citys;
CREATE TABLE citys (
	id SERIAL PRIMARY KEY,
	city VARCHAR(50),
	code_region INT,
	created_at DATETIME DEFAULT NOW(),
	INDEX city_idx(city),
	FOREIGN KEY (code_region) REFERENCES regions(code_reg)
	);



DROP TABLE IF EXISTS streets;
CREATE TABLE streets (
	id SERIAL PRIMARY KEY,
	street VARCHAR(50),
	created_at DATETIME DEFAULT NOW(),
	INDEX streets_idx(street)
	);



DROP TABLE IF EXISTS houses;
CREATE TABLE houses (
	id SERIAL PRIMARY KEY,
	city_id BIGINT UNSIGNED NOT NULL,
	street_id BIGINT UNSIGNED NOT NULL,	
	house int NOT NULL,
	year_of__construction year comment 'год постройки',
    apartments int comment 'количество квартир',
    total_area float comment'общая площадь',
    living_space float comment 'жилая площадь',
	created_at DATETIME DEFAULT NOW(),
	INDEX house_idx(id),
	FOREIGN KEY (city_id) REFERENCES citys(id),
	FOREIGN KEY (street_id) REFERENCES streets(id)
	);

DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    houses_id BIGINT UNSIGNED NOT NULL, 
    apartment int comment 'номер квартиры',
    inventory_num varchar(25) comment 'кадастровый номер',
    living_space  float comment 'площадь квартиры',
    users_id BIGINT UNSIGNED NOT NULL comment 'собственник owner', 
    share float  comment 'доля в собственности',
    date_title date comment 'дата возникновения права',
    statement_num varchar(10) comment 'номер документа',
    expiration_date date comment 'дата окончания права',
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (houses_id) REFERENCES houses(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict
);    
    
DROP TABLE IF EXISTS meetings;
CREATE TABLE meetings (
    id SERIAL PRIMARY KEY,
    meeting_initiator BIGINT UNSIGNED NOT NULL comment 'инициатор собрания',
    houses_id BIGINT UNSIGNED NOT NULL,
    start_date date comment 'дата начала собрания',
    end_date date comment 'дата  окончания собрания',
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (houses_id) REFERENCES houses(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (meeting_initiator) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict
 );

DROP TABLE IF EXISTS agendas; 
CREATE TABLE agendas (
    id SERIAL PRIMARY KEY,
    meetings_id BIGINT UNSIGNED NOT NULL,
    question varchar(255) NOT NULL comment  'вопрос собрания',
    solution varchar(255) NOT NULL comment 'решение по вопросу',
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (meetings_id) REFERENCES meetings(id) ON UPDATE CASCADE ON DELETE restrict
);    
    
DROP TABLE IF EXISTS solutions;  -- решения
CREATE TABLE solutions (
    agendas_id SERIAL PRIMARY KEY,
    owners_id BIGINT UNSIGNED NOT NULL,
    solution ENUM('true', 'false') NULL,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (agendas_id) REFERENCES agendas(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (owners_id) REFERENCES owners(id) ON UPDATE CASCADE ON DELETE restrict
);







