# Pilar 4 — Estratégia de Implantação

Referência detalhada para avaliação de estratégias de deploy, cálculo de blast radius, canary, blue/green, feature flags, SLOs e error budget durante rollout.

---

## 📋 Checklist de Estratégia de Implantação

### Estratégia de Rollout
- [ ] Estratégia de deploy definida (canary, blue/green, rolling, feature flag)
- [ ] **Blast radius inicial ≤ 5%** do tráfego total
- [ ] Estágios de promoção definidos com critérios claros (ex: 1% → 5% → 25% → 50% → 100%)
- [ ] Tempo de bake (observação) entre estágios documentado
- [ ] Plano de rollback documentado com tempo estimado de execução

### Feature Flags
- [ ] Funcionalidade nova está atrás de feature flag
- [ ] Feature flag pode ser desligada **sem deploy** (toggle em runtime)
- [ ] Feature flag suporta rollout gradual (% do tráfego)
- [ ] Feature flag tem owner definido e data de expiração (evitar flags eternas)
- [ ] Teste com flag ON e flag OFF rodou antes do deploy

### Rollback
- [ ] Rollback é **automatizável** (não requer intervenção humana complexa)
- [ ] Tempo de rollback estimado e documentado (ideal: < 5 min)
- [ ] Rollback foi **testado** em staging antes do deploy
- [ ] Dados criados pela versão nova são compatíveis com a versão anterior após rollback
- [ ] Runbook de rollback existe e está acessível ao time de on-call

---

## 📊 Comparativo de Estratégias de Deploy

| Estratégia | Blast Radius | Rollback Speed | Complexidade | Quando Usar |
|---|---|---|---|---|
| **Canary** | Controlado (1-5% → 100%) | Rápido (redirecionar tráfego) | Média | Default para serviços com tráfego significativo |
| **Blue/Green** | 50% ou 100% (switch) | Muito rápido (switch DNS/LB) | Média | Quando precisa de ambiente idêntico para comparação |
| **Rolling** | Gradual (por instância) | Médio (rollback por instância) | Baixa | Serviços stateless com auto-scaling |
| **Feature Flag** | Controlado (% de users) | Instantâneo (toggle) | Baixa-Média | Funcionalidades novas que precisam de kill switch |
| **Shadow/Dark Launch** | Zero (tráfego duplicado) | N/A (não afeta usuário) | Alta | Validar performance sem impacto |
| **Ring-based** | Controlado (ring 0 → ring N) | Rápido (parar promoção) | Alta | Organizações grandes com múltiplos estágios |

### Recomendação por cenário

| Cenário | Estratégia Recomendada |
|---|---|
| **Mudança em API com tráfego alto** | Canary + Feature Flag |
| **Migração de banco de dados** | Feature Flag (dual-write) + Canary |
| **Nova funcionalidade de UI** | Feature Flag com rollout gradual |
| **Mudança de infraestrutura** | Blue/Green com smoke test |
| **Refactoring interno sem mudança de contrato** | Rolling com canary mínimo |

---

## 🎯 Cálculo de Blast Radius

### Fórmula básica
```
Blast Radius = % Tráfego na Nova Versão × Probabilidade de Falha × Impacto por Falha
```

### Níveis de Blast Radius

| Nível | % Tráfego | Público Impactado | Aceitabilidade |
|---|---|---|---|
| 🟢 **Mínimo** | 1-5% | Centenas a poucos milhares | Ideal para início de rollout |
| 🟡 **Controlado** | 5-25% | Milhares a dezenas de milhares | Aceitável com monitoramento ativo |
| 🟠 **Elevado** | 25-50% | Dezenas de milhares a milhões | Requer SLOs validados e auto-rollback |
| 🔴 **Total** | 50-100% | Toda a base | **INACEITÁVEL** sem canary prévio |

### Critérios de promoção entre estágios

| Critério | Threshold | Ação se Violado |
|---|---|---|
| Error rate (v2 vs v1) | ≤ v1 + 0.1% | Pausar rollout |
| Latência p99 (v2 vs v1) | ≤ v1 + 20% | Pausar rollout |
| SLO burn rate | ≤ 3x normal | Pausar rollout |
| Exceptions novas | = 0 | Investigar antes de promover |
| Alertas disparados | = 0 | Investigar antes de promover |

---

## 📈 SLOs e Error Budget Durante Rollout

### Definições

| Conceito | Definição | Exemplo |
|---|---|---|
| **SLI** (Service Level Indicator) | Métrica que mede a qualidade do serviço | % de requests com latência < 200ms |
| **SLO** (Service Level Objective) | Alvo para o SLI | 99.9% das requests com latência < 200ms |
| **Error Budget** | Margem de erro permitida (100% - SLO) | 0.1% = ~43 min de downtime/mês |
| **Burn Rate** | Velocidade de consumo do error budget | 10x = consumindo 10x mais rápido que o sustentável |

### Checklist de SLOs para Rollout
- [ ] SLIs definidos para os endpoints críticos
- [ ] SLOs definidos com targets numéricos
- [ ] Error budget calculado para o período de rollout
- [ ] **Burn rate sendo monitorado em tempo real** durante o rollout
- [ ] Threshold de burn rate definido para auto-rollback (ex: > 10x)
- [ ] Dashboard de SLO/burn rate incluído no dashboard de rollout
- [ ] Time de produto alinhado sobre o error budget disponível

### Error Budget Guard Rails

| Burn Rate | Severidade | Ação |
|---|---|---|
| **1x** | Normal | Rollout pode prosseguir |
| **2-5x** | Atenção | Monitorar de perto, considerar pausar |
| **5-10x** | Alerta | Pausar rollout, investigar |
| **> 10x** | Crítico | **Rollback imediato** |
| **Budget esgotado** | Bloqueio | **Nenhum deploy até budget renovar** |

---

## 🎙️ Perguntas por Nível de Staff Engineer

### L1 — Staff Engineer (Execução Segura)
1. *"Qual é o plano de rollback? Em quanto tempo vocês conseguem reverter?"*
2. *"O rollback foi testado em staging? Funciona com as migrações de dados?"*
3. *"Existe feature flag? Consigo desligar a funcionalidade sem deploy?"*
4. *"Qual é o primeiro estágio do canary? Quanto tráfego vai para a versão nova?"*
5. *"Quem aprova a promoção do canary? É automático ou manual?"*

### L2 — Senior Staff Engineer (Resiliência Sistêmica)
1. *"Qual é o blast radius no primeiro estágio? E se a falha for silenciosa (não gera erro, mas dados corrompidos)?"*
2. *"Os critérios de promoção do canary são baseados em métricas ou em tempo? Me mostra os thresholds."*
3. *"Se o canary degradar um SLO que é compartilhado com outros serviços, vocês detectam?"*
4. *"O rollout é por região/AZ ou global? Se for global, uma falha impacta todas as regiões simultaneamente?"*
5. *"Existe automatic rollback? Quais métricas disparam e com qual latência de detecção?"*

### L3 — Principal Engineer (Visão Estratégica)
1. *"O error budget está dimensionado para a cadência de deploys da equipe? Quantos deploys por mês cabem nesse budget?"*
2. *"A estratégia de deploy é padronizada na organização ou cada time faz do seu jeito?"*
3. *"Feature flags estão sendo gerenciadas? Existe governança para evitar acúmulo de flags mortas?"*
4. *"Se amanhã precisarmos fazer 3 deploys de emergência em sequência, o pipeline suporta?"*
5. *"O custo operacional dessa estratégia de deploy (infra duplicada, canary, feature flags) está justificado pelo risco que mitiga?"*

---

## ⚠️ Anti-Patterns Comuns

| Anti-Pattern | Problema | Correção |
|---|---|---|
| **Deploy 100% de uma vez** | Blast radius total, qualquer bug impacta todos | Canary com estágios progressivos |
| **Canary sem métricas** | Canary de "fachada" — está lá mas ninguém olha | Critérios de promoção baseados em métricas |
| **Rollback que nunca foi testado** | Na hora do incidente, rollback falha | Testar rollback em staging regularmente |
| **Feature flag sem expiração** | Código cheio de flags mortas, complexidade cresce | Owner + data de expiração em toda flag |
| **Error budget sem enforcement** | SLO existe no papel mas deploy continua mesmo com budget esgotado | Freeze de deploys quando budget acaba |
| **Bake time de 0 minutos** | Promove canary imediatamente, sem observar | Mínimo 15 min de bake por estágio |
| **Rollout manual sem runbook** | Cada deploy é um procedimento diferente | Runbook padronizado e automatizado |
