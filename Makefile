# Criando a imagem
criar_imagem:
	# construindo uma imagem
	docker-compose build

# Excluir a imagem 
remover_imagem:
	# destruir um imagem
	docker rmi imageambientephp:0.0.1
