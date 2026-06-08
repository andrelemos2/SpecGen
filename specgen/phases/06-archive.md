# Fase 6 — ARCHIVE: Quality Gate e Encerramento

> **Owner:** Tech Lead da feature
> **Comando:** `/specgen:archive`
> **Sempre obrigatória** — Quick Path e Full Path.

---

## Objetivo

Garantir que a feature está completa, conforme a spec, e fechar o ciclo de desenvolvimento.
Nada é concluído sem passar pelo Quality Gate.

---

## Passo 1 — Quality Gate Final

Execute o checklist completo. **Qualquer item reprovado bloqueia o archive.**

### Conformidade com a Spec
- [ ] Todos os Requisitos Funcionais (RF) do `spec.md` foram implementados?
- [ ] Todos os Requisitos Não-Funcionais (RNF) foram verificados?
- [ ] Todos os cenários BDD (Gherkin) passaram nos testes?
- [ ] Houve scope creep? (algo implementado que não estava no `spec.md`?)

### Conformidade com o Delta
- [ ] Todos os arquivos do `delta.md` foram criados/modificados/removidos?
- [ ] Nenhum arquivo "surpresa" foi criado fora do `delta.md`?

### Qualidade de Código
- [ ] O código está conforme o `CONSTITUTION.md`?
- [ ] A cobertura de testes atinge o mínimo definido (ex: 80%)?
- [ ] O linter passa sem erros?
- [ ] Não há `TODO` ou `FIXME` introduzidos pela feature?



---

## Passo 2 — Gerar quality-gate.md

Copie `templates/quality-gate.md` para `.sdd/specs/[slug]/quality-gate.md` e preencha:

```markdown
# Quality Gate Report: [Feature Name]

**ID:** FEAT-[NNN]
**Data:** YYYY-MM-DD
**Revisado por:** [Tech Lead]
**Status:** ✅ APPROVED | ❌ FAILED

## Checklist

### Spec
- [x] RF-01: implementado ✅
- [x] RF-02: implementado ✅
- [x] RNF-01 (Performance < 200ms): verificado ✅
- [x] BDD cenários: todos passando ✅
- [x] Sem scope creep ✅

### Delta
- [x] Todos os arquivos ADDED criados ✅
- [x] Todos os arquivos MODIFIED atualizados ✅
- [x] Nenhum arquivo fora do delta ✅

### Qualidade
- [x] CONSTITUTION.md respeitada ✅
- [x] Cobertura: 87% (mínimo: 80%) ✅
- [x] Linter: 0 erros ✅
- [x] CI/CD: passou ✅

## Cobertura de Testes
| Tipo | Cobertura |
|------|-----------|
| Unitários | 87% |
| Integração | 73% |

## Dívida Técnica Gerada
- Nenhuma | [ou liste itens]

## Observações
> [Notas relevantes para o time, decisões tomadas, contexto para próximas features]
```



---

## Passo 4 — Mover para archive

```bash
# No workspace .sdd/
mv .sdd/specs/[feature-slug]/ .sdd/archive/[feature-slug]/
```

---

## Passo 5 — Atualizar STATE.md

Adicione ao `.sdd/foundation/STATE.md`:

```markdown
## [YYYY-MM-DD] ✅ FEAT-[NNN]: [Feature Name] — CONCLUÍDA

- **Cobertura:** 87%
- **Decisões tomadas:** [decisões arquiteturais relevantes para o futuro]
- **Dívida técnica gerada:** [nenhuma | lista de itens]
- **Próximos passos relacionados:** [features futuras que dependem desta]
```

---

## Passo 6 — Comunicar conclusão

Informe ao usuário:

```
✅ Feature [FEAT-NNN: nome] arquivada com sucesso.
📁 Spec movida para .sdd/archive/[slug]/
📋 STATE.md atualizado.

Próximo comando disponível:
  → /specgen:specify [próxima-feature]  (nova feature)
  → /specgen:status                     (ver estado do projeto)
```
