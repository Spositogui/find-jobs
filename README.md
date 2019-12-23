# Find Jobs

Findjobs é um projeto que viza criar uma ponte entre empresas e pessoas que porcuram por empregos. Na plataforma as empresas cadastradas podem criar novas vagas onde os candidatos interessados podem se inscrever.

## Minhas configs:

* Ruby version: 2.6.5

* Rails version: 5.2.3

* System dependencies: Ubuntu 18.4

## Como iniciar o projeto

* Seu computador dever ter preferencialmente O.S Linux

* Instale as dependências necessárias , definidas no arquivo  `GemFile`, rodando o comando `bundle install`.

* SQLite3 é utilizado nesse projeto e para criar os bancos de dados basta rodar o comando `rails db:migrate`

* Seguindo os passos acima você conseguirá ver o projeto em seu navegador executando o comando `rails server` e acessando o endereço `localhost:3000`

## Testes

Nesse projeto foi utilizado `rspec` junto com `capybara`. Caso queira executar os testes, tendo seguido os passos acima, basta executar em seu terminal o comando `rspec`


## Algumas Gems

*Para fazer a autenticação foi utilizada a gem `Devise`.

*Para cuidar da parte de autenticação foi utilizada a gem `Cancancan`

*Para ajudar com a estilização do site eu utilizei o framework `Bulma`, gem `bulma-rails`, com o qual eu já tinha um pouco de experiência. 