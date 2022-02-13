use pharus;
SET TIME_ZONE='+03:00';
ALTER TABLE `notifications` CHANGE `datetime` `datetime` timestamp NOT NULL DEFAULT '1970-01-02 00:00:00' ;
ALTER TABLE `users` CHANGE `created_at` `created_at` timestamp NOT NULL DEFAULT '1970-01-02 00:00:01' ;
exit