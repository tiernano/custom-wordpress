FROM wordpress:php8.2-fpm
# printf statement mocks answering the prompts from the pecl install
RUN apt update && apt install zlib1g-dev libmemcached-dev libpcre3-dev -y
RUN printf "\n \n" | pecl install redis && docker-php-ext-enable redis
RUN printf "\n \n" | pecl install memcached && docker-php-ext-enable memcached


#RUN echo "upload_max_filesize = 10M;" >> "/usr/local/etc/php/php.ini"


ENTRYPOINT ["docker-entrypoint.sh"]
RUN mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
RUN echo "upload_max_filesize = 10M;" >> "/usr/local/etc/php/php.ini"

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php-fpm", "-e"]
