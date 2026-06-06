# Template: Tasks (Task Board Atômico)

> Copie para `.sdd/specs/[feature-slug]/tasks.md`
> Owner: Tech Lead / Engenheiro responsável pela feature

---

# Tasks: [Feature Name]

**ID:** FEAT-[NNN]
**Branch:** feature/FEAT-[NNN]-[slug]
**Data:** YYYY-MM-DD

## Regras do Task Board

- ⏱️ Cada tarefa deve ter duração estimada de **2-5 minutos**
- ✅ Cada tarefa tem critério de aceite **objetivo e verificável**
- 🔗 Dependências são **explícitas**, nunca implícitas
- 🚫 Nenhum arquivo criado que não esteja no `delta.md`
- 🔴 Testes são escritos **antes** da implementação (TDD)

## Status

| Símbolo | Significado |
|---------|------------|
| TODO | Não iniciado |
| 🟡 IN PROGRESS | Em execução |
| ✅ DONE | Concluído |
| 🔴 BLOCKED | Bloqueado (documente o motivo) |

---

## Matriz de Sub-Agentes

| Role | Responsabilidade |
|------|-----------------|
| Backend | Services, repositories, controllers, DTOs |
| Frontend | Components, pages, hooks, stores |
| QA | Testes unitários, integração e e2e |
| Infra | Migrations, configs, CI/CD |

---

## [PARALELO] Grupo 1 — Executar simultaneamente

### TASK-001 — [Descrição da tarefa]
- **Role:** Backend | Frontend | QA | Infra
- **Arquivo(s):** `src/[caminho]/[arquivo]`
- **Critério de aceite:** [condição verificável e objetiva]
- **Estimativa:** ~[N] min
- **Status:** TODO
- **Commit:** —

---

### TASK-002 — Criar testes (TDD — fase RED)
- **Role:** QA
- **Arquivo(s):** `tests/[feature]/[feature].spec.ts`
- **Critério de aceite:** Testes escritos descrevendo o comportamento esperado; todos falhando (RED)
- **Estimativa:** ~3 min
- **Status:** TODO
- **Commit:** —

---

### TASK-003 — [Outra tarefa paralela]
- **Role:** Infra
- **Arquivo(s):** `migrations/[TIMESTAMP]-[nome].ts`
- **Critério de aceite:** Migration executa sem erros em ambiente de dev
- **Estimativa:** ~2 min
- **Status:** TODO
- **Commit:** —

---

## [SEQUENCIAL] Grupo 2 — Após Grupo 1 completo

### TASK-004 — [Tarefa que depende do Grupo 1]
- **Role:** Backend
- **Depende de:** TASK-001, TASK-003
- **Arquivo(s):** `src/[caminho]/[arquivo]`
- **Critério de aceite:** [condição verificável]
- **Estimativa:** ~3 min
- **Status:** TODO
- **Commit:** —

---

## [SEQUENCIAL] Grupo 3 — Após Grupo 2 completo

### TASK-005 — Testes passando (TDD — fase GREEN)
- **Role:** QA
- **Depende de:** TASK-004
- **Arquivo(s):** `tests/[feature]/[feature].spec.ts`
- **Critério de aceite:** Todos os cenários BDD do `spec.md` passando (GREEN)
- **Estimativa:** ~2 min
- **Status:** TODO
- **Commit:** —

### TASK-006 — Refactor e cobertura final
- **Role:** Backend + QA
- **Depende de:** TASK-005
- **Critério de aceite:** Cobertura ≥ 80%, linter sem erros, código conforme CONSTITUTION.md
- **Estimativa:** ~5 min
- **Status:** TODO
- **Commit:** —
