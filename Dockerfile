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
