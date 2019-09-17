CREATE DATABASE IF NOT EXISTS example;
USE example;
CREATE TABLE  IF NOT EXISTS  users (id  int, name  char);

\! mysqldump  example > example_dump.sql


CREATE DATABASE  IF NOT EXISTS sample;
USE  sample;

\! mysql sample < example_dump.sql;

