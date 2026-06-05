# Pilar 3 — Observabilidade

Referência detalhada para avaliação de métricas por versão, tracing distribuído, dashboards de rollout e alertas durante implantação.

---

## 📋 Checklist de Observabilidade

### Métricas Obrigatórias (Golden Signals)
- [ ] **Latência**: p50, p95, p99 por endpoint e por versão
- [ ] **Taxa de Erro**: Error rate (5xx) por endpoint e por versão
- [ ] **Tráfego**: RPS por endpoint e por versão
- [ ] **Saturação**: CPU, memória, connection pool, thread pool, queue depth

### Métricas por Tipo de Componente

| Componente | Métricas Essenciais |
|---|---|
| **API / Serviço** | Latência (p50/p95/p99), error rate, RPS, connection pool usage |
| **Fila / Message Broker** | Queue depth, consumer lag, message age, DLQ size, throughput |
| **Banco de Dados** | Query latência, connections ativas, replication lag, lock waits |
| **Cache** | Hit rate, miss rate, eviction rate, memory usage, latência |
| **Load Balancer** | Active connections, healthy targets, 5xx rate, spillover count |
| **Serviço Externo** | Latência, error rate, circuit breaker state, timeout rate |

### Métricas Segmentadas por Versão (OBRIGATÓRIO)
- [ ] Todas as métricas acima incluem **label/tag de versão** do serviço
- [ ] Dashboards permitem **filtrar e comparar** versão atual vs. versão anterior
- [ ] Alertas podem ser configurados **por versão** (ex: alerta só na versão canary)
- [ ] Request tracing inclui **versão do serviço** como atributo do span

---

## 🔍 Tracing Distribuído

### Requisitos Mínimos
- [ ] Tracing implementado em **todos** os serviços do diagrama
- [ ] Context propagation configurado (trace-id passa entre serviços)
- [ ] Sampling rate adequado (100% em staging, 1-10% em prod, 100% em erros)
- [ ] Spans incluem atributos de negócio (user_id, order_id, etc.)
- [ ] Spans incluem **versão do serviço** como atributo

### Correlação de Sinais
- [ ] Logs correlacionados com trace-id (log → trace)
- [ ] Métricas correlacionadas com traces (exemplar → trace)
- [ ] Alertas linkam para traces relevantes
- [ ] Dashboard de rollout permite drill-down: métrica → trace → log

---

## 📊 Dashboards de Rollout

### Dashboard Obrigatório de Implantação

O dashboard de rollout deve conter **no mínimo** as seguintes seções:

```
┌─────────────────────────────────────────────────────┐
│                ROLLOUT DASHBOARD                     │
├──────────────────┬──────────────────────────────────┤
│ Status do Rollout │ % tráfego por versão (v1 vs v2) │
├──────────────────┼──────────────────────────────────┤
│ Error Rate       │ Comparação v1 vs v2 (side-by-side)│
├──────────────────┼──────────────────────────────────┤
│ Latência p99     │ Comparação v1 vs v2 (side-by-side)│
├──────────────────┼──────────────────────────────────┤
│ SLO Burn Rate    │ Error budget consumido (gauge)    │
├──────────────────┼──────────────────────────────────┤
│ Saturação        │ CPU, mem, connections por versão  │
├──────────────────┼──────────────────────────────────┤
│ Anomalias        │ Exceptions novas, log patterns    │
└──────────────────┴──────────────────────────────────┘
```

### Requisitos do Dashboard
- [ ] Dashboard criado **antes** do rollout (não durante)
- [ ] Link do dashboard está no runbook de deploy
- [ ] Dashboard é acessível para todos os stakeholders (não só infra)
- [ ] Período de retenção dos dados cobre pelo menos 7 dias pós-deploy

---

## 🚨 Alertas Durante Rollout

### Alertas Obrigatórios

| Alerta | Condição | Ação |
|---|---|---|
| **Error Rate Spike** | Error rate da v2 > 2x error rate da v1 | Pausar rollout, investigar |
| **Latência Degradada** | p99 da v2 > p99 da v1 + 50% | Pausar rollout, investigar |
| **SLO Burn Rate Alto** | Burn rate > 10x (consumindo error budget rápido demais) | Rollback automático |
| **Saturação Crítica** | CPU > 80% ou Memory > 85% na v2 | Pausar rollout, investigar |
| **Queue Growing** | Queue depth crescendo por > 5 min | Pausar rollout, verificar consumers |
| **Zero Traffic** | v2 recebendo 0 RPS quando deveria receber | Verificar routing, health checks |

