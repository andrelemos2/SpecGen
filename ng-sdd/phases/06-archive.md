# Fase 6 — ARCHIVE: Quality Gate e Encerramento

> **Owner:** Tech Lead da feature
> **Comando:** `/ngsdd:archive`
> **Sempre obrigatória** — Quick Path e Full Path.

---

## Objetivo

Garantir que a feature está completa, conforme a spec, e fechar o ciclo no GitFlow.
Nada vai para `develop` sem passar pelo Quality Gate.

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

### GitFlow
- [ ] Todos os commits usam Conventional Commits?
- [ ] A branch está em dia com `develop` (rebase feito)?
- [ ] O build/pipeline de CI passa?

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

## Passo 3 — Feature Finish (GitFlow)

```bash
# Garanta que está na branch da feature
git checkout feature/FEAT-NNN-[slug]

# Merge da feature para develop via GitFlow
git flow feature finish FEAT-NNN-[slug]

# Isso automaticamente:
# 1. Faz merge de feature/FEAT-NNN-[slug] → develop
# 2. Deleta a branch de feature local
# 3. Retorna para develop

# Publique o develop atualizado
git push origin develop

# Limpe a branch remota se existir
git push origin --delete feature/FEAT-NNN-[slug]
```

> **Para hotfixes (Quick Path com `git flow hotfix`):** use `git flow hotfix finish [slug]`.
> Isso faz merge em `develop` E em `main`, e cria uma tag de versão automaticamente.
> Leia `workflows/gitflow.md` para o fluxo completo de hotfix e release.

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

- **Branch:** feature/FEAT-NNN-[slug] → develop
- **Merge:** YYYY-MM-DD
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

📦 Branch feature/FEAT-NNN-[slug] mergeada em develop e deletada.
📁 Spec movida para .sdd/archive/[slug]/
📋 STATE.md atualizado.

Próximo comando disponível:
  → /ngsdd:specify [próxima-feature]  (nova feature)
  → /ngsdd:status                     (ver estado do projeto)
```
