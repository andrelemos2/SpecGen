# Template: Spec (Source of Truth)

> Copie para `.sdd/specs/[feature-slug]/spec.md`
> Owner: Tech Lead / Product Engineer da feature

---

# Spec: [Feature Name]

**ID:** FEAT-[NNN]
**Slug:** [feature-slug]
**Tipo:** Feature | Bugfix | Refactor | Spike
**Path:** Full Path | Quick Path
**Branch:** feature/FEAT-[NNN]-[feature-slug]
**Data:** YYYY-MM-DD
**Autor:** [Nome]
**Status:** DRAFT | REVIEWING | APPROVED | EXECUTING | DONE

---

## Contexto

> Por que essa feature existe? Qual problema ela resolve?
> Referencie o PRD e/ou a User Story de origem.

[2-3 parágrafos de contexto]

---

## User Stories / Jobs-to-be-done

- Como **[persona]**, quero **[ação]** para que **[valor obtido]**.
- Como **[persona]**, quero **[ação]** para que **[valor obtido]**.

---

## Requisitos Funcionais (RF)

> Cada RF deve ser testável, específico e verificável.

- [ ] RF-01: [Descrição exata e testável]
- [ ] RF-02: [Descrição exata e testável]
- [ ] RF-03: [Descrição exata e testável]

---

## Requisitos Não-Funcionais (RNF)

- [ ] RNF-01 **(Performance):** [ex: Endpoint deve responder em < 200ms no p95]
- [ ] RNF-02 **(Segurança):** [ex: Dados sensíveis devem ser criptografados em repouso]
- [ ] RNF-03 **(Escalabilidade):** [ex: Suportar até 10k req/min sem degradação]
- [ ] RNF-04 **(Disponibilidade):** [ex: SLA de 99.9% — max 8.7h downtime/ano]

---

## Critérios de Aceite (Gherkin/BDD)

```gherkin
Scenario: [Cenário principal — Happy Path]
  Given [contexto inicial]
  When [ação do usuário ou sistema]
  Then [resultado esperado]
  And [resultado adicional]

Scenario: [Edge case 1]
  Given [contexto alternativo]
  When [ação]
  Then [resultado]

Scenario: [Cenário de erro]
  Given [contexto de falha]
  When [ação que causa erro]
  Then [erro retornado com código e mensagem corretos]
```

---

## Fora do Escopo (Explícito)

> Seja específico — isso previne scope creep e discussões desnecessárias.

- ❌ Não será implementado nesta feature: [item 1]
- ❌ Não será implementado nesta feature: [item 2]

---

## Dependências

| Tipo | Dependência | Status |
|------|------------|--------|
| Feature interna | [FEAT-NNN] | ✅ Concluída / ⏳ Em progresso |
| API externa | [Nome da API] | ✅ Disponível / ⚠️ Pendente contrato |
| Infraestrutura | [ex: Redis cluster] | ✅ Disponível |

---

## Riscos Conhecidos

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|---------|-----------|
| [Risco 1] | Alta/Média/Baixa | Alto/Médio/Baixo | [como mitigar] |
| [Risco 2] | Alta/Média/Baixa | Alto/Médio/Baixo | [como mitigar] |
