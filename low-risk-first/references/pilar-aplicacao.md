# Pilar 1 — Aplicação

Referência detalhada para avaliação de resiliência, fallbacks, circuit breakers, SPOFs e degradação graciosa no desenho de solução.

---

## 📋 Checklist de Resiliência

### Circuit Breakers
- [ ] Todas as chamadas a serviços externos possuem circuit breaker configurado
- [ ] Estados definidos: CLOSED → OPEN → HALF-OPEN com thresholds documentados
- [ ] Tempo de recovery (half-open window) é adequado ao SLA do serviço downstream
- [ ] Comportamento quando o circuit abre está documentado (fallback, cache stale, erro controlado)

### Retry Policies
- [ ] Retries com **exponential backoff + jitter** (nunca retry linear)
- [ ] Número máximo de retries definido (geralmente 3-5)
- [ ] Idempotência garantida nas operações que sofrem retry
- [ ] Retry budget global para evitar retry storms (ex: máx 10% do tráfego total)

### Timeouts
- [ ] Timeout configurado em **todas** as chamadas de rede (HTTP, gRPC, DB, cache)
- [ ] Timeout hierárquico: timeout do gateway > timeout do serviço > timeout do DB
- [ ] Deadline propagation implementada em chamadas encadeadas (evitar que timeout do caller expire enquanto callee ainda processa)

### Bulkheads (Isolamento)
- [ ] Thread pools / connection pools separados por dependência crítica
- [ ] Falha em um downstream não consome recursos compartilhados com outros
- [ ] Limite de concorrência por tenant / cliente (evitar noisy neighbor)

### Rate Limiting
- [ ] Rate limiting no API Gateway (proteção contra abuso externo)
- [ ] Rate limiting entre serviços internos (proteção contra thundering herd)
- [ ] Resposta clara ao cliente quando rate limited (HTTP 429 + Retry-After header)

---

## 🔄 Padrões de Fallback

| Padrão | Quando Usar | Exemplo |
|---|---|---|
| **Graceful Degradation** | Funcionalidade não-essencial falha | Recomendações indisponíveis → mostrar "mais populares" estáticos |
| **Cached Response (Stale)** | Dados ligeiramente desatualizados são aceitáveis | Cache com TTL expirado retorna último valor válido |
| **Static Fallback** | Resposta fixa é melhor que erro | Configuração default hardcoded quando Config Service cai |
| **Feature Kill Switch** | Funcionalidade nova causa problema | Feature flag desliga a feature sem deploy |
| **Queue + Retry Later** | Operação pode ser eventual | Falha no envio de e-mail → enfileira para retry em 5 min |

### Perguntas de validação de fallback
- Para cada dependência externa: *"O que acontece se este serviço ficar indisponível por 5 minutos? E por 1 hora?"*
- *"O fallback foi testado? Existe teste automatizado que simula a falha?"*
- *"O usuário final percebe o fallback? Qual é a experiência degradada?"*

---

## 🎯 Identificação de SPOFs (Single Points of Failure)

### Como identificar no diagrama
1. **Componente sem réplica**: Qualquer caixa sem indicação de redundância (single instance)
2. **Dependência única sem fallback**: Seta que conecta a um serviço sem caminho alternativo
3. **Banco de dados single-node**: DB sem réplica de leitura ou standby
4. **Serviço stateful sem replicação**: Cache in-memory, session store local
5. **Componente sem health check**: Serviço que não é monitorado proativamente

### Classificação de SPOFs

| Severidade | Descrição | Ação |
|---|---|---|
| 🔴 **Crítico** | SPOF no caminho principal (happy path) — derruba toda a operação | Resolver antes do deploy |
| 🟠 **Alto** | SPOF em funcionalidade importante mas não essencial | Resolver ou documentar degradação |
| 🟡 **Médio** | SPOF em funcionalidade secundária com impacto limitado | Documentar e priorizar no backlog |

---

## 🎙️ Perguntas por Nível de Staff Engineer

### L1 — Staff Engineer (Execução Segura)
1. *"Quais são os timeouts configurados para cada chamada de rede? Estão documentados?"*
2. *"Se o banco de dados principal ficar lento (não cair, só lento), o que acontece com o serviço?"*
3. *"Existe health check configurado para cada componente? Qual é o endpoint?"*
4. *"O que acontece com as requisições in-flight durante um deploy? São drenadas graciosamente?"*
5. *"Existe limite de concorrência/connection pool? Qual o sizing e como foi calculado?"*

### L2 — Senior Staff Engineer (Resiliência Sistêmica)
1. *"Mapeie para mim os failure modes de cada dependência e o comportamento esperado do sistema em cada caso."*
2. *"Qual é o blast radius se o [componente X] falhar completamente? Quais outros serviços são impactados?"*
3. *"O circuit breaker tem métricas? Vocês sabem quando ele abre em produção?"*
4. *"Existe retry storm protection? Se 3 serviços fazem retry ao mesmo tempo no mesmo downstream, qual é o fator de amplificação?"*
5. *"Qual é a estratégia de graceful degradation? O produto aceitou a experiência degradada?"*

### L3 — Principal Engineer (Visão Estratégica)
1. *"Este design tem acoplamento temporal? O sistema funciona se os componentes estiverem em diferentes estados de deploy?"*
2. *"Qual é o custo operacional dos circuit breakers e fallbacks? Estão adicionando complexidade que a equipe consegue manter?"*
3. *"Existe um plano de evolução para simplificar a arquitetura depois da migração, ou esta complexidade é permanente?"*
4. *"O modelo de resiliência atual escala com o crescimento do time? Cada novo serviço precisa reimplementar esses padrões ou existe uma plataforma/SDK compartilhado?"*
5. *"Se este serviço se tornar o novo caminho crítico, ele está preparado para ser um 'Tier 0' com on-call dedicado?"*

---

## ⚠️ Anti-Patterns Comuns

| Anti-Pattern | Problema | Correção |
|---|---|---|
| **Retry sem backoff** | Amplifica carga no serviço já sobrecarregado | Exponential backoff + jitter |
| **Timeout infinito** | Threads presas, connection pool esgotado | Timeout explícito em toda chamada |
| **Circuit breaker sem fallback** | Abre o circuit mas retorna erro 500 | Definir comportamento alternativo |
| **Health check superficial** | `/health` retorna 200 sem verificar dependências | Deep health check com verificação de deps |
| **Single retry policy** | Mesma política para idempotente e não-idempotente | Políticas diferenciadas por tipo de operação |
| **Shared thread pool** | Downstream lento consome threads de todos os serviços | Bulkhead com pools isolados |
