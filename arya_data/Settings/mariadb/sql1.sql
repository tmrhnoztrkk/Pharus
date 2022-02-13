CREATE DATABASE pharus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'pharus'@'localhost' IDENTIFIED BY 'Pharus8912!';
GRANT ALL PRIVILEGES ON pharus.* TO 'pharus'@'localhost';
FLUSH PRIVILEGES;
SET GLOBAL time_zone = "Europe/Istanbul";
exit
