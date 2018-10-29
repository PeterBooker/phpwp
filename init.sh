#!/bin/sh

cd /var/www/html
if ! $(wp core is-installed --allow-root); then
    wp core download --force --allow-root \
    && wp core config --dbname=wordpress --dbuser=wordpress --dbpass=password --dbhost=database --force --allow-root \
    && wp core install --url=localhost --title=WordPress --admin_user=user --admin_password=user --admin_email=user@localhost.com --allow-root \
    && wp rewrite structure "/%postname%/" --allow-root \
    && wp site empty --allow-root \
    && wp widget delete search-2 recent-posts-2 recent-comments-2 archives-2 categories-2 meta-2 --allow-root
fi

exec "$@"