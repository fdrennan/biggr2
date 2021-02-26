up: down pull build
	docker-compose up -d

down:
	docker-compose down

pull:
	docker-compose pull

build:
	docker-compose build

logs:
	docker-compose logs -f

init: down airflowdir pull build
	docker-compose up -d

initf: init logs

airflowdir:
	mkdir -p -m 777 airflow/logs
	mkdir -p -m 777 airflow/dags
	mkdir -p -m 777 airflow/plugins
	mkdir -p -m 777 airflow/scripts
	mkdir -p -m 777 airflow/sql

mpush:
	git add --all
	git commit -m 'update'
	git push origin main

mpull:
	git reset --hard
	git pull origin main

stopall:
	docker stop $$(docker ps -aq)

removeall:
	docker rm $$(docker ps -aq)

removeimages:
	docker rmi $$(docker images -q)

scheduler:
	docker exec -it redditstack_airflow-scheduler_1 bash

rbase:
	docker exec -it redditstack_rbase_1 bash

app:
	docker exec -it redditstack_app_1 bash

style:
	R -e "styler::style_dir()"

