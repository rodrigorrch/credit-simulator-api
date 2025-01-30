# Credit Simulator API

Este projeto é uma API para simulação de crédito, utilizando Ruby on Rails, RabbitMQ para processamento assíncrono e Sidekiq para gerenciamento de filas.

## Requisitos

-   Ruby versão 2.7.2
-   Rails versão 6.1.4
-   PostgreSQL
-   RabbitMQ
-   Redis (para Sidekiq)

## Configuração do Ambiente

1. Clone o repositório:

    ```sh
    git clone https://github.com/rodrigorrch/credit-simulator-api
    cd credit-simulator-api
    ```

2. Configure as variáveis de ambiente:

    Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:
    ~~Na verdade não precisa.. Deixei tudo ja setado~~

    ```bash
    RABBITMQ_HOST='rabbitmq'
    RABBITMQ_PORT=5672
    RABBITMQ_USER='guest'
    RABBITMQ_PASS='guest'
    RABBITMQ_VHOST='/'
    REDIS_URL='redis://redis:6379/1'
    POSTGRES_USER='postgres'
    POSTGRES_PASSWORD='password'
    POSTGRES_DB='credit_simulator_development'
    ```

3. Subindo o projeto:

    ```sh
    docker-compose build
    docker-compose up -d
    docker-compose run web rake db:create db:migrate
    ```

## Endpoints

### Criar Simulação de Empréstimo

-   **URL**: `/api/v1/loan_simulations`
-   **Método**: `POST`
-   **Parâmetros**:

    -   `amount` (decimal): Valor do empréstimo
    -   `birth_date` (string): Data de nascimento do solicitante
    -   `currency` (string): Moeda
    -   `installments` (integer): Número de parcelas
    -   `notification_email` (string): Email para notificação
    -   `spread` (decimal): Spread do empréstimo

-   **Exemplo de Requisição**:

    ```sh
    curl --location 'localhost:3000/api/v1/loan_simulations' \
    --header 'Content-Type: application/json' \
    --data '{
      "loan_simulation": {
        "amount": 10000,
        "birth_date": "1985-06-15",
        "currency": "USD",
        "installments": 12,
        "notification_email": "example@example.com",
        "spread": 0.02
      }
    }'
    ```

### Criar Simulações em Massa

-   **URL**: `/api/v1/loan_simulations/bulk`
-   **Método**: `POST`
-   **Parâmetros**:

    -   `bulk_simulation` (array): Array de simulações de empréstimo

-   **Exemplo de Requisição**:

    ```sh
    curl --location 'localhost:3000/api/v1/loan_simulations/bulk' \
    --header 'Content-Type: application/json' \
    --data '{
      "bulk_simulation": {
        "simulations": [
          { "amount": 5000, "installments": 6, "currency": "USD", "birth_date": "1985-06-15", "notification_email": "example1@example.com", "spread": 0.02 },
          { "amount": 1000, "installments": 12, "currency": "BRL", "birth_date": "1990-08-20", "notification_email": "example2@example.com", "spread": 0.03 }
        ]
      }
    }'
    ```

## Arquitetura

### Clean Architecture

Este projeto segue os princípios da Clean Architecture, dividindo o código em camadas bem definidas para manter a separação de responsabilidades e facilitar a manutenção e escalabilidade do sistema.

#### Estrutura do Projeto

-   **Application**: Contém os casos de uso (use cases) que orquestram a lógica de aplicação. Esta camada é responsável por coordenar as operações entre as diferentes partes do sistema.

    -   **UseCases**: Implementações dos casos de uso da aplicação.

-   **Domain**: Contém as entidades e regras de negócio. Esta camada é independente de frameworks e bibliotecas externas, focando apenas na lógica de negócio.

    -   **Entities**: Definições das entidades do domínio.
    -   **Services**: Serviços de domínio que encapsulam a lógica de negócio.

-   **Infrastructure**: Contém a implementação de detalhes técnicos, como repositórios, serviços externos e configurações de banco de dados.

    -   **Repositories**: Implementações de repositórios para acesso a dados.
    -   **Queue**: Configurações e implementações do RabbitMQ para filas de mensagens.
    -   **Services**: Implementações de serviços externos, como envio de emails.

-   **Interfaces**: Contém os controladores e adaptadores que expõem a API para o mundo externo.
    -   **Controllers**: Controladores responsáveis por receber as requisições HTTP e retornar as respostas.
    -   **Serializers**: Serializadores para formatar as respostas JSON.

### Tecnologias Utilizadas

-   **Ruby on Rails**: Framework web utilizado para construir a API.
-   **RabbitMQ**: Utilizado para processamento assíncrono de mensagens.
-   **Sidekiq**: Utilizado para gerenciamento de filas e processamento em background.
-   **PostgreSQL**: Banco de dados relacional utilizado para armazenar os dados.
-   **Redis**: Utilizado pelo Sidekiq para gerenciamento de filas.

## Testes

Para rodar a suíte de testes, utilize o seguinte comando:

```sh
docker-compose exec app rspec
```
