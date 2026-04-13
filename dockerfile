FROM php:7.3-apache

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libcurl4-openssl-dev \ 
    && docker-php-ext-install \
    mysqli \
    pdo_mysql \
    zip \
    curl \ 
    && rm -rf /var/lib/apt/lists/*

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 80