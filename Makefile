# Criando a imagem
criar_imagem:
	# construindo uma imagem
	docker-compose build

# Excluir a imagem 
remover_imagem:
	# destruir um imagem
	docker rmi imageambientephp:0.0.1

# Criando o container
criar_container:
	# iniciando um container a partir de determinanda imagem
	docker network create AmbientePHP_default
	docker-compose up --no-start

# Excluindo o container
parar_container:
	# Para e excluir um determinado container
	docker-compose stop
	docker-compose rm -f
	docker network rm AmbientePHP_default

# Iniciar o container em segundo plano
iniciar_container:
	# Iniciar a execução do container em segundo plano
	docker-compose start

# Acessando o container
acessar_container:
	# Voltar a execução do container em primeiro plano
	docker exec -it AmbientePHP bash

# Crianddo e iniciando o container em segundo plano
up: criar_container iniciar_container

# Parando o container
down: parar_container

# Acessando o container
in: acessar_container
