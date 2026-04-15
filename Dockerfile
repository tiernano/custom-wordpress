FROM wordpress:php8.3-fpm

# Install PHP extensions and dependencies in a single layer
RUN apt-get update && apt-get install -y zlib1g-dev libmemcached-dev less \
    && printf "\n \n" | pecl install redis \
    && docker-php-ext-enable redis \
    && printf "\n \n" | pecl install memcached \
    && docker-php-ext-enable memcached \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Configure PHP settings
RUN mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && echo "upload_max_filesize = 10M;" >> /usr/local/etc/php/php.ini

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
