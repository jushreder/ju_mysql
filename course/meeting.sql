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
    status  ENUM('true', 'false') DEFAULT 'true',
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX users_email_idx(email),
    INDEX users_name_idx(lastname, firstname, patronymic)
   );

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
    gender VARCHAR(3) not null comment 'пол',
    birthday DATE not null comment 'дата рождения',	
    passport_series VARCHAR(5) not null comment 'серия паспорта',
    passport_number VARCHAR(6) not null comment 'номер паспорта',
    date_of_issue date not null comment 'дата выдачи',
    issued VARCHAR(255)not null comment 'кем выдан',
    code VARCHAR(7) not null comment 'код подразделения',
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict);

  
  

DROP TABLE IF EXISTS regions;
CREATE TABLE regions (	 
	code_reg int PRIMARY KEY not null comment 'код региона',
	region VARCHAR(60) not null comment 'имя региона',
	created_at DATETIME DEFAULT NOW(),
	INDEX region_idx(region),
	INDEX code_reg_idx(region)
	);


DROP TABLE IF EXISTS citys;
CREATE TABLE citys (
	id SERIAL PRIMARY KEY,
	city VARCHAR(50) not null comment 'город',
	code_region INT not null comment 'код региона',
	created_at DATETIME DEFAULT NOW(),
	INDEX city_idx(city),
	FOREIGN KEY (code_region) REFERENCES regions(code_reg)
	);



DROP TABLE IF EXISTS streets;
CREATE TABLE streets (
	id SERIAL PRIMARY KEY,
	street VARCHAR(50) not null comment 'улица',
	created_at DATETIME DEFAULT NOW(),
	INDEX streets_idx(street)
	);



DROP TABLE IF EXISTS houses;
CREATE TABLE houses (
	id SERIAL PRIMARY KEY,
	city_id BIGINT UNSIGNED NOT NULL,
	street_id BIGINT UNSIGNED NOT NULL,	
	house int NOT NULL comment 'номер дома',
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
    UNIQUE houses_apart_users(houses_id,apartment,users_id),
    FOREIGN KEY (houses_id) REFERENCES houses(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict
);    
    
DROP TABLE IF EXISTS meetings;
CREATE TABLE meetings (
    id SERIAL PRIMARY KEY,
    houses_id BIGINT UNSIGNED NOT NULL,
    start_date date comment 'дата начала собрания',
    end_date date comment 'дата  окончания собрания',
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (houses_id) REFERENCES houses(id) ON UPDATE CASCADE ON DELETE restrict
    
 );


DROP TABLE IF EXISTS meeting_init;
CREATE TABLE meeting_init (
    id SERIAL PRIMARY KEY,
    meetings_id BIGINT UNSIGNED NOT NULL comment 'собраниe',
    user_id BIGINT UNSIGNED NOT NULL comment 'инициатор собрания',  
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (meetings_id) REFERENCES meetings(id) ON UPDATE CASCADE ON DELETE restrict
);





DROP TABLE IF EXISTS agendas; 
CREATE TABLE agendas (
    id SERIAL PRIMARY KEY,
    meetings_id BIGINT UNSIGNED NOT NULL,
    question varchar(255) NOT NULL comment  'вопрос собрания',
    solution varchar(255) NOT NULL comment 'решение по вопросу',
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (meetings_id) REFERENCES meetings(id)  ON UPDATE CASCADE ON DELETE restrict
);    


DROP TABLE IF EXISTS participants;
CREATE TABLE participants (
     id SERIAL PRIMARY KEY,
     meetings_id BIGINT UNSIGNED NOT NULL comment  'id собрания',   
     owners_id BIGINT UNSIGNED NOT NULL comment  'id собственника',
     created_at DATETIME DEFAULT NOW(),
     FOREIGN KEY (meetings_id) REFERENCES meetings(id),
     FOREIGN KEY (owners_id) REFERENCES owners(id),
     UNIQUE mit_own (meetings_id,owners_id),
     INDEX (meetings_id,owners_id)
);

DROP TABLE IF EXISTS solutions;  -- решения собственников
CREATE TABLE solutions (
    agendas_id BIGINT UNSIGNED NOT NULL,
    participant_id BIGINT UNSIGNED NOT NULL,
    solution ENUM('true', 'false','null') DEFAULT 'null',
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (agendas_id) REFERENCES agendas(id) ON UPDATE CASCADE ON DELETE restrict,
    FOREIGN KEY (participant_id) REFERENCES participants(id) ON UPDATE CASCADE ON DELETE restrict
);










