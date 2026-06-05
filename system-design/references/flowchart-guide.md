# Guia de Desenho e Flowchart com Mermaid

Este guia orienta o desenvolvimento e geração de diagramas de arquitetura utilizando a sintaxe **Mermaid Flowchart** diretamente no Markdown dos artefatos.

---

## 🎨 Padrão Visual e de Cores

Para que o diagrama pareça profissional, utilize a estrutura de camadas da esquerda para a direita (`graph LR`) e organize os componentes em `subgraph` correspondentes. Adicione classes de estilo (`classDef`) para manter a consistência visual das cores.

### 1. Camadas e Cores Recomendadas

| Camada | Função | Cor de Fundo | Cor da Borda |
|---|---|---|---|
| **Atores** | Clientes, APIs externas, Web/Mobile App | `#e1f5fe` | `#0288d1` |
| **API Layer** | Gateway, Load Balancers, Proxies, Auth | `#f3e5f5` | `#7b1fa2` |
| **Processing** | Microserviços, Workers, Filas, Streams | `#fff3e0` | `#f57c00` |
| **Data Layer** | Bancos de dados, Caches, Object Storage, CDNs | `#e8f5e9` | `#388e3c` |

### 2. Estilo de Conexões (Setas)
- As conexões devem possuir rótulos (labels) claros indicando o protocolo ou tipo de comunicação (ex: `HTTPS (REST)`, `gRPC`, `Redis TCP`, `SQL`).
- Para chamadas assíncronas (como polling de filas ou push notifications), prefira setas tracejadas (`-.->`).
- Para fluxos síncronos padrão, utilize setas normais (`-->`).

---

## 💻 Exemplo de Sintaxe Mermaid

Abaixo está o template Mermaid oficial correspondente a uma arquitetura típica de feed e publicação de posts:

```mermaid
graph LR
    subgraph Atores ["Atores"]
        client["Mobile App<br>(Swift/Kotlin)"]
    end

    subgraph API_Layer ["API Layer"]
        gateway["Amazon API Gateway<br>(Auth/Throttling)"]
    end

    subgraph Processing ["Processing"]
        feed-api["Feed Service<br>(Go)"]
        post-api["Post Service<br>(Go)"]
        sqs["Post SQS Queue<br>(AWS SQS)"]
        worker["Fan-out Worker<br>(Go)"]
    end

    subgraph Data_Layer ["Data Layer"]
        redis["ElastiCache Redis<br>(Redis Cache)"]
        rds["RDS PostgreSQL<br>(Relational DB)"]
    end

    %% Conexões
    client -->|HTTPS (REST)| gateway
    gateway -->|gRPC| feed-api
    gateway -->|gRPC| post-api
    feed-api -->|Redis TCP| redis
    post-api -->|AWS SDK| sqs
    sqs -.->|Polling| worker
    worker -->|Redis Pipeline| redis
    worker -->|SQL (Bulk Write)| rds

    %% Definições de Estilo
    classDef actors fill:#e1f5fe,stroke:#0288d1,stroke-width:2px,color:#333;
    classDef api fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px,color:#333;
    classDef process fill:#fff3e0,stroke:#f57c00,stroke-width:2px,color:#333;
    classDef data fill:#e8f5e9,stroke:#388e3c,stroke-width:2px,color:#333;

    %% Aplicação das Classes
    class client actors;
    class gateway api;
    class feed-api,post-api,sqs,worker process;
    class redis,rds data;
```

---

## ⚠️ Anti-Patterns a Evitar

1. **Diagramas gigantes sem subgraphs**: Agrupar componentes por subgraphs de camada torna a leitura infinitamente mais fácil.
2. **Setas sem nome de protocolo**: Sempre especifique `REST`, `gRPC`, `TCP`, etc. nas conexões para que o revisor saiba a tecnologia envolvida.
3. **Cores inconsistentes**: Não utilize cores aleatórias para os nós. Siga estritamente o mapeamento de classes (`actors`, `api`, `process`, `data`) definido acima.
