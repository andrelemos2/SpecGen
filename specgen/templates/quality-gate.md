# Template: Quality Gate Report

> Copie para `.sdd/specs/[feature-slug]/quality-gate.md` (ou `.sdd/archive/`)
> Owner: Tech Lead — preenchido na fase ARCHIVE

---

# Quality Gate Report: [Feature Name]

**ID:** FEAT-[NNN]
**Data de revisão:** YYYY-MM-DD
**Revisado por:** [Nome do Tech Lead]
**Status:** ✅ APPROVED | ❌ FAILED | ⚠️ APPROVED WITH DEBT

---

## 1. Conformidade com a Spec

| Item | Status | Observação |
|------|--------|-----------|
| RF-01: [descrição] | ✅ / ❌ | |
| RF-02: [descrição] | ✅ / ❌ | |
| RNF-01 (Performance): [descrição] | ✅ / ❌ | |
| RNF-02 (Segurança): [descrição] | ✅ / ❌ | |
| BDD — Happy Path | ✅ / ❌ | |
| BDD — Edge cases | ✅ / ❌ | |
| BDD — Cenários de erro | ✅ / ❌ | |
| Sem scope creep | ✅ / ❌ | |

---

## 2. Conformidade com o Delta

| Item | Status | Observação |
|------|--------|-----------|
| Todos os ADDED criados | ✅ / ❌ | |
| Todos os MODIFIED atualizados | ✅ / ❌ | |
| Todos os REMOVED deletados | ✅ / ❌ | |
| Nenhum arquivo fora do delta | ✅ / ❌ | |

---

## 3. Qualidade de Código

| Item | Resultado | Threshold | Status |
|------|-----------|-----------|--------|
| Cobertura unitária | [X%] | ≥ 80% | ✅ / ❌ |
| Cobertura integração | [X%] | ≥ 60% | ✅ / ❌ |
| Linter | [0 erros] | 0 erros | ✅ / ❌ |
| Build | [sucesso] | sucesso | ✅ / ❌ |
| CI/CD pipeline | [passou] | passou | ✅ / ❌ |
| CONSTITUTION.md | [conforme] | conforme | ✅ / ❌ |

---

## 4. Dívida Técnica Gerada

> Liste qualquer dívida técnica **introduzida** por esta feature.
> Dívida não registrada aqui não será endereçada no futuro.

| Item | Tipo | Impacto | Issue criada |
|------|------|---------|-------------|
| [ex: Mock temporário em FeatureService] | Technical | Baixo | #[número] |

---

## 5. Observações e Decisões

> Notas relevantes para o time. Decisões arquiteturais tomadas durante a execução.
> Contexto importante para features futuras que dependem desta.

[Texto livre]

---

## 6. Próximos Passos

> Features ou tasks que surgiram durante esta implementação e devem ser planejadas.

- [ ] [próxima feature ou melhoria identificada]