### Automatic Rollback Triggers
- [ ] Existe trigger de **rollback automático** baseado em métricas
- [ ] Critérios de rollback automático estão documentados e validados pelo time
- [ ] Rollback automático foi **testado** (não só configurado)
- [ ] Existe notificação quando rollback automático é acionado

---

## 📝 Logging Estruturado

### Requisitos
- [ ] Logs em formato estruturado (JSON) com campos padronizados
- [ ] Campos obrigatórios: `timestamp`, `level`, `service`, `version`, `trace_id`, `message`
- [ ] Log levels usados corretamente (ERROR para erros, WARN para degradação, INFO para eventos de negócio)
- [ ] Logs sensíveis (PII) são mascarados ou omitidos
- [ ] Retenção de logs cobre período de rollback (mín. 7 dias)

### Log Patterns para Rollout
- [ ] Log de início e fim do rollout com metadados (versão, % tráfego, operator)
- [ ] Log de promoção entre estágios do rollout
- [ ] Log de rollback com motivo
- [ ] Log de circuit breaker state changes (CLOSED → OPEN → HALF-OPEN)

---

## 🎙️ Perguntas por Nível de Staff Engineer

### L1 — Staff Engineer (Execução Segura)
1. *"Me mostra o dashboard que vocês vão usar durante o deploy. Ele já existe?"*
2. *"Consigo ver métricas separadas da versão nova vs. a versão antiga?"*
3. *"Se a versão nova começar a dar erro, qual é o primeiro alerta que dispara? Em quanto tempo?"*
4. *"Os logs estão estruturados? Consigo filtrar por trace_id para acompanhar uma request?"*
5. *"Qual é o sampling rate do tracing? É suficiente para pegar problemas intermitentes?"*

### L2 — Senior Staff Engineer (Resiliência Sistêmica)
1. *"Existe rollback automático baseado em métricas? Quais são os triggers e já foram testados?"*
2. *"Se o serviço downstream degradar durante o rollout, vocês conseguem distinguir se é culpa da nova versão ou do downstream?"*
3. *"O SLO burn rate está sendo monitorado durante o rollout? Qual é o threshold para pausar?"*
4. *"Vocês têm correlação entre métricas, logs e traces? Consigo ir de um alerta até o root cause em quantos cliques?"*
5. *"As métricas de saturação estão por versão? Se a v2 consumir 3x mais CPU, vocês detectam antes de atingir 100% do tráfego?"*

### L3 — Principal Engineer (Visão Estratégica)
1. *"O custo de observabilidade (storage, processamento, licenças) está proporcional ao valor? Existe plano de otimização?"*
2. *"O padrão de observabilidade é consistente entre todos os serviços do time ou cada um faz do seu jeito?"*
3. *"Existe uma plataforma de observabilidade compartilhada ou cada time monta seu stack?"*
4. *"Os dashboards de rollout são reutilizáveis entre serviços ou precisam ser criados do zero a cada deploy?"*
5. *"Se a organização crescer 3x em serviços, o modelo atual de alertas escala ou vira alert fatigue?"*

---

## ⚠️ Anti-Patterns Comuns

| Anti-Pattern | Problema | Correção |
|---|---|---|
| **Métricas sem label de versão** | Impossível isolar o comportamento da nova versão | Adicionar version label em todas as métricas |
| **Dashboard criado durante o deploy** | Atrasa o rollout, propenso a erros | Dashboard pronto e validado antes do deploy |
| **Alertas genéricos** | Alert fatigue, alertas ignorados | Alertas específicos com runbook linkado |
| **Sampling 100% em prod** | Custo excessivo, storage explode | Sampling inteligente (100% em erros, 1-10% em sucesso) |
| **Logs sem trace_id** | Impossível correlacionar logs com requests | Context propagation obrigatório |
| **Observar só happy path** | Falhas silenciosas passam despercebidas | Métricas e alertas para DLQ, circuit breaker, fallback |
