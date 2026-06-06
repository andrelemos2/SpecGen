---
name: ng-sdd
version: 2.2.0
author: André Lemos
license: CC-BY-4.0
description: >
  Next Gen Spec-Driven Development (ng-sdd) v2.2. Framework enterprise de Spec-Driven
  Development com arquitetura modular, GitFlow integrado, lazy loading de fases,
  suporte a PRD, Research, Greenfield, Brownfield e modo adaptativo.
argument-hint: "[comando]"
model: sonnet
subagent: false
allowed-tools:
  - read
  - edit
  - grep
  - glob
  - exec
permissions:
  allow:
    - Exec(git)
    - Write(**)
triggers:
  - user
  - model
custom-commands:
  - /ngsdd:init
  - /ngsdd:research
  - /ngsdd:specify
  - /ngsdd:design
  - /ngsdd:tasks
  - /ngsdd:execute
  - /ngsdd:archive
  - /ngsdd:status
  - "ng-sdd"
  - "iniciar projeto sdd"
  - "propor feature com spec"
---

# 📐 ng-sdd v2.2 — Next Gen Spec-Driven Development

> **Premissa fundamental:** A especificação é a fonte da verdade. O código é consequência dela.
> Nenhuma linha de código é escrita sem uma spec aprovada.

---

## ⚡ Modo Adaptativo

Antes de iniciar, avalie a complexidade e declare o caminho:

```
Quick Path → INIT → SPECIFY → EXECUTE → ARCHIVE
Full Path  → INIT → RESEARCH → SPECIFY → DESIGN → TASKS → EXECUTE → ARCHIVE
```

**Quick Path** se TODOS os critérios abaixo forem verdadeiros:
- ≤ 3 arquivos afetados
- Sem novas dependências ou APIs externas
- Sem mudança de contrato público (interface, schema, API)
- Estimativa ≤ 2 horas

Caso contrário: **Full Path**.

> Sempre declare: "📍 Modo: **Quick Path** — pulando RESEARCH, DESIGN e TASKS."

---

## 🗂️ Roteamento de Comandos (Lazy Loading)

Ao receber um comando, leia **apenas** o arquivo da fase correspondente:

| Comando           | Arquivo a carregar                                    |
|-------------------|-------------------------------------------------------|
| `/ngsdd:init`     | `phases/00-init.md`                                   |
| `/ngsdd:research` | `phases/01-research.md` (Delega para subagente `ng-sdd-research`) |
| `/ngsdd:specify`  | `phases/02-specify.md` + `templates/spec.md`          |
| `/ngsdd:design`   | `phases/03-design.md` + `templates/design.md` + `templates/delta.md` |
| `/ngsdd:tasks`    | `phases/04-tasks.md` + `templates/tasks.md`           |
| `/ngsdd:execute`  | `phases/05-execute.md` (Delega para subagente `ng-sdd-execute`) |
| `/ngsdd:archive`  | `phases/06-archive.md` + `templates/quality-gate.md`  |
| `/ngsdd:status`   | `.sdd/foundation/STATE.md` + listar `.sdd/specs/`     |

> **Nunca** carregue todos os arquivos de uma vez. Carregue somente o necessário para a fase atual.
> **Nota de Orquestração:** Nas fases `research` e `execute`, o orquestrador principal delega o trabalho pesado para as skills subagentes correspondentes.

---

## 📖 Referências

- Princípios fundamentais: `principles.md`
- Integração GitFlow: `workflows/gitflow.md`
- Templates de artefatos: `templates/`
- Detalhes de cada fase: `phases/`
