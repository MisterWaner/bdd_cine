-- Active: 1662231991925@@127.0.0.1@3306@cinema

-- Creation of database. 
CREATE DATABASE IF NOT EXISTS cinema;

-- Creation of all tables.
DROP TABLE IF EXISTS user;
CREATE TABLE IF NOT EXISTS user(
  user_id CHAR(36) NOT NULL PRIMARY KEY,
  user_firstname VARCHAR(50) NOT NULL,
  user_lastname VARCHAR(50) NOT NULL,
  user_age TINYINT(2) NOT NULL,
  user_email VARCHAR(255) NOT NULL,
  user_password VARCHAR(255) NOT NULL,
  user_phone_number INT(10) NOT NULL
) ENGINE = InnoDB;

DROP TABLE IF EXISTS role;
CREATE TABLE IF NOT EXISTS role(
  role_id TINYINT(1) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  role_name VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

DROP TABLE IF EXISTS user_role;
CREATE TABLE IF NOT EXISTS user_role(
  user_role_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  role_id TINYINT(1) NOT NULL,
  CONSTRAINT fk_user_role_user_id FOREIGN KEY (user_id) REFERENCES user (user_id),
  CONSTRAINT fk_user_role_role_id FOREIGN KEY (role_id) REFERENCES role (role_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS theater;
CREATE TABLE IF NOT EXISTS theater(
  theater_id TINYINT(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  theater_name VARCHAR(50) NOT NULL,
  theater_address VARCHAR(50) NOT NULL,
  theater_city VARCHAR(30) NOT NULL,
  theater_zipcode INT(5) NOT NULL,
  theater_rooms INT(2) NOT NULL
) ENGINE = InnoDB;

DROP TABLE IF EXISTS price;
CREATE TABLE IF NOT EXISTS price(
  price_id TINYINT(1) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  price_name VARCHAR(30) NOT NULL,
  price_amount FLOAT(3, 2)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS movie;
CREATE TABLE IF NOT EXISTS movie(
  movie_id INT(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  movie_title VARCHAR(100) NOT NULL,
  movie_director VARCHAR(100) NOT NULL,
  movie_date_release DATE NOT NULL,
  movie_duration TIME NOT NULL,
  movie_description TEXT
) ENGINE = InnoDB;

DROP TABLE IF EXISTS admin;
CREATE TABLE IF NOT EXISTS admin(
  admin_id TINYINT(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_role_id INT(11) NOT NULL,
  CONSTRAINT fk_admin_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_role (user_role_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS manager;
CREATE TABLE IF NOT EXISTS manager(
  manager_id TINYINT(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_role_id INT(11) NOT NULL,
  theater_id TINYINT(2) NOT NULL,
  CONSTRAINT fk_manager_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_role (user_role_id),
  CONSTRAINT fk_manager_theater_id FOREIGN KEY (theater_id) REFERENCES theater (theater_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer(
  customer_id INT(7) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customer_payment VARCHAR(25) NOT NULL,
  user_role_id INT(11) NOT NULL,
  price_id TINYINT(1) NOT NULL,
  CONSTRAINT fk_customer_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_role (user_role_id),
  CONSTRAINT fk_customer_price_id FOREIGN KEY (price_id) REFERENCES price (price_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS room;
CREATE TABLE IF NOT EXISTS room(
  room_id TINYINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  room_numerotation TINYINT(2) NOT NULL,
  room_places TINYINT(3) NOT NULL,
  theater_id TINYINT(2) NOT NULL,
  CONSTRAINT fk_room_theater_id FOREIGN KEY (theater_id) REFERENCES theater (theater_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS slot;
CREATE TABLE IF NOT EXISTS slot(
  slot_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  slot_day DATE NOT NULL,
  slot_hour TIME NOT NULL,
  room_id TINYINT(3) NOT NULL,
  movie_id INT(5) NOT NULL,
  CONSTRAINT fk_slot_room_id FOREIGN KEY (room_id) REFERENCES room (room_id),
  CONSTRAINT fk_slot_movie_id FOREIGN KEY (movie_id) REFERENCES movie (movie_id)
) ENGINE = InnoDB;

DROP TABLE IF EXISTS resa;
CREATE TABLE IF NOT EXISTS resa(
  resa_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  resa_total_price FLOAT(5, 2) NOT NULL,
  full_price_place INT(2) NOT NULL,
  student_price_place INT(2) NOT NULL,
  children_price_place INT(2) NOT NULL,
  customer_id INT(7) NOT NULL,
  movie_id INT(5) NOT NULL,
  slot_id INT(11) NOT NULL,
  CONSTRAINT fk_resa_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  CONSTRAINT fk_resa_movie_id FOREIGN KEY (movie_id) REFERENCES movie (movie_id),
  CONSTRAINT fk_resa_slot_id FOREIGN KEY (slot_id) REFERENCES slot (slot_id)
) ENGINE = InnoDB;