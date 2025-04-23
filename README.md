# n8n-case

Simulação de uma pequena automação de dados para uma empresa de energia solar utilizando n8n, PostGreSQL e GPT-4o-mini para geração de relatórios.

## Conteúdo do repositório

- `docker-compose.yml` — sobe n8n + PostgreSQL via Docker  
- `database_queries/init.sql` — cria extensões e tabelas  
- `database_queries/insert.sql` — popula dados fictícios  
- `workflow/energy_consumption_workflow.json` — export do workflow n8n  
- `README.md` — descrição do projeto

## Pré-requisitos

- Docker & Docker Compose  
- (opcional) n8n CLI se quiser exportar workflows pela linha de comando

## Como rodar o ambiente

1. **Clone** este repositório:  
   ```bash
   git clone <URL_DO_SEU_REPO>
   cd n8n-case

2. **Suba os containers**:
    ```bash
    docker-compose up -d

3. **Instale o banco**:
    ```bash
    # executa o init.sql
    docker exec -i \
    $(docker-compose ps -q db) \
    psql -U n8nuser -d n8n < database_queries/init.sql

    # executa o insert.sql
    docker exec -i \
    $(docker-compose ps -q db) \
    psql -U n8nuser -d n8n < database_queries/insert.sql

> *os comandos acima devem ser executados em um ambiente shell Unix*

4. **Importe o workflow no n8n (só na primeira vez)**:
    - Abra http://localhost:5678

    - Vá em Workflows → Import e selecione workflow/energy_consumption_workflow.json.

5. **Ative o workflow (toggle “Active”)**.

## Como chamar o webhook
 - **Endpoint**:
    ```bash
    GET http://localhost:5678/webhook/energy-consumption

- **Resposta (exemplo**):
    ```json
    {
        "report": {
            "normal_consumers": [
            {
                "name": "Fernanda",
                "average_consumption": 164.87
            },
            {
                "name": "Roberto",
                "average_consumption": 124.5
            },
            .
            .
            .
            ]
        }
    }

## Como detectar *OUTLIERS*
Para a detecção de clientes outliers ('pontos fora da curva'), ou seja, clientes que tiveram um consumo muito acima ou abaixo do esperado, utilizou-se o seguinte método:

- Calculou-se a média aritmética de consumo de todos os contratos (com registros de pelo menos 3 meses de uso)
- Calculou-se o desvio padrão dessa média

Com essas informações, temos que **são considerados clientes ```outliers``` aqueles cujo consumo, subtraído da média, é maior do que o desvio padrão. Senão, é considerado consumo normal**