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

-- Insertion of false datas in database

/* Insertion in table user */

insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('1f11b442-49ed-4ee7-b229-fb158e5d13c9', 'Baxter', 'Lukins', 59, 'blukins0@shutterfly.com', '$2y$10$W.zqdsoOJL0y3XD21D0a6e8Eo0Enckbj0wJhBry9FlDcaHtaabHgK', '7737340337');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('ad253524-d812-492b-bb3d-fccd91e9fa44', 'Alphard', 'Rosengarten', 23, 'arosengarten1@ftc.gov', '$2y$10$6n3aR8V5bfG210sNjJJJjuPHkaMr0.9oefB/9KiLRDoW3il2SYAqi', '6125100435');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('0e51b37b-0f8d-4f0c-923a-fd8c5665a2c4', 'Bruno', 'Clowsley', 32, 'bclowsley2@shareasale.com', '$2y$10$ybaC8tNS3WccnVco2EtUEe3NbJb0eTl6eurqYjW/0HReIAT7rg5wG', '8144960105');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('80de30e8-dbec-4172-be31-2232890985f5', 'Nelle', 'Klausen', 51, 'nklausen3@usda.gov', '$2y$10$YhKMXSkNIgw.V78FAnGxm.Sw0JY7h5mXD.6RUCMAxOfY/3n3D/ltK', '5431840671');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('abec6db4-b551-4d2e-9199-1030ae0f7497', 'Reba', 'Goldsberry', 44, 'rgoldsberry4@smugmug.com', '$2y$10$yujpV8JAEwLCKrM7vxZU9uWRdILqxItaddWLZKvbBs.ZYsCXootsm', '6467354416');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('3ac7e8f7-3205-45b3-ab65-a25473c9ed87', 'Andy', 'Robjant', 42, 'arobjant5@guardian.co.uk', '$2y$10$64bqFjQrDHE4AdgyRvGdwevIeitvDzJo18fU9fJ/3W05q97cTj002', '2643361842');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('1f190825-e5a9-43fa-971e-4c75089e112d', 'La verne', 'Rummins', 16, 'lrummins6@amazonaws.com', '$2y$10$zD9h6IlX3O4WqofBhZlM2eLR3w50bfys2pz96JdS2Pvpg3FqRcTsy', '1054349692');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('c5d60681-6ad5-4ca7-8491-9396db6909ff', 'Trenton', 'Gallemore', 36, 'tgallemore7@ft.com', '$2y$10$pr2k8tTle5ylub32qeDSDuDFNAUMvbIh6OegCmx1zB/5P28kIkZFG', '9821680588');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('c97a81ba-88ca-4652-950e-c03740599be8', 'Rik', 'Satch', 14, 'rsatch8@google.it', '$2y$10$nXyTPWmfkDIWRVB9pD7MfO1tM0mMZuUSXhWSKP7kBTVepen1q6TN.', '9228654837');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('75a6675e-a911-4877-ac19-0ed2fa10af9d', 'Lotti', 'Whyatt', 6, 'lwhyatt9@shareasale.com', '$2y$10$Aq5vhjFalx9SdP/qmPZhyOFgeucZk4DIpmmyiXQhKKW3/2VnJHyb.', '7977274513');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('05133931-90f6-4e15-8d3a-91df51e2a86e', 'Ciel', 'Groocock', 60, 'cgroococka@t-online.de', '$2y$10$CQZjq2FwcCsl53gQThL3iOdv2nz.EdTgWzPHoY9gj4W9E5qhb/kmC', '4244212497');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('3753aa63-3663-44fd-8885-4dd22ecd88ee', 'Ashely', 'Anders', 51, 'aandersb@buzzfeed.com', '$2y$10$wA/W9yZPzEJO2x1AtWQmAOIpKj4ZEB4WGTgqbOocbEoTgX9BV3yS2', '5095506895');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('fa043b23-4d60-45fd-ac01-312500507504', 'Shanda', 'Tease', 30, 'steasec@time.com', '$2y$10$C8hMict31ocWFr7PDDVmROccPhQ9DmjBL6yqiyyNI4qEF2I68PHxS', '6038799610');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('8d82df14-ec7c-43fc-b077-2c4f7d47c3d4', 'Lilyan', 'Dallimore', 12, 'ldallimored@lycos.com', 'd3BSgP0wx', '2441552422');
insert into user (user_id, user_firstname, user_lastname, user_age, user_email, user_password, user_phone_number) values ('69ed7307-0115-4bbf-9202-a7aa8331b4ab', 'Ugo', 'Luty', 5, 'ulutye@imgur.com', '$2y$10$yYW7BpmrQsG6jSnzUbD/3u/sdJ/93GwisbE20aUUXAT38ruuGaMRy', '1001821166');

