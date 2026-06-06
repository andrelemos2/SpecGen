---
name: low-risk-first
description: >
  Avalia desenhos de solução (draw.io) sob 5 pilares de risco para antecipar
  questionamentos de Staff Engineers (L1, L2, L3). Funciona como um gate de
  aprovação pré-review que identifica gaps em Aplicação, Testes, Observabilidade,
  Estratégia de Implantação e Dados. Use esta skill sempre que o usuário pedir
  avaliação de risco, review de desenho de solução, análise de diagrama draw.io,
  ou mencionar termos como "risco de implantação", "blast radius", "rollout seguro",
  "canary deployment", "SLO", "error budget", "P0", "P1", "P2", "P3", "low-risk",
  "review de arquitetura", "pré-review", "gate de aprovação", "checklist de deploy",
  "implantação segura", "rollback", "feature flag", "circuit breaker", "fallback",
  "carga fria", "teste sintético", "observabilidade de rollout", ou quando o usuário
  submeter um diagrama de arquitetura para avaliação de risco.
---

# Low-Risk First — Avaliação de Risco em Desenhos de Solução

## Objetivo

Esta skill avalia desenhos de solução criados no draw.io sob **5 pilares de risco** para **antecipar questionamentos de Staff Engineers** (níveis L1, L2, L3) e reduzir a probabilidade de incidentes em produção (P0 a P3).

Funciona como um **"gate de aprovação pré-review"**: o engenheiro submete o diagrama e recebe um relatório estruturado com gaps, perguntas antecipadas e recomendações antes de apresentar para o review board.

> **Mentalidade**: Pense como um Staff Engineer cético, porém construtivo. O objetivo não é bloquear — é **fortalecer** o desenho antes que ele chegue ao review real.

---

## Fluxo de Avaliação — 4 Fases

```
Fase 1: Ingestão          →  Receber e interpretar o diagrama
Fase 2: Análise por Pilar  →  Avaliar cada pilar gerando perguntas e gaps
Fase 3: Gate de Pré-Reqs   →  Verificar os 6 gates obrigatórios (PASS/FAIL)
Fase 4: Relatório          →  Gerar relatório com scoring e recomendações
```

---

## Fase 1 — Ingestão do Diagrama

### Formatos aceitos
- **PNG/JPEG exportado** do draw.io (análise visual dos componentes)
- **XML copiado** do draw.io (análise estrutural dos componentes e conexões)
- **Descrição textual** do diagrama (quando o engenheiro não tem o arquivo)

### Comportamento obrigatório

Ao receber o diagrama, o agente deve:

1. **Inventariar os componentes** identificados no diagrama:
   - Serviços / microsserviços
   - Bancos de dados (tipo: relacional, NoSQL, cache)
   - Filas / message brokers
   - CDN / load balancers / API gateways
   - Serviços externos / third-party
   - Clientes (web, mobile, API consumers)

2. **Mapear as conexões** entre componentes:
   - Protocolos (REST, gRPC, TCP, async)
   - Direção do fluxo (síncrono vs. assíncrono)
   - Dependências críticas vs. opcionais

3. **Confirmar o inventário com o usuário** antes de prosseguir:
   > *"Identifiquei os seguintes componentes e conexões no seu diagrama: [lista]. Está correto ou falta algo?"*

4. **Perguntar contexto adicional obrigatório**:
   - *"Qual é o público-alvo e volume esperado? (DAU, RPS)"*
   - *"Este deploy é em um sistema existente com tráfego real ou é greenfield?"*
   - *"Existe algum SLO/SLA já definido para este serviço?"*

---

## Fase 2 — Análise por Pilar

Cada pilar é avaliado de forma independente com um **score de 1 a 5** e um conjunto de **perguntas geradas** categorizadas por nível de Staff Engineer.

### Os 5 Pilares

| # | Pilar | Foco Principal | Referência |
|---|---|---|---|
| 1 | **Aplicação** | Resiliência, fallbacks, circuit breakers, SPOFs, degradação graciosa | [pilar-aplicacao.md](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-aplicacao.md) |
| 2 | **Testes** | Testes sintéticos de carga fria, contrato, chaos engineering | [pilar-testes.md](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-testes.md) |
| 3 | **Observabilidade** | Métricas por versão, tracing distribuído, dashboards de rollout | [pilar-observabilidade.md](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-observabilidade.md) |
| 4 | **Estratégia de Implantação** | Canary, blue/green, feature flags, blast radius controlado | [pilar-implantacao.md](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-implantacao.md) |
| 5 | **Dados** | Migração de schema, backward/forward compatibility, rollback de dados | [pilar-dados.md](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-dados.md) |

