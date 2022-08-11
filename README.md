[Descrição](#descrição)

  

[Gems instaladas](#gems-instaladas)

  

[Rodando a aplicação](#rodando-a-aplicação-arrow_forward)

  

[Rodando os testes](#rodando-os-testes-memo)

  

[Rotas](#rotas)

  

[Considerações](#considerações)


## Descrição

<p  align="justify"> Desafio noz é uma Api utilizada para listar autores e livros, dos quais uma pessoa autenticada pode consultar a lista, fazer edições, consultar ou deletar um livros ou autores. Também é possível filtrar a lista de livros e autores utilizando um filtro
</p>

##  Gems instaladas

<p  align="justify"> As gems instaladas nessa aplição e suas dependências podem ser encontradas no arquivo Gemfile e Gemfile.lock respctivamente

  * ruby '3.0.3'
  * rails '7.0.3.1'
  * factory_bot_rails, para auxiliar na criação de testes
  * rspec-rails, para a execução de testes
  * rubocop utilizado como linter
  * pagy, para auxiliar na paginação
  * rswag, para documentar os endpoints
  * jwt, para autenticar usuários

## Rodando a aplicação

1. Clone o repositório

```
git clone https://github.com/namae-no-nai/desafio-noz
```
2. Build a aplicação com docker
```
docker-compose build
```
 Setup do banco de dados, criação, aplicação das migrações e a seed
```
docker-compose rails db:create db:migrate db:seed
```
 Execute a aplicação
```
docker-compose up
```
2. Build a aplicação local

certifique-se que sua máquina tem ruby na versão 3.0.3, podendo se utilizar de um gerenciador de versões como o ```rvm``` ou ```rbenv```, assim como Postresql, que pode ser verificado pelo comando ```psql```.

Execute
```bundle install```
para instalar as gems necessárias do projeto

Faça o setup do banco de dados
```rails db:create db:migrate db:seed```

 Execute a aplicação
```
rails s
```
A aplicação rodará na porta local 30000 => http://localhost:3000.

</p>

##  Rodando os testes

  
<p  align="justify">Para a rodar os testes é necessário executar</p>
 
 ```
docker-compose run web rspec
```
ou localmente
```
rspec
```

<p  align="justify">Outros comandos úteis são</p>

```
docker-compose run web rubocop
```
ou localmente
```
rubocop
```

<p  align="justify">Faz o lint do código da aplicação e </p>

```
docker-compose run web rails c
```
ou localmente
```
rails c
```
<p  align="justify">Permite o acesso ao console da aplicação </p>

##  Rotas

<p  align="justify"> As rotas da aplicação podem ser encontradas utilizando o comando
```
docker-compose run web rails routes
```
ou localmente apenas 
```
rails routes
```
Em relação aos endpoints da aplicação, os mesmos podem ser encontrados no servidor local, no caso http://localhost:3000/api-docs, ou podem ser exportados para o Postman, Insomnia e programas similares utilizando o arquivo swagger.yml na raiz da aplicação.

##  Considerações

<p  align="justify"> O código foi feito com o íntuito de rodar uma API simples, cabendo no entanto a implementação de outras features, e outras instrumentações para cobertura de testes como o simplecov, entre outras melhorias que não foram possíveis devido ao curto espaço de tempo.</p>