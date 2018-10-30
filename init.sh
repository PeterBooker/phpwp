#!/bin/sh

cd /var/www/html
if ! $(wp core is-installed --allow-root); then
    wp core download --version=${WP_VERSION} --force --allow-root \
    && wp core config --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=database --force --allow-root \
    && wp core install --url=localhost --title=WordPress --admin_user=${WP_USER} --admin_password=${WP_PASS} --admin_email=${WP_EMAIL} --allow-root \
    && wp rewrite structure "/%postname%/" --allow-root \
    && wp site empty --allow-root \
    && wp widget delete search-2 recent-posts-2 recent-comments-2 archives-2 categories-2 meta-2 --allow-root
fi

exec "$@"