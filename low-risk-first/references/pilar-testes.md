# Pilar 2 — Testes

Referência detalhada para avaliação da estratégia de testes pré-rollout, incluindo testes sintéticos de carga fria, testes de contrato, chaos engineering e smoke tests.

---

## 📋 Checklist de Testes Pré-Rollout

### Testes Sintéticos (Carga Fria)
- [ ] Existe pipeline de testes sintéticos que simula tráfego real antes do rollout
- [ ] Testes simulam cenários de **cold start** (caches vazios, connection pools novos, JIT não aquecido)
- [ ] Volume de testes é proporcional ao tráfego esperado (mín. 10% do pico)
- [ ] Testes são executados no **ambiente de produção** (staging não replica fielmente prod)
- [ ] Resultados dos testes sintéticos são gate para promoção do canary

### Testes de Contrato
- [ ] Contratos entre serviços estão definidos (OpenAPI, Protobuf, Pact)
- [ ] Testes de contrato rodam no CI/CD antes de qualquer deploy
- [ ] Mudanças de contrato são backward-compatible (campo novo = opcional)
- [ ] Existe versionamento de API para breaking changes inevitáveis

### Smoke Tests Pós-Deploy
- [ ] Smoke tests automatizados rodam imediatamente após cada deploy
- [ ] Cobrem os **happy paths** críticos (cadastro, login, operação principal)
- [ ] Timeout de smoke test é curto (< 2 min) para não atrasar rollout
- [ ] Falha no smoke test dispara **rollback automático**

### Testes de Integração
- [ ] Testes de integração cobrem as dependências reais (não mocks)
- [ ] Ambiente de testes de integração é representativo (dados, latência, configs)
- [ ] Testes de integração rodam em paralelo com tempo total < 10 min

---

## 🔬 Chaos Engineering

### Princípios
1. **Comece em staging** — só vá para prod quando o time estiver maduro
2. **Blast radius controlado** — nunca injete falha em 100% do tráfego
3. **Hipótese antes do experimento** — *"Acreditamos que o sistema vai [X] quando [Y] falhar"*
4. **Abort condition** — critério claro para abortar o experimento

### Tipos de Experimentos

| Tipo | O que simula | Ferramentas |
|---|---|---|
| **Fault Injection** | Serviço downstream retorna erro 500 | Istio fault injection, Gremlin, Chaos Monkey |
| **Latency Injection** | Serviço downstream fica lento (ex: +2s) | Toxiproxy, Istio delay injection |
| **Resource Exhaustion** | CPU, memória ou disco esgotam | Stress-ng, Chaos Toolkit |
| **Network Partition** | Perda de conectividade entre componentes | iptables rules, Chaos Mesh |
| **Dependency Kill** | Serviço externo fica completamente indisponível | Kill container, DNS blackhole |
| **Clock Skew** | Relógio do servidor avança ou atrasa | chrony manipulation, Chaos Toolkit |

### Checklist de Chaos Engineering
- [ ] Time tem experiência com chaos engineering (pelo menos 1 experimento executado)
- [ ] Experimentos documentados com hipótese, procedimento e resultados
- [ ] Existe runbook para cada falha simulada
- [ ] Resultados alimentam melhorias de resiliência

---

## 📊 Estratégia de Testes por Estágio de Rollout

| Estágio | % Tráfego | Testes Obrigatórios | Duração Mínima |
|---|---|---|---|
| **Pré-deploy** | 0% | Unitários, contrato, integração | CI/CD |
| **Staging** | Sintético | Smoke, carga fria, chaos (básico) | 30 min |
| **Canary** | 1-5% | Smoke pós-deploy, monitoramento de métricas | 15-30 min |
| **Rollout parcial** | 5-25% | Validação de SLOs, comparação A/B de métricas | 1-4 horas |
| **Rollout amplo** | 25-50% | Monitoramento contínuo, validação de error budget | 4-24 horas |
| **Full rollout** | 100% | Monitoramento por 72h, post-deploy review | 72 horas |

### Critérios de promoção entre estágios
- **Error rate** da nova versão ≤ error rate da versão anterior + margem (ex: +0.1%)
- **Latência p99** da nova versão ≤ latência p99 da versão anterior + margem (ex: +50ms)
- **Nenhum alerta** disparado nos dashboards de rollout
- **Zero** exceptions novas não mapeadas

---

## 🎙️ Perguntas por Nível de Staff Engineer

### L1 — Staff Engineer (Execução Segura)
1. *"Quais testes rodam antes do deploy ir para produção? Me mostra o pipeline."*
2. *"O smoke test cobre o happy path principal? Se ele falhar, o rollback é automático?"*
3. *"Vocês testaram o cenário de cold start? Qual é o warmup time?"*
4. *"Os testes de integração usam mocks ou dependências reais?"*
5. *"Quanto tempo leva para rodar a suite completa de testes? Está bloqueando o pipeline?"*

### L2 — Senior Staff Engineer (Resiliência Sistêmica)
1. *"Vocês já fizeram injeção de falha nesse serviço? O que aconteceu quando o [dependência X] retornou 500?"*
2. *"Os testes sintéticos simulam o tráfego real ou são simplificados? Qual a fidelidade?"*
3. *"Se o canary mostrar degradação em uma métrica mas melhora em outra, qual é o critério de decisão?"*
4. *"Existe teste para o cenário de rollback? Vocês testam que o rollback funciona?"*
5. *"Qual é o tempo máximo entre o deploy do canary e a detecção de um problema? O bake time é suficiente?"*

### L3 — Principal Engineer (Visão Estratégica)
1. *"A estratégia de testes escala com o número de microserviços? Ou cada novo serviço precisa reinventar o pipeline?"*
2. *"Qual é o custo de manter esse ambiente de staging? É proporcional ao valor que entrega?"*
3. *"Os testes de contrato estão centralizados ou cada time define o seu? Existe governança?"*
4. *"Vocês medem a eficácia dos testes (bugs que passaram vs. bugs pegos)? O investimento em testes está calibrado?"*
5. *"Se a cadência de deploys aumentar 5x, essa estratégia de testes aguenta sem ser gargalo?"*

---

## ⚠️ Anti-Patterns Comuns

| Anti-Pattern | Problema | Correção |
|---|---|---|
| **Staging como substituto de prod** | Staging nunca reproduz fielmente prod (dados, escala, configs) | Testes sintéticos em prod com blast radius controlado |
| **Smoke test manual** | Humano esquece passos, demora, não é reproduzível | Automatizar 100% dos smoke tests |
| **Testes só no happy path** | Falhas acontecem nos edge cases | Adicionar testes de erro, timeout, dados inválidos |
| **Chaos engineering ad-hoc** | Experimentos sem hipótese não geram aprendizado | Framework com hipótese → experimento → resultado → ação |
| **Pipeline de testes > 30 min** | Desenvolvedores fazem skip ou merge sem esperar | Paralelizar, priorizar, separar fast tests de slow tests |
| **Mock de tudo** | Testes passam mas integração falha em prod | Testes de contrato + integração com deps reais |
