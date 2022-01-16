# Contribuindo para o projeto Ambiente PHP
Aqui você saberá como contribuir para o projeto Ambiente PHP.

- [Construido o repositório local](#construido-o-reposit%C3%B3rio-local)
- [Construir repositórios externos](#construir-reposit%C3%B3rios-externos)
- [Commit durante o projeto](#commit-durante-o-projeto)

------------------------------------------------------
### Construido o repositório local
Construindo o repositório local.

- Crie um registro da versão inicial no [CHANGELOG](CHANGELOG.md).
- E faça o seguinte comandos que se segure:

```bash
# Crie o diretório do projeto
mkdir AmbientePHP

# Entre no diretório do projeto
cd AmbientePHP

# Inicie o git
git init

# Adicione as configurações do usuário do local do projeto, como: nome do usuário e email do usuário
git config user.name "O meu nome"
git config user.email "o.meu.nome@exemplo.com"

# Adicione o arquivos locais ao projeto
git add .

# Faça o commit local
git commit -m "Commit inicial"
```

------------------------------------------------------
### Construir repositórios externos
Construindo repositório externo para hospedagem do projeto.

##### GitLab
- Crie um projeto em branco com o nome de "Ambiente PHP" e o link do projeto como "AmbientePHP" no [GitLab](h
ttps://gitlab.com), em [Projeto em Branco](https://gitlab.com/projects/new#blank_project).
- E faça o seguinte comandos que se segure:

```bash
# Entre no diretório do projeto local, caso não esteja
cd AmbientePHP

# Adicione o repositório gitlab
git remote add gitlab git@gitlab.com:heltonog/AmbientePHP.git

# Envie o projeto local para o repositório externo do gitlab recém criado
git push -u gitlab --all
```

##### GitHub
- Crie um projeto em branco com o nome "Ambiente PHP" e o link do projeto como "AmbientePHP" no [GitHub](https://github.com), em [Projeto em Branco](https://github.com/new).
- E faça o seguinte comandos que se segure:

```bash
# Entre no diretório do projeto local, caso não esteja
cd AmbientePHP

# Adicione o repositório gitlab
git remote add github git@github.com:heltonog/AmbientePHP.git

# Envie o projeto local para o repositório externo do gitlab recém criado
git push -u github --all
```

------------------------------------------------------
### Commit durante o projeto
Fazendo os commit do projeto, excetuando os iniciais.

- Adicione o registro das alterações no projeto no [CHANGELOG](CHANGELOG.md).
- E faça o seguinte comandos que se segure:

```bash
# Entre no diretório do projeto local, caso não esteja
cd AmbientePHP

# Adicione o arquivos alterados
git add .

# Faça o commit local
git commit -m "<Adicione uma mensagem que corresponda as alterações feitas>"

# Caso aja repositórios externos, envie o commit para os mesmo
git push -u <gitlab, github> master
```