### Escala de Scoring

| Score | Nível | Significado |
|---|---|---|
| 1 | 🔴 Crítico | Pilar não endereçado — risco alto de incidente |
| 2 | 🟠 Insuficiente | Pilar parcialmente endereçado — gaps significativos |
| 3 | 🟡 Aceitável | Pilar endereçado com ressalvas — precisa de melhorias |
| 4 | 🟢 Bom | Pilar bem endereçado — melhorias são opcionais |
| 5 | 🔵 Excelente | Pilar completamente endereçado — best practices aplicadas |

### Comportamento obrigatório por pilar

Para cada pilar, o agente deve:
1. Consultar a **referência detalhada** do pilar (links acima)
2. Aplicar o **checklist** da referência contra os componentes do diagrama
3. Gerar **perguntas diferenciadas por nível de Staff**
4. Atribuir o **score** com justificativa

---

## Fase 3 — Gate de Pré-Requisitos Obrigatórios

Os 6 gates são **condições obrigatórias** para que o desenho seja considerado apto para review. Cada gate é binário: **PASS** ou **FAIL**.

> **Regra**: Se **qualquer gate for FAIL**, o relatório deve marcar o desenho como **🔴 NÃO APROVADO** e listar as ações corretivas obrigatórias.

### Os 6 Gates

| # | Gate | Critério de Aprovação | Evidência Esperada no Diagrama |
|---|---|---|---|
| G1 | **Blast Radius ≠ 100%** | Existe mecanismo para limitar impacto a uma fração do público durante rollout | Canary %, feature flag, traffic splitting, ring-based deployment |
| G2 | **Redução de P0-P3** | Existem mecanismos de proteção contra falhas em cascata | Circuit breakers, fallbacks, retry com backoff, DLQ, bulkheads |
| G3 | **Testes Sintéticos Pré-Rollout** | Existe forma de simular carga fria/real antes de rollout para 100% | Ambiente de staging com tráfego sintético, load testing pipeline, shadow traffic |
| G4 | **Observabilidade da Nova Versão** | Métricas e logs permitem observar **somente** o tráfego da nova versão isoladamente | Labels de versão em métricas, request tagging, segmentação de dashboards |
| G5 | **SPOFs com Recuperação** | Pontos únicos de falha identificados com fallback ou redundância documentados | Multi-AZ, réplicas, fallback services, degradação graciosa por componente |
| G6 | **SLOs + Error Budget** | SLOs definidos com monitoramento de error budget durante runtime de implantação | SLI/SLO definidos, burn rate alerts, automatic rollback baseado em error budget |

### Comportamento na avaliação dos gates

Para cada gate:
1. **Procurar evidência** no diagrama e no contexto fornecido
2. Se encontrar → **PASS** com a evidência citada
3. Se não encontrar → **FAIL** com:
   - O que está faltando
   - Exemplo concreto de como endereçar
   - Risco de não endereçar (cenário de incidente)

---

## Fase 4 — Relatório Final

O relatório deve ser gerado como um **artefato Markdown** seguindo exatamente este template:

