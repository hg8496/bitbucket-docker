#!/bin/bash
set -o errexit
. /usr/local/bin/db_extract.sh
sudo own-volume

if [ -n "$DATABASE_URL" ]; then
  extract_database_url "$DATABASE_URL" DB /opt/bb/lib
  DB_JDBC_URL="$(xmlstarlet esc "$DB_JDBC_URL")"
  mkdir -p /opt/atlassian-home/shared
  cat <<END > /opt/atlassian-home/shared/bitbucket.properties
jdbc.driver=$DB_JDBC_DRIVER
jdbc.url=$DB_JDBC_URL
jdbc.user=$DB_USER
jdbc.password=$DB_PASSWORD
END
fi
JAVA_HOME= /usr/lib/jvm/java-8-oracle/
/opt/bb/bin/start-bitbucket.sh -fg
