---
name: ng-sdd
description: "A melhor metodologia Spec-Driven para desenvolvimento assistido por IA. Foco extremo em redução de tokens, aprendizado contínuo (auto-correção e sugestões de regras via PRs), arquitetura modular (Bounded Contexts) e paralelização de subagentes. Composta por 5 fases adaptativas: Especificar, Design, Tarefas, Executar e Refletir. Use sempre que iniciar projetos, criar funcionalidades complexas ou aplicar correções guiadas. Otimizada para não \"poluir\" o contexto."
license: CC-BY-4.0
metadata:
  author: Andre Lemos
  version: 1.0.0
argument-hint: "[feature-name | codebase-mapping | bug-fix]"
model: sonnet
allowed-tools:
  - read
  - write
  - exec
  - grep
  - glob
permissions:
  allow:
    - Read(**/.specs/**)
    - Write(**/.specs/**)
    - Read(**/src/**)
    - Write(**/src/**)
---

# Next-Gen Spec-Driven Development (NG-SDD)

Desenvolvimento impecável por especificações. Custo mínimo de tokens. Arquitetura isolada. Aprendizado dinâmico.

```
┌─────────────┐   ┌────────────┐   ┌───────────┐   ┌────────────┐   ┌────────────┐
│ ESPECIFICAR │ → │   DESIGN   │ → │  TAREFAS  │ → │  EXECUTAR  │ → │  REFLETIR  │
└─────────────┘   └────────────┘   └───────────┘   └────────────┘   └────────────┘
  (Obrigatório)     (Opcional)      (Opcional)     (Obrigatório)    (Obrigatório)
```

## O Paradigma "Token-Efficient" & Context-On-Demand

Nesta versão, tokens são sagrados. O agente **NUNCA** lerá arquivos de especificações de outras tarefas, nem carregará todo o `ROADMAP.md` ou histórico de PRs sem necessidade.
Para entender as estritas regras de gestão de contexto e isolamento de subagentes, leia [context-management.md](references/context-management.md).

## Aprendizado Contínuo & Feedback Loop

A IA aprende com o projeto.
1. **Reflect & Fix:** Ao gerar código ruim ou errar a tipagem, a IA é proibida de aplicar a correção silenciosamente. Ela reportará explicitamente o que errou, a regra violada e a solução adotada.
2. **Revisões Humanas:** Quando o humano reportar feedbacks de PRs ("O revisor pediu para usar X ao invés de Y"), a IA aplicará a alteração e, em vez de alucinar varrendo o repositório, fará uma **SUGESTÃO EXPLÍCITA** para incluir essa regra no `CONVENTIONS.md`.
Leia [continuous-learning.md](references/continuous-learning.md).

## Codebase Modular (Domain-Driven)

Durante a fase de Design, a arquitetura deve ser desenhada por Bounded Contexts (Domínios) e nunca apenas por camadas técnicas (ex: proibido ter uma pasta raiz `controllers/` para todos os projetos). 
Leia [modular-architecture.md](references/modular-architecture.md).

## Execução Paralela (Subagentes)

As tarefas detalhadas recebem tags `[P]` (Paralela) ou `[S]` (Sequencial). O Agente Orquestrador dividirá as tarefas paralelas `[P]` enviando o contexto estrito para subagentes independentes.
Leia [tasks.md](references/tasks.md) e [implement.md](references/implement.md).

## Comandos do Workflow

| Gatilho | Descrição | Referência |
| :--- | :--- | :--- |
| `especificar [funcionalidade]` | Define a especificação com base em requisitos. Fase 1. | [specify.md](references/specify.md) |
| `projetar` / `design` | Define a arquitetura por Domínios/Bounded Contexts. Fase 2. | [modular-architecture.md](references/modular-architecture.md) |
| `criar tarefas` | Quebra em passos atômicos `[P]` ou `[S]`. Fase 3. | [tasks.md](references/tasks.md) |
| `implementar` | Executa o código e valida. Dispara subagentes se necessário. Fase 4. | [implement.md](references/implement.md) |
| `corrigir [feedback]` | Engatilha o "Reflect & Fix" para correções manuais. | [continuous-learning.md](references/continuous-learning.md) |

---
**Nota Inicial:** Ao receber a instrução para iniciar uma funcionalidade, avalie o escopo. Se for pequeno (Quick Mode), pule Design e Tarefas, indo direto para Execução/Implementação.