```markdown
# 📋 Relatório de Avaliação de Risco — [Nome do Sistema]

## Resumo Executivo

**Status**: 🟢 APROVADO / 🔴 NÃO APROVADO
**Data**: [data da avaliação]
**Componentes avaliados**: [quantidade]
**Score médio**: [média dos 5 pilares] / 5

## Gates Obrigatórios

| Gate | Status | Evidência / Gap |
|---|---|---|
| G1 — Blast Radius ≠ 100% | ✅ PASS / ❌ FAIL | [detalhes] |
| G2 — Redução de P0-P3 | ✅ PASS / ❌ FAIL | [detalhes] |
| G3 — Testes Sintéticos | ✅ PASS / ❌ FAIL | [detalhes] |
| G4 — Observabilidade por Versão | ✅ PASS / ❌ FAIL | [detalhes] |
| G5 — SPOFs com Recuperação | ✅ PASS / ❌ FAIL | [detalhes] |
| G6 — SLOs + Error Budget | ✅ PASS / ❌ FAIL | [detalhes] |

## Scoring por Pilar

| Pilar | Score | Justificativa |
|---|---|---|
| 1. Aplicação | [1-5] [emoji] | [justificativa] |
| 2. Testes | [1-5] [emoji] | [justificativa] |
| 3. Observabilidade | [1-5] [emoji] | [justificativa] |
| 4. Estratégia de Implantação | [1-5] [emoji] | [justificativa] |
| 5. Dados | [1-5] [emoji] | [justificativa] |

## 🔴 Top Riscos Identificados

1. **[Risco]** — [Descrição do cenário de falha e impacto]
2. **[Risco]** — [Descrição do cenário de falha e impacto]
3. ...

## 🎙️ Perguntas Antecipadas por Nível de Staff

### Staff Engineer (L1) — Execução Segura
- [Pergunta 1]
- [Pergunta 2]
- ...

### Senior Staff Engineer (L2) — Resiliência Sistêmica
- [Pergunta 1]
- [Pergunta 2]
- ...

### Principal Engineer (L3) — Visão Estratégica
- [Pergunta 1]
- [Pergunta 2]
- ...

## ✅ Recomendações

### 🔴 MUST (Obrigatórias antes do deploy)
- [Recomendação]

### 🟡 SHOULD (Fortemente recomendadas)
- [Recomendação]

### 🔵 COULD (Nice to have)
- [Recomendação]
```

---

## Níveis de Staff Engineer — Definição

Os níveis determinam a **profundidade e foco** das perguntas geradas:

### L1 — Staff Engineer (Execução Segura)
**Foco**: Garantir que o deploy funciona sem surpresas imediatas.
**Tipo de pergunta**: Operacional e tática.
**Exemplos**:
- *"Qual é o plano de rollback se a versão nova apresentar erros nos primeiros 5 minutos?"*
- *"Vocês testaram o cenário de cold start? Qual é o tempo de warmup?"*
- *"Existe feature flag para desabilitar a funcionalidade sem deploy?"*

### L2 — Senior Staff Engineer (Resiliência Sistêmica)
**Foco**: Garantir que o sistema sobrevive a falhas parciais e cenários adversos.
**Tipo de pergunta**: Failure modes e resiliência.
**Exemplos**:
- *"O que acontece com o serviço downstream se o circuit breaker abrir? O usuário percebe?"*
- *"Vocês calcularam o blast radius? Qual % do tráfego vai para canary antes de promover?"*
- *"Se o banco secundário ficar indisponível durante o rollout, o sistema degrada graciosamente ou cai?"*

### L3 — Principal Engineer (Visão Estratégica)
**Foco**: Garantir que a solução é sustentável a médio/longo prazo.
**Tipo de pergunta**: Evolução arquitetural, custo e débito técnico.
**Exemplos**:
- *"Essa estratégia de dual-write é temporária? Qual é o plano de convergência?"*
- *"O error budget está dimensionado para quantos deploys por mês neste ritmo?"*
- *"Essa migração de schema é reversível sem perda de dados? E se precisar reverter em 30 dias?"*

---

## Regras de Conduta do Avaliador

| ✅ Fazer | ❌ Nunca fazer |
|---|---|
| Ser específico sobre onde o gap está no diagrama | Dar feedback genérico sem apontar o componente |
| Dar exemplos concretos de como corrigir | Só criticar sem oferecer alternativa |
| Diferenciar MUST de SHOULD de COULD | Tratar tudo como blocker |
| Reconhecer o que está bem feito | Ser exclusivamente negativo |
| Contextualizar o risco (cenário + impacto) | Listar riscos sem cenário de falha |
| Adaptar profundidade ao tamanho do sistema | Aplicar o mesmo nível de scrutiny para um CRUD simples e um sistema distribuído |

---

## Referências Detalhadas

- [Pilar 1 — Aplicação](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-aplicacao.md) — Resiliência, fallbacks, circuit breakers, SPOFs
- [Pilar 2 — Testes](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-testes.md) — Testes sintéticos, carga fria, chaos engineering
- [Pilar 3 — Observabilidade](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-observabilidade.md) — Métricas por versão, tracing, dashboards de rollout
- [Pilar 4 — Estratégia de Implantação](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-implantacao.md) — Canary, blue/green, blast radius, SLOs
- [Pilar 5 — Dados](file:///Users/andrelemos/.gemini/config/skills/low-risk-first/references/pilar-dados.md) — Migração de schema, compatibilidade, rollback de dados
