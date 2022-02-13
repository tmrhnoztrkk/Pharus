CREATE DATABASE pharus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'pharus'@'localhost' IDENTIFIED BY 'Pharus8912!';
GRANT ALL PRIVILEGES ON pharus.* TO 'pharus'@'localhost';
FLUSH PRIVILEGES;
SET GLOBAL time_zone = "Europe/Istanbul";
USE pharus;
ALTER TABLE `notifications` CHANGE `datetime` `datetime` timestamp NOT NULL DEFAULT '1970-01-02 00:00:00' ;
ALTER TABLE `users` CHANGE `created_at` `created_at` timestamp NOT NULL DEFAULT '1970-01-02 00:00:01' ;
exit
