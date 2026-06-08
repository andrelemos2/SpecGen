# Template: Design (Arquitetura e Contratos)

> Copie para `.sdd/specs/[feature-slug]/design.md`
> Owner: Arquiteto / Tech Lead da feature

---

# Design: [Feature Name]

**ID:** FEAT-[NNN]
**Data:** YYYY-MM-DD
**Status:** DRAFT | APPROVED

---

## Visão Arquitetural

> Diagrama de alto nível mostrando todos os componentes envolvidos.
> Inclua sistemas externos, bancos de dados, queues e caches.

```mermaid
flowchart TD
    Client([Client / Browser]) --> GW[API Gateway]
    GW --> Auth[AuthService]
    GW --> Feature[FeatureService]
    Feature --> Repo[FeatureRepository]
    Feature --> Cache[(Redis Cache)]
    Repo --> DB[(PostgreSQL)]
    Feature --> Queue[/Message Queue/]
    Queue --> Worker[Background Worker]
```

---

## Fluxo Principal (Happy Path)

```mermaid
sequenceDiagram
    actor User
    participant API
    participant Service
    participant Cache
    participant DB

    User->>API: POST /api/[endpoint] {payload}
    API->>API: validate(payload)
    API->>Service: execute(command)
    Service->>Cache: get(key)
    alt Cache hit
        Cache-->>Service: cached result
        Service-->>API: result
    else Cache miss
        Service->>DB: query(entity)
        DB-->>Service: entity
        Service->>Cache: set(key, result, TTL)
        Service-->>API: result
    end
    API-->>User: 200 OK {response}
```

---

## Fluxos de Erro

```mermaid
sequenceDiagram
    actor User
    participant API
    participant Service

    User->>API: POST /api/[endpoint] {payload inválido}
    API->>API: validate(payload)
    API-->>User: 400 Bad Request {error: "VALIDATION_ERROR"}

    User->>API: POST /api/[endpoint] sem token
    API-->>User: 401 Unauthorized {error: "UNAUTHORIZED"}
```

---

## Modelo de Dados (quando há mudança de schema)

```mermaid
erDiagram
    ENTITY_A {
        uuid id PK
        string name
        string status
        timestamp created_at
        timestamp updated_at
    }
    ENTITY_B {
        uuid id PK
        uuid entity_a_id FK
        string value
    }
    ENTITY_A ||--o{ ENTITY_B : "has many"
```

---

## Boundaries de Módulos e Lazy Loading (quando aplicável)

```mermaid
flowchart LR
    subgraph Eager["⚡ Core — Eager Loading"]
        AuthModule
        ConfigModule
        DatabaseModule
    end
    subgraph Lazy["🔄 Features — Lazy Loading"]
        FA["FeatureAModule\n[lazy]"]
        FB["FeatureBModule\n[lazy]"]
    end
    AppModule --> Eager
    Router --> FA
    Router --> FB

    style FA fill:#4CAF50,color:#fff
    style FB fill:#4CAF50,color:#fff
```

> Módulos com `[lazy]` são carregados somente quando a rota correspondente é acessada.

---

## Contratos de API

### [MÉTODO] /api/[endpoint]

**Auth:** Bearer Token (JWT) | Public | API Key
**Rate Limit:** [N] req/min por [usuário/IP]

**Request:**
```json
{
  "campo1": "string (obrigatório)",
  "campo2": "number (opcional, default: 0)"
}
```

**Response [STATUS]:**
```json
{
  "id": "uuid",
  "campo1": "string",
  "createdAt": "ISO 8601"
}
```

**Erros:**
| Status | Código de Erro | Quando ocorre |
|--------|---------------|---------------|
| 400 | `VALIDATION_ERROR` | Payload inválido |
| 401 | `UNAUTHORIZED` | Token ausente ou expirado |
| 403 | `FORBIDDEN` | Sem permissão para o recurso |
| 404 | `NOT_FOUND` | Recurso não existe |
| 409 | `CONFLICT` | Recurso duplicado |
| 429 | `RATE_LIMITED` | Limite de requisições excedido |
| 500 | `INTERNAL_ERROR` | Erro inesperado |

---

## Decisões de Design (ADR inline)

| Decisão | Alternativas consideradas | Justificativa |
|---------|--------------------------|---------------|
| [ex: Usar Redis para cache] | [Memcached, sem cache] | [TTL configurável, suporte a pub/sub] |
| [ex: Padrão Repository] | [Active Record, Query Builder] | [Testabilidade, separação de concerns] |
