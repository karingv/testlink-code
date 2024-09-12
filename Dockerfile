FROM php:7.4-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip soap

# Copiar los archivos de TestLink desde el repositorio al contenedor
RUN git clone -b testlink_1_9_20_fixed https://github.com/TestLinkOpenSourceTRMS/testlink-code.git /var/www/html/testlink

# Configurar permisos
RUN chown -R www-data:www-data /var/www/html/testlink
RUN chmod -R 775 /var/www/html/testlink

# Configurar Apache
RUN a2enmod rewrite

# Exponer el puerto 80
EXPOSE 80
