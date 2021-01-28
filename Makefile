.PHONY :

# Setup ————————————————————————————————————————————————————————————————————————

current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Executables: local
DOCKER-LOCAL   	  		= /usr/local/bin/docker
DOCKER_COMPOSE-LOCAL   	= /usr/local/bin/docker-compose

# Containers
PHP				= docker exec -it docker-symfony-php
COMPOSER-C		= docker run --rm --interactive --volume $(current-dir):/app composer

# Executables: within containers
SYMFONY_BIN		= /usr/bin/symfony
COMPOSER		= /usr/bin/composer

## —— folders —————————————————————————————————————————————————————————————————

current-dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
musiclabel-app-dir := $(current-dir)apps/musiclabelApp
musiclabel-backend := $(musiclabel-app-dir)/backend

debug-paths:
	echo $(current-dir)
	echo $(musiclabel-app-dir)
	echo $(musiclabel-backend)

## —— envs —————————————————————————————————————————————————————————————————

dump-dev:
	$(PHP) apps/MusicLabelApp/backend/bin/console app:dump-env dev

dump-test:
	$(PHP) apps/MusicLabelApp/backend/bin/console app:dump-env test

dump-prod:
	$(PHP) apps/MusicLabelApp/backend/bin/console app:dump-env prod

## —— development env ————————————————————————————————————————————————————————
server-start-musiclabel-backend:
	$(SYMFONY_BIN) server:start -d --port=8765 --dir=$(musiclabel-backend)/public

server-stop-musiclabel-backend:
	$(SYMFONY_BIN) server:stop --dir=$(musiclabel-backend)/public

db-create-sqlite:
	$(PHP) apps/MusicLabelApp/backend/bin/console doctrine:database:create --no-interaction --quiet
	$(PHP) apps/MusicLabelApp/backend/bin/console doctrine:schema:update --force --no-interaction --quiet

db-create:
	$(PHP) apps/MusicLabelApp/backend/bin/console doctrine:database:create --if-not-exists --no-interaction --quiet

db-update:
	$(PHP) apps/MusicLabelApp/backend/bin/console doctrine:schema:update --dump-sql --force --no-interaction --quiet

db-migrate:
	$(PHP) apps/MusicLabelApp/backend/bin/console doctrine:migrations:migrate --all-or-nothing --no-interaction --quiet --allow-no-migration

db-drop:
	$(PHP) apps/MusicLabelApp/backend/bin/console doctrine:database:drop --force --quiet

## —— Docker  ————————————————————————————————————————————————————————
up-php:
	$(DOCKER_COMPOSE-LOCAL) -f docker-compose.tests.yml up -d --remove-orphans

up-dev:
	$(DOCKER_COMPOSE-LOCAL) up --remove-orphans -d nginx mysql php rabbitmq redis

up:
	$(DOCKER_COMPOSE-LOCAL) -f docker-compose.yml up --remove-orphans -d

down:
	$(DOCKER_COMPOSE-LOCAL) -f docker-compose.yml down --remove-orphans

## —— Consumer  ————————————————————————————————————————————————————————
supervisord:
	$(PHP) supervisord --configuration /etc/supervisor.d/supervisord.ini

## —— Composer ————————————————————————————————————————————————————————————

composer-install:
	$(COMPOSER-C) install

composer-update:
	$(COMPOSER-C) update

## —— PHP tests ————————————————————————————————————————————————————————————

phpcs: up-php
	$(PHP) vendor/bin/phpcs -p --colors

phpcs-build: up-php
	$(PHP) vendor/bin/phpcbf
	
rector: up-php
	$(PHP) vendor/bin/rector process --dry-run

rector-build: up-php
	$(PHP) vendor/bin/rector process

# @todo include phpstan in testing
phpstan: up-php
	$(PHP) vendor/bin/phpstan analyse src tests

psalm: up-php
	$(PHP) vendor/bin/psalm --long-progress --no-cache --no-file-cache
		
phpunit: dump-test up-php
	$(PHP) vendor/bin/phpunit \
		--exclude-group='disabled' \
		--log-junit build/test/phpunit/junit.xml tests

phpunit-coverage: up-php
	$(PHP) bash -c "\
		export XDEBUG_MODE=coverage && \
		vendor/bin/phpunit \
			--exclude-group='disabled' \
			--log-junit build/test/phpunit/junit.xml \
			--coverage-html build/test/phpunit tests \
		unset XDEBUG_MODE"

behat: dump-test up-php
	$(PHP) vendor/bin/behat -f progress

## —— examples  ————————————————————————————————————————————————————————————
create-demo-user:
	$(PHP) apps/MusicLabelApp/backend/bin/console app:create-user 'test@email.com' '1234567890'

## —— RUN  ————————————————————————————————————————————————————————————
test: up-php dump-test db-drop db-create-sqlite phpcs rector psalm behat phpunit

dev-start: up-dev dump-dev db-create db-migrate
prod-start: up dump-prod db-create db-migrate

stop: down

# Start supervisord to monitor consumer
prod-start dev-start: supervisord