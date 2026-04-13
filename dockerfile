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

# Crear estructura de directorios dentro de /var/www
RUN mkdir -p /var/www/www \
    /var/www/shadaai \
    /var/www/apps \
    /var/www/api

# Configurar Apache para escuchar en los puertos específicos
RUN echo "Listen 7380" >> /etc/apache2/ports.conf && \
    echo "Listen 7381" >> /etc/apache2/ports.conf && \
    echo "Listen 7382" >> /etc/apache2/ports.conf && \
    echo "Listen 7385" >> /etc/apache2/ports.conf

# Crear los VirtualHosts para cada puerto/carpeta
RUN echo '# VirtualHost para /var/www/www en puerto 7380' > /etc/apache2/sites-available/000-default.conf && \
    echo '<VirtualHost *:7380>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/www' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/www>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    ErrorLog ${APACHE_LOG_DIR}/error_7380.log' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    CustomLog ${APACHE_LOG_DIR}/access_7380.log combined' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '' >> /etc/apache2/sites-available/000-default.conf && \
    echo '# VirtualHost para /var/www/apps en puerto 7381' >> /etc/apache2/sites-available/000-default.conf && \
    echo '<VirtualHost *:7381>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/apps' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/apps>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    ErrorLog ${APACHE_LOG_DIR}/error_7381.log' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    CustomLog ${APACHE_LOG_DIR}/access_7381.log combined' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '' >> /etc/apache2/sites-available/000-default.conf && \
    echo '# VirtualHost para /var/www/api en puerto 7382' >> /etc/apache2/sites-available/000-default.conf && \
    echo '<VirtualHost *:7382>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/api' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/api>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    ErrorLog ${APACHE_LOG_DIR}/error_7382.log' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    CustomLog ${APACHE_LOG_DIR}/access_7382.log combined' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '' >> /etc/apache2/sites-available/000-default.conf && \
    echo '# VirtualHost para /var/www/shadaai en puerto 7385' >> /etc/apache2/sites-available/000-default.conf && \
    echo '<VirtualHost *:7385>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/shadaai' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/shadaai>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Options Indexes FollowSymLinks' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    ErrorLog ${APACHE_LOG_DIR}/error_7385.log' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    CustomLog ${APACHE_LOG_DIR}/access_7385.log combined' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

# Ajustar permisos
RUN chown -R www-data:www-data /var/www && \
    chmod -R 755 /var/www

# Exponer los puertos
EXPOSE 80 7380 7381 7382 7385

WORKDIR /var/www