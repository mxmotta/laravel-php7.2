FROM php:7.2-apache
RUN apt-get update -y && apt-get install -y openssl zip unzip git zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libicu-dev g++ libpq-dev \
&& apt clean -y
RUN docker-php-ext-configure intl && docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
RUN useradd app
RUN a2enmod rewrite

ENV APACHE_DOCUMENT_ROOT /app/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Install npm
RUN apt-get update -y && apt-get install curl -y && curl -sL https://deb.nodesource.com/setup_10.x && apt clean -y
RUN apt-get install nodejs npm -y
