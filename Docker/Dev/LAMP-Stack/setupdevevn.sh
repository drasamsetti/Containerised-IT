#!/bin/bash
echo "Building Docker containers....."
echo "bringing up MySQL DB container.."
if [ $1 == 'WIN' ]
then
	echo "building containers for Boot2Docker host"
	echo "$1"
	docker run -d -p 3306:3306 -e MYSQL_PASS="mypass" -e ON_CREATE_DB="csc_lrv3_1" -e STARTUP_SQL="/home/test-db/csc_lrv3_1.sql" --name db drasamsetti/mysql
	echo "bringing up Apache-php container..."
	docker run -d -p 8000:80 --name web --link db:db drasamsetti/web-app
	echo "application hosted"
	echo "URL: http://localhost:8000/index.php"
elif [ $1 == 'LNX' ]
then
	echo "building containers for LINUX host"
	docker run -d -p 3306:3306 -e MYSQL_PASS="mypass" -e ON_CREATE_DB="csc_lrv3_1" -e STARTUP_SQL="/home/test-db/csc_lrv3_1.sql" --name db drasamsetti/mysql
	echo "bringing up Apache-php container..."
	docker run -d -p 8000:80 --name web --link db:db drasamsetti/web-app
	echo "application hosted"
	echo "URL: http://localhost:8000/index.php"
else
	echo "please define enviornment ENV=WIN(Windows) or ENV=LNX(Linux)"
fi
