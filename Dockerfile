# Especificando a imagem base, sobre a qual esta será criada
FROM debian:10

# Especificando o nome do usuário
ENV user web

# Determinando a velocidade de download
ENV speed_download 45000

# Especificando o Idioma padrão
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR:pt:en
ENV LC_ALL=C.UTF-8

# Especificando Fuso horário
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime
ENV TZ=America/Sao_Paulo

# Definindo os repositórios de pacotes
ADD ./files_config/sources.list /etc/apt/sources.list
# Sincronizar os respositórios disponíveis a uma determinando limite de download
RUN apt-get update -o Acquire::http::Dl-Limit=$speed_download -y

# Instalando o automatizador de tarefas Make
RUN apt-get install make -o Acquire::http::Dl-Limit=${speed_download} -y

# Instalando o Git, um sistema de controle de versão
RUN apt-get install git -o Acquire::http::Dl-Limit=${speed_download} -y
