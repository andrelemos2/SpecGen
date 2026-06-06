# Pilar 5 — Dados

Referência detalhada para avaliação de migração de schema, compatibilidade backward/forward, dual-write, rollback de dados e impacto de mudanças de dados no blast radius.

---

## 📋 Checklist de Dados

### Migração de Schema
- [ ] Migração de schema usa padrão **expand-contract** (nunca breaking change direto)
- [ ] Migração é **backward-compatible** (versão antiga do código funciona com schema novo)
- [ ] Migração é **forward-compatible** (versão nova do código funciona com schema antigo, em caso de rollback)
- [ ] Migração foi testada com volume de dados representativo (não só com DB vazio)
- [ ] Tempo estimado de migração documentado (e aceitável para a janela de deploy)
- [ ] Migração é **reversível** sem perda de dados

### Compatibilidade de Dados

| Cenário | Pergunta | Risco se Não Endereçado |
|---|---|---|
| **Campo novo** | É opcional com default? | Versão antiga quebra ao ler o registro |
| **Campo removido** | Código antigo depende dele? | Rollback causa NullPointerException |
| **Tipo alterado** | Conversão é bidirecional? | Rollback perde precisão ou trunca dados |
| **Índice novo** | Quanto tempo para criar em prod? | Lock de tabela durante criação |
| **Constraint nova** | Dados existentes são válidos? | Migração falha em prod mas passa em staging |

### Rollback de Dados
- [ ] Plano de rollback de dados existe e está documentado
- [ ] Dados criados/modificados pela versão nova são tratáveis em rollback
- [ ] Não há **perda de dados** irreversível em caso de rollback
- [ ] Compensating transactions definidas para operações não-reversíveis
- [ ] Backup pontual (snapshot) feito antes da migração

---

## 🔄 Padrão Expand-Contract para Migrações

### As 3 Fases

```
Fase 1: EXPAND     → Adiciona campo/tabela nova (sem remover a antiga)
                      Deploy: v2 escreve nos dois, lê do novo
                      Rollback: seguro (v1 ignora o campo novo)

Fase 2: MIGRATE    → Migra dados existentes do formato antigo para o novo
                      Deploy: job de migração em background
                      Rollback: dados duplicados, mas sem perda

Fase 3: CONTRACT   → Remove campo/tabela antiga (somente após validação)
                      Deploy: v3 só usa o novo
                      Rollback: ⚠️ ponto de não-retorno
```

### Regras do Expand-Contract
1. **Nunca faça EXPAND + CONTRACT no mesmo deploy** — sempre em releases separados
2. **Fase MIGRATE deve ser idempotente** — pode rodar múltiplas vezes sem efeito colateral
3. **Fase CONTRACT só acontece quando 100% do tráfego está na v2** e dados migrados validados
4. **Cada fase é independente e pode ser revertida** (exceto CONTRACT)

---

## 📊 Dual-Write e Dual-Read

### Quando Usar
- Migração de um banco de dados para outro (ex: MySQL → DynamoDB)
- Migração de um serviço de storage para outro (ex: S3 → outro provider)
- Qualquer cenário onde dois sistemas precisam estar sincronizados durante transição

### Padrões

| Padrão | Como Funciona | Risco | Mitigação |
|---|---|---|---|
| **Dual-Write** | Aplicação escreve em ambos (antigo e novo) | Inconsistência se uma escrita falha | Escrita no antigo é source-of-truth + reconciliação assíncrona |
| **Dual-Read + Compare** | Lê de ambos e compara resultados | Performance (2x latência de leitura) | Shadow read assíncrono, compare em background |
| **CDC (Change Data Capture)** | Captura mudanças do banco antigo e replica no novo | Lag de replicação | Monitorar lag, não promover até lag = 0 |
| **Strangler Fig** | Novas escritas vão para o novo, leituras buscam em ambos | Complexidade de routing | Feature flag para direcionar tráfego |

### Checklist de Dual-Write
- [ ] Source-of-truth definido (qual banco é o "master" durante transição)
- [ ] Reconciliação automática configurada (detecta e corrige divergências)
- [ ] Monitoramento de divergência entre os dois bancos
- [ ] Plano de convergência definido (quando desligar o banco antigo)
- [ ] Timeout de transição definido (evitar dual-write eterno)

