
CREATE TABLE orders (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, shopping_cart_id integer, name varchar(255), address varchar(255), payment_method integer, phone_number integer, created_at datetime, updated_at datetime, decide_order boolean DEFAULT 0 NOT NULL, member_id integer);
INSERT INTO orders VALUES(76,98,'po','yo',2,2,'2016-05-11 02:29:04.463908','2016-05-11 02:29:04.463908',1,980191060);
INSERT INTO orders VALUES(77,100,'po','yo',2,2,'2016-05-11 04:12:04.073977','2016-05-11 04:12:04.073977',1,980191060);
INSERT INTO orders VALUES(78,101,'pop','pop',3,13,'2016-05-11 04:18:17.861118','2016-05-11 04:18:22.531927',1,980191060);
INSERT INTO orders VALUES(81,104,'new','new',3,3,'2016-05-11 04:32:57.156786','2016-05-11 04:32:59.846214',1,980191060);
INSERT INTO orders VALUES(84,105,'kiki','kiki',1,1,'2016-05-11 04:43:57.594772','2016-05-11 04:44:54.751488',1,980191060);
INSERT INTO orders VALUES(85,106,'lolo','lolo',3,13,'2016-05-11 04:45:27.541428','2016-05-11 04:45:31.185976',1,980191060);
INSERT INTO orders VALUES(87,107,'uu','uu',1,9,'2016-05-11 04:46:24.944737','2016-05-11 04:46:27.935261',1,980191060);
INSERT INTO orders VALUES(88,109,'ko','ko',2,12,'2016-05-11 06:10:27.859402','2016-05-11 06:10:31.207258',1,980191060);
INSERT INTO orders VALUES(89,110,'bbb','bbb',1,0,'2016-05-11 06:32:59.330536','2016-05-11 23:04:59.089821',1,980191060);
INSERT INTO orders VALUES(90,111,'uo','op',3,5,'2016-05-12 03:06:24.193216','2016-05-12 03:06:24.193216',1,980191060);
INSERT INTO orders VALUES(91,123,'qu','qu',2,444,'2016-05-12 06:55:09.696489','2016-05-12 06:55:09.696489',1,980191063);
INSERT INTO orders VALUES(92,125,'kyoko','shimizu',3,33,'2016-05-12 23:10:07.310950','2016-05-12 23:10:07.310950',0,980191063);
INSERT INTO orders VALUES(94,128,'ui','op',3,5,'2016-05-13 00:43:51.858699','2016-05-13 00:43:51.858699',1,980191063);
INSERT INTO orders VALUES(95,129,'ui','op',3,5,'2016-05-13 00:46:55.592791','2016-05-13 00:46:55.592791',1,980191063);
INSERT INTO orders VALUES(96,130,'とる','t',2,5,'2016-05-13 00:50:05.400580','2016-05-13 00:50:05.400580',1,980191064);
INSERT INTO orders VALUES(97,131,'とるとる','t',2,5,'2016-05-13 00:51:00.683571','2016-05-13 00:51:00.683571',1,980191064);
INSERT INTO orders VALUES(101,135,'とるとるとる','と',3,0,'2016-05-13 01:03:04.251038','2016-05-13 01:03:14.142187',1,980191064);
INSERT INTO orders VALUES(102,137,'とるっち','とる',3,2,'2016-05-15 10:44:57.813105','2016-05-15 10:45:11.314445',1,980191064);
INSERT INTO orders VALUES(103,138,'とるとる','t',2,5,'2016-05-16 00:33:01.087044','2016-05-16 00:33:01.087044',1,980191064);

COMMIT;
