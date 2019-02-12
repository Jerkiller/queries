# mysql_set_charset('utf8');
SET NAMES utf8
SET CHARACTER SET utf8
# 
# my.ini
# 
# [client]
# default-character-set=utf8
# 
# [mysqld]
# init_connect='SET collation_connection = utf8_unicode_ci; SET NAMES utf8;'
# default-character-set=utf8
# character-set-server=utf8
# collation-server=utf8_unicode_ci
# skip-character-set-client-handshake
# 
# [mysqldump]
# default-character-set=utf8
# 
# [mysql]
# default-character-set=utf8
# 
# 
# 
# php.ini
# default_charset = "UTF-8"
# mbstring.internal_encoding = UTF-8

SHOW VARIABLES LIKE 'character\_set\_%';

+--------------------------+--------+
| Variable_name            | Value
+--------------------------+--------+
| character_set_client     | latin1 *
| character_set_connection | latin1 *
| character_set_database   | utf8
| character_set_filesystem | binary
| character_set_results    | latin1 *
| character_set_server     | latin1
| character_set_system     | utf8
+--------------------------+--------+

# http://www.bluetwanger.de/blog/2006/11/20/mysql-and-utf-8-no-more-question-marks/