/* Insertion in table role */

INSERT INTO role (role_name) VALUES ('admin');
INSERT INTO role (role_name) VALUES ('manager');
INSERT INTO role (role_name) VALUES ('customer');

/* Insertion in table user_role */

INSERT INTO user_role (user_id, role_id) VALUES ('1f11b442-49ed-4ee7-b229-fb158e5d13c9', 3);
INSERT INTO user_role (user_id, role_id) VALUES ('0e51b37b-0f8d-4f0c-923a-fd8c5665a2c4', 2);
INSERT INTO user_role (user_id, role_id) VALUES ('c5d60681-6ad5-4ca7-8491-9396db6909ff', 3);
INSERT INTO user_role (user_id, role_id) VALUES ('fa043b23-4d60-45fd-ac01-312500507504', 2);
INSERT INTO user_role (user_id, role_id) VALUES ('ad253524-d812-492b-bb3d-fccd91e9fa44', 3);
INSERT INTO user_role (user_id, role_id) VALUES ('8d82df14-ec7c-43fc-b077-2c4f7d47c3d4', 3);
INSERT INTO user_role (user_id, role_id) VALUES ('69ed7307-0115-4bbf-9202-a7aa8331b4ab', 3);
INSERT INTO user_role (user_id, role_id) VALUES ('3753aa63-3663-44fd-8885-4dd22ecd88ee', 2);
INSERT INTO user_role (user_id, role_id) VALUES ('1f190825-e5a9-43fa-971e-4c75089e112d', 3);
INSERT INTO user_role (user_id, role_id) VALUES ('75a6675e-a911-4877-ac19-0ed2fa10af9d', 3);

/* Insertion in table theater */

insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (1, 'Schneider-Nicolas', '3 Eagan Point', 'Dasha', 46630, 10);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (2, 'Kovacek-Hintz', '916 Evergreen Park', 'Osieczna', 33880, 14);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (3, 'Johnston and Sons', '592 Victoria Court', 'Marintoc', 71020, 15);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (4, 'Hilll Group', '0 3rd Plaza', 'General Lavalle', 29790, 16);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (5, 'Hirthe-Lemke', '961 Mccormick Lane', 'Loudun', 93400, 18);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (6, 'Kerluke-DuBuque', '1 Upham Court', 'Newport News', 55360, 16);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (7, 'Aufderhar, Legros and Wunsch', '9 Warbler Circle', 'Klampok', 34240, 9);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (8, 'Schiller Group', '80293 Ruskin Road', 'Kirtipur', 58050, 18);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (9, 'Bailey, Bogan and Gutmann', '6 Caliangt Way', 'Holma', 42310, 16);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (10, 'Brekke, Hilpert and Williamson', '655 Prairieview Trail', 'Anibare', 72240, 16);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (11, 'Legros, Raynor and Conn', '6 Loeprich Trail', 'Luanshya', 20050, 19);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (12, 'Carroll-Larson', '26 3rd Street', 'Pedro Juan Caballero', 67070, 9);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (13, 'Kiehn-Quigley', '9 South Terrace', 'Zalewo', 14250, 20);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (14, 'Ortiz, Cronin and Schuster', '27 Dennis Avenue', 'Monte da Chaminé', 52600, 12);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (15, 'Konopelski, Harris and White', '1 Packers Way', 'Aqqan', 34800, 8);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (16, 'Kerluke, Kuhlman and Fisher', '969 Weeping Birch Road', 'Tarusa', 27910, 15);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (17, 'Schaden Inc', '6738 Namekagon Plaza', 'Chunshui', 48930, 13);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (18, 'Leannon Inc', '46684 Bunting Place', 'Barroso', 11360, 11);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (19, 'Mohr, Bergnaum and Lebsack', '3965 Debra Trail', 'Teresina', 21850, 19);
insert into theater (theater_id, theater_name, theater_address, theater_city, theater_zipcode, theater_rooms) values (20, 'Rempel, Bahringer and Runolfsson', '142 Burrows Point', 'Novorossiysk', 54300, 18);

/* Insertion in table price */

INSERT INTO price (price_name, price_amount) VALUES ('full price', 9.20);
INSERT INTO price (price_name, price_amount) VALUES ('student price', 7.60);
INSERT INTO price (price_name, price_amount) VALUES ('children price', 5.90);

/* Insertion into table movie */

insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (1, 'Looking for Lenny ', 'Clea Brayford', '2022-09-20', '2:05', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (2, 'Century of the Dragon (Long zai bian yuan)', 'Dick Murrhardt', '2022-09-18', '1:30', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (3, 'Bullet for the General, A (Quién Sabe?)', 'Minnie Addionizio', '2022-09-11', '1:48', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (4, 'Skin Too Few: The Days of Nick Drake, A', 'Melamie Govey', '2022-08-20', '1:59', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (5, 'Delta Farce', 'Mariejeanne Maylam', '2022-09-14', '2:40', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (6, 'Voyager (Homo Faber)', 'Judd Korejs', '2022-09-14', '1:42', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (7, 'Knute Rockne All American', 'Alisha MacQuarrie', '2022-08-28', '1:39', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (8, 'Man in the Iron Mask, The', 'Tilda Vallis', '2022-09-11', '2:04', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (9, 'Awfully Big Adventure, An', 'Debbi Belliveau', '2022-09-09', '1:49', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into movie (movie_id, movie_title, movie_director, movie_date_release, movie_duration, movie_description) values (10, 'At Land', 'Noreen Rape', '2022-09-08', '1:55', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');

/* Insertion in table manager */

INSERT INTO manager (user_role_id, theater_id) VALUES (8, 5);
INSERT INTO manager (user_role_id, theater_id) VALUES (2, 8);
INSERT INTO manager (user_role_id, theater_id) VALUES (4, 15);


/* Insertion into customer table */

INSERT INTO customer (customer_payment, user_role_id, price_id) VALUES ('credit-card', 3, 1);
INSERT INTO customer (customer_payment, user_role_id, price_id) VALUES ('money', 7, 3);
INSERT INTO customer (customer_payment, user_role_id, price_id) VALUES ('credit-card', 6, 3);
INSERT INTO customer (customer_payment, user_role_id, price_id) VALUES ('credit-card', 9, 2);
INSERT INTO customer (customer_payment, user_role_id, price_id) VALUES ('money', 1, 1);

/* Insertion into room table */

insert into room (room_id, room_numerotation, room_places, theater_id) values (1, 11, 114, 13);
insert into room (room_id, room_numerotation, room_places, theater_id) values (2, 1, 223, 9);
insert into room (room_id, room_numerotation, room_places, theater_id) values (3, 11, 133, 14);
insert into room (room_id, room_numerotation, room_places, theater_id) values (4, 13, 241, 17);
insert into room (room_id, room_numerotation, room_places, theater_id) values (5, 2, 180, 1);
insert into room (room_id, room_numerotation, room_places, theater_id) values (6, 9, 110, 12);
insert into room (room_id, room_numerotation, room_places, theater_id) values (7, 15, 228, 10);
insert into room (room_id, room_numerotation, room_places, theater_id) values (8, 8, 177, 15);
insert into room (room_id, room_numerotation, room_places, theater_id) values (9, 1, 243, 12);
insert into room (room_id, room_numerotation, room_places, theater_id) values (10, 6, 139, 19);

/* Insertion into slot table */

insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (1, '2022-10-11', '16:45', 7, 6);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (2, '2022-09-28', '19:30', 5, 10);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (3, '2022-10-09', '20:45', 5, 10);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (4, '2022-09-24', '12:30', 1, 8);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (5, '2022-09-16', '18:30', 4, 6);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (6, '2022-09-19', '16:00', 4, 10);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (7, '2022-09-30', '17:45', 3, 7);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (8, '2022-10-07', '20:15', 2, 10);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (9, '2022-09-30', '12:30', 9, 10);
insert into slot (slot_id, slot_day, slot_hour, room_id, movie_id) values (10, '2022-09-18', '17:45', 8, 2);

/* Insertion into resa table */

insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (1, 27.89, 3, 0, 0, 1, 7, 5);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (2, 5.90, 0, 0, 1, 4, 6, 2);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (3, 21.48, 5, 3, 6, 1, 2, 4);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (4, 12.53, 5, 10, 6, 4, 3, 5);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (5, 29.11, 6, 1, 1, 3, 1, 7);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (6, 44.06, 3, 4, 2, 2, 6, 1);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (7, 7.66, 9, 1, 10, 3, 6, 10);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (8, 44.0, 8, 4, 10, 1, 7, 10);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (9, 35.35, 6, 7, 5, 3, 2, 10);
insert into resa (resa_id, resa_total_price, full_price_place, student_price_place, children_price_place, customer_id, movie_id, slot_id) values (10, 47.71, 4, 3, 1, 1, 2, 8);

