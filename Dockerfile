FROM composer as builder
WORKDIR /workspace/nuclio-symfony
ADD nuclio-symfony /workspace/nuclio-symfony

RUN APP_ENV=prod composer install --ignore-platform-reqs

FROM patrickjahns/nucleo-php-runtime
COPY --from=builder /workspace/nuclio-symfony /var/task/src

ENV PHP_SCRIPT=/var/task/src/public/index.php

# ensure permissions are valid
RUN chown -R www-data:www-data /var/task