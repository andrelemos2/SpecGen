# Fase 4 — TASKS: Decomposição Atômica

> **Owner:** Tech Lead / Engenheiro responsável pela feature
> **Comando:** `/specgen:tasks`
> **Opcional no Quick Path** — Obrigatória no Full Path.

---

## Objetivo

Quebrar o design aprovado em tarefas executáveis de **2-5 minutos** cada.
O task board é o contrato de execução — define quem faz o quê, em qual ordem.

---

## Passo 1 — Criar tasks.md

Copie `templates/tasks.md` para `.sdd/specs/[feature-slug]/tasks.md`.

---

## Passo 2 — Regras de Decomposição

Uma boa tarefa:
- ✅ Tem um critério de aceite verificável e objetivo
- ✅ Pode ser concluída em 2-5 minutos
- ✅ Tem um único responsável (sub-agente ou developer)
- ✅ Produz um artefato testável (arquivo, função, endpoint)
- ❌ Não é vaga: "implementar autenticação" → **ruim**
- ❌ Não é grande demais: quebrar sempre que ultrapassar 5 minutos

---

## Passo 3 — Matriz de Sub-Agentes

Antes de criar as tarefas, defina quem é responsável por cada tipo:

| Role      | Responsabilidade                          | Branch de trabalho |
|-----------|-------------------------------------------|--------------------|
| Backend   | Services, repositories, controllers, DTOs | `feature/FEAT-NNN-*` |
| Frontend  | Components, pages, state, hooks            | `feature/FEAT-NNN-*` |
| QA        | Testes unitários e de integração           | `feature/FEAT-NNN-*` |
| Infra     | Migrations, configurações, CI/CD scripts   | `feature/FEAT-NNN-*` |

> Todos os roles trabalham **na mesma branch** da feature. A separação é lógica, não de branch.

---

## Passo 4 — Identificar Paralelismo

Analise o `delta.md` e classifique cada tarefa:

**PARALELO:** Tarefas sem dependência entre si (podem rodar simultaneamente)
**SEQUENCIAL:** Tarefas que dependem do resultado de outra

```markdown
## [PARALELO] Grupo 1 — Executar simultaneamente

### TASK-001 — Criar FeatureXService
- **Role:** Backend
- **Arquivo:** `src/modules/feature-x/feature-x.service.ts`
- **Critério:** Método `execute(dto)` retorna `FeatureXEntity` conforme RF-01
- **Status:** TODO

### TASK-002 — Criar testes unitários (TDD - fase RED)
- **Role:** QA
- **Arquivo:** `tests/feature-x/feature-x.service.spec.ts`
- **Critério:** Testes escritos e falhando (RED) antes de qualquer implementação
- **Status:** TODO

### TASK-003 — Criar migration de banco
- **Role:** Infra
- **Arquivo:** `migrations/YYYYMMDDHHMMSS-create-feature-x.ts`
- **Critério:** Migration executa sem erros em ambiente de dev
- **Status:** TODO

---

## [SEQUENCIAL] Grupo 2 — Após Grupo 1 completo

### TASK-004 — Criar FeatureXController
- **Role:** Backend
- **Depende de:** TASK-001 (FeatureXService deve existir)
- **Arquivo:** `src/modules/feature-x/feature-x.controller.ts`
- **Critério:** Endpoint POST /feature-x retorna 201 com payload correto
- **Status:** TODO

### TASK-005 — Registrar módulo na aplicação
- **Role:** Backend
- **Depende de:** TASK-004 (Controller deve existir)
- **Arquivo:** `src/app.module.ts`
- **Critério:** Aplicação inicializa sem erros com novo módulo registrado
- **Status:** TODO

---

## [SEQUENCIAL] Grupo 3 — Após Grupo 2 completo

### TASK-006 — Testes de integração (TDD - fase GREEN)
- **Role:** QA
- **Depende de:** TASK-004, TASK-005
- **Arquivo:** `tests/feature-x/feature-x.e2e.spec.ts`
- **Critério:** Todos os cenários BDD do spec.md passam
- **Status:** TODO
```

---

## Passo 5 — Gate de Aprovação ✋

> Apresente o task board ao usuário.
> **Não inicie execução sem aprovação explícita.**
>
> Checklist:
> - [ ] Cada tarefa tem critério de aceite objetivo?
> - [ ] Nenhuma tarefa excede 5 minutos estimados?
> - [ ] Grupos PARALELO e SEQUENCIAL estão corretos?
> - [ ] Todos os arquivos do `delta.md` têm uma tarefa correspondente?
> - [ ] Todos os cenários BDD do `spec.md` têm uma tarefa de teste correspondente?
>
> Após aprovação, atualize status da spec para `EXECUTING`.
> Inicie a execução com `/specgen:execute`.