---

## 🛡️ Impacto de Dados no Blast Radius

### Dados são Especiais
Diferente de código (que pode ser revertido instantaneamente), **dados persistidos são difíceis de reverter**. Uma migração mal feita pode causar:

| Cenário de Falha | Impacto | Reversibilidade |
|---|---|---|
| **Dados corrompidos** | Dados inválidos persistidos que propagam erros | 🔴 Muito difícil — requer restore de backup |
| **Dados perdidos** | Registros deletados/sobrescritos sem backup | 🔴 Irreversível sem backup prévio |
| **Schema incompatível** | Código antigo não lê/escreve no schema novo | 🟡 Reversível com expand-contract |
| **Dados duplicados** | Registros criados pela v2 que não existem na v1 | 🟡 Tratável com cleanup job |
| **Constraint violada** | Migração falha no meio, dados parcialmente migrados | 🟠 Requer rollback manual + validação |

### Mitigações Obrigatórias

1. **Backup antes de qualquer migração** — snapshot do banco antes de iniciar
2. **Migração em lotes** — nunca migrar tudo de uma vez (batch + checkpoint)
3. **Validação pós-migração** — script que verifica integridade dos dados migrados
4. **Dry-run** — rodar a migração em modo "somente leitura" antes de executar de fato
5. **Migração com feature flag** — permitir abortar a migração sem rollback de código

---

## 🎙️ Perguntas por Nível de Staff Engineer

### L1 — Staff Engineer (Execução Segura)
1. *"A migração de schema é backward-compatible? O código antigo funciona com o schema novo?"*
2. *"Quanto tempo a migração leva em produção? Vocês testaram com o volume real de dados?"*
3. *"Existe backup do banco antes da migração? Qual é o RPO (Recovery Point Objective)?"*
4. *"Se a migração falhar no meio, o que acontece? Fica em estado inconsistente?"*
5. *"Campos novos têm default? O que acontece com registros existentes?"*

### L2 — Senior Staff Engineer (Resiliência Sistêmica)
1. *"A migração é idempotente? Se rodar duas vezes, o resultado é o mesmo?"*
2. *"Vocês estão usando expand-contract? Qual fase estamos e quando será o contract?"*
3. *"Se fizer rollback do código depois da migração de dados, os dados ficam consistentes?"*
4. *"Existe monitoramento de data integrity durante e após a migração?"*
5. *"O dual-write tem reconciliação? Como vocês detectam divergência entre os dois bancos?"*

### L3 — Principal Engineer (Visão Estratégica)
1. *"Essa migração é um evento único ou vai se repetir? Se repetir, está automatizada?"*
2. *"O padrão expand-contract está sendo seguido pela organização ou é ad-hoc por time?"*
3. *"Qual é o custo de manter dual-write? Por quanto tempo vai durar e qual é o plano de convergência?"*
4. *"Se precisarmos reverter essa migração em 30 dias (não 30 minutos), é possível?"*
5. *"O modelo de dados atual suporta as features do próximo quarter ou vamos precisar migrar de novo?"*

---

## ⚠️ Anti-Patterns Comuns

| Anti-Pattern | Problema | Correção |
|---|---|---|
| **ALTER TABLE em produção sem testar** | Lock de tabela, queries lentas, downtime | Testar migração com pt-online-schema-change ou similar |
| **DROP COLUMN no mesmo deploy** | Rollback impossível, código antigo quebra | Expand-contract: DROP só na fase CONTRACT |
| **Migração sem backup** | Sem rede de segurança se algo der errado | Snapshot obrigatório antes de iniciar |
| **Dual-write sem reconciliação** | Dados divergem silenciosamente | Job de reconciliação com alertas de divergência |
| **Migração big-bang** | Tudo ou nada — falha = estado inconsistente | Migração em lotes com checkpoint |
| **Constraint adicionada sem validar dados existentes** | Migração falha em prod mas passa em staging | Validar dados antes de adicionar constraint |
| **Dual-write eterno** | Complexidade permanente, custo dobrado | Definir deadline e plano de convergência |
