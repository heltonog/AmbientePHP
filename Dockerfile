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

# Instalando servidor SSH
RUN apt-get install openssh-server -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando servidor Apache
RUN apt-get install apache2 -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando modulo PHP para o Apache
RUN apt-get install libapache2-mod-php -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando API do mysql em PHP
RUN apt-get install php-mysql -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando API do sqlite em PHP
RUN apt-get install php-sqlite3 -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando API GD em PHP
RUN apt-get install php-gd -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando o conversor de codificação
RUN apt-get install php-mbstring -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando a extensão para DOM no PHP
RUN apt-get install php-fdomdocument -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando compactadores de arquivos: bzip2, zip, rar
RUN apt-get install bzip2 zip rar -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando o cliente de url cURL
RUN apt-get install curl -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando o banco de dados SQLite 3
RUN apt-get install sqlite3 -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando a ferramenta GNU para comunicação e armazenamento seguro
RUN apt-get install gnupg2 -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando o comando tree para lista os subdiretórios
RUN apt-get install tree -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando o editor de texto Nano
RUN apt-get install nano -y -o Acquire::http::Dl-Limit=${speed_download}

# Instalando o agendador de tarefas
RUN apt-get install cron -y -o Acquire::http::Dl-Limit=${speed_download}

# Baixando a última versão do gerenciador de projetos Composer, dando permisão de execução
RUN curl -L -C - https://getcomposer.org/composer.phar --output /bin/composer --limit-rate ${speed_download}K
RUN chmod +x /bin/composer

# Habilitando os modulos necessários para o Apache
RUN a2enmod php7.4
RUN a2enmod rewrite
RUN a2enmod headers

# Alterando os arquivos de configuração do Apache quanto uso de modulos, caso do PHP
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.4/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.4/apache2/php.ini

# Alterando o limite de upload para o Apache dos script's PHP
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/" /etc/php/7.4/apache2/php.ini

# Definindo a página do servidor Apache
RUN mkdir -p /home/${user}/public
RUN sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/home\/${user}\/public\n\n\t<Directory \/home\/${user}\/public>\n\t\tAllowOverride All\n\t<\/Directory>\n/" /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/<Directory \/var\/www\/>/<Directory \/home\/${user}\/public>/" /etc/apache2/apache2.conf

# Definindo um usuário, bem como sua senha e mudando a propriedade do diretório raiz do usuário
RUN useradd -d /home/${user} -s /bin/bash ${user}
RUN echo "${user}:123" | chpasswd
RUN chown ${user}:${user} /home/${user} -R

# Criando um diretório para as configurações ssh do usuário e definindo o proprietário
RUN mkdir -p /home/${user}/.ssh
RUN chown ${user}:${user} /home/${user}/.ssh

# Portas qual serão usadas por container, atenção não no host, no caso a ser defini na execução
EXPOSE 80
EXPOSE 8000

# Volume ao qual será visível externamente ao container, atenção novamente não no host, no caso a ser difinida na execução
VOLUME /home/${user}/public
VOLUME /home/${user}/.ssh

# Script de execução continua, copiando-o, dando permisão de execusão e executando o mesmo.
ADD ./entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT /bin/entrypoint.sh
