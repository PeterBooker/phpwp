#!/bin/sh

cd /var/www/html
if ! $(wp core is-installed --allow-root); then
    wp core download --version=${WP_VERSION:-latest} --force --allow-root \
    && wp core config --dbname=${MYSQL_DATABASE:-wordpress} --dbuser=${MYSQL_USER:-wordpress} --dbpass=${MYSQL_PASSWORD:-password} --dbhost=database --force --allow-root \
    && wp core install --url=localhost --title=WordPress --admin_user=${WP_USER:-user} --admin_password=${WP_PASS:-password} --admin_email=${WP_EMAIL:-user@domain.com} --allow-root \
    && wp rewrite structure "/%postname%/" --allow-root \
    && wp site empty --allow-root \
    && wp widget delete search-2 recent-posts-2 recent-comments-2 archives-2 categories-2 meta-2 --allow-root
fi

cd /var/www/adminer
if [ ! -e index.php ]; then
    wget https://github.com/vrana/adminer/releases/download/v4.6.3/adminer-4.6.3.php \
    && mv adminer-4.6.3.php ./index.php
fi

exec "$@"