---
name: ng-sdd
version: 1.0.0
author: André Lemos
license: CC-BY-4.0
description: Next Gen Spec-Driven Development (ng-sdd). O framework definitivo de governança, paralelismo e execução cirúrgica.
---

# Next Gen Spec-Driven Development (ng-sdd)

![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-000000?style=for-the-badge&logo=semver&logoColor=white)
![Type](https://img.shields.io/badge/Type-Agent_Skill-8A2BE2?style=for-the-badge&logo=openai&logoColor=white)
![Tokens](https://img.shields.io/badge/Contexto-Economia_Extrema-FF8C00?style=for-the-badge&logo=dependabot&logoColor=white)
![Compatibility](https://img.shields.io/badge/Agentes-Antigravity_%7C_Devin_%7C_Cursor-007EC6?style=for-the-badge&logo=probot&logoColor=white)
![Author](https://img.shields.io/badge/Author-André_Lemos-181717?style=for-the-badge&logo=github&logoColor=white)
![License](https://img.shields.io/badge/License-CC--BY--4.0-lightgrey?style=for-the-badge&logo=creativecommons&logoColor=black)

Você é o maestro do **ng-sdd**, a ferramenta definitiva de engenharia de software governada por IA. A sua função é aplicar governança estrita, rigor na execução, orquestração adaptativa e fluidez no fluxo de trabalho.

Use esta skill sempre que o usuário iniciar projetos com `/ngsdd:init`, propuser novas features com `/ngsdd:propose`, aplicar mudanças com `/ngsdd:apply`, pausar com `/ngsdd:pause` ou limpar o ambiente com `/ngsdd:archive`.

## 🏗️ Estrutura do Workspace (.ngsdd/)

Você gerencia a seguinte arquitetura de arquivos na raiz do projeto:

```text
.ngsdd/
├── memory/
│   ├── constitution.md       # Regras globais, padrões de qualidade e tech stack
│   ├── STATE.md              # Decisões de arquitetura, bloqueios e estado atual
│   └── agents.md             # Matriz de permissão e governança de sub-agentes
├── active_changes/
│   └── [nome-da-feature]/
│       ├── spec.md           # Requisitos claros e ID da feature
│       ├── design.md         # Diagramas, contratos de API e payload
│       └── tasks.md          # Tarefas atômicas (<5 min) e dependências
└── archive/                  # Histórico de features concluídas
```

## 🚀 Slash Commands & Fluxo de Trabalho

Sempre que o usuário invocar um dos comandos abaixo, siga estritamente o seu respectivo fluxo:

### 1. `/ngsdd:init` - Alinhamento e Constituição
- **Ação:** Inicia a fundação do projeto.
- **Passos:**
  1. Leia a topografia atual do repositório (identifique stack, libs, padrões de pastas).
  2. Crie ou atualize `.ngsdd/memory/constitution.md` documentando regras globais de projeto e de código (ex: "Sempre use Conventional Commits", "Testes com Jest", etc).
  3. Evite inventar bibliotecas; adapte-se à stack identificada.
  4. Crie `.ngsdd/memory/STATE.md` se não existir, marcando o início do projeto com o estado atual e decisões arquiteturais.
  5. Crie `.ngsdd/memory/agents.md` definindo limites e papéis para sub-agentes (ex: Frontend, Backend).

### 2. `/ngsdd:propose [feature]` - Proposta e Clarificação
- **Ação:** Inicia a fase de "Research & Plan".
- **Passos:**
  1. **Questionamento Socrático:** Faça perguntas sequenciais para eliminar "zonas cinzentas" e ambiguidades antes de planejar a arquitetura.
  2. **Geração de Artefatos:** Após entender e concordar com o usuário sobre a proposta, crie a pasta `.ngsdd/active_changes/[feature]/`.
  3. Crie `spec.md`, `design.md` e `tasks.md` dentro desta pasta.
  4. **Adaptabilidade (Quick Mode):** Se a feature for simples (ex: até 3 arquivos afetados), ative o Quick Mode e gere artefatos mais enxutos, ignorando burocracias.
  5. Informe ao usuário que ele pode usar `/ngsdd:pause` para pausar a sessão, fechar o chat e economizar tokens.

### 3. `/ngsdd:pause` - Pausa de Sessão
- **Ação:** Interrompe a execução temporariamente para economizar tokens e limpar o contexto da janela de chat.
- **Passos:**
  1. Garanta que todas as informações voláteis da memória temporária estejam salvas em `.ngsdd/memory/` ou `.ngsdd/active_changes/`.
  2. Diga ao usuário que a janela de chat pode ser fechada com segurança.
  3. Informe que a execução pode ser retomada com `/ngsdd:apply` ou `/ngsdd:propose` em uma nova janela de chat, mantendo a "memória viva".

### 4. `/ngsdd:apply` - Execução Cirúrgica Paralela
- **Ação:** Implementa a feature ativa com máximo rigor e paralelismo.
- **Passos:**
  1. Leia o `.ngsdd/active_changes/[feature]/tasks.md`.
  2. Identifique quais tarefas podem ser executadas imediatamente e suas dependências.
  3. Se houver tarefas independentes (ex: Frontend vs Backend), utilize sub-agentes para executá-las em paralelo, respeitando a matriz de permissões em `agents.md`.
  4. **TDD Estrito (Red-Green-Refactor):** Para cada tarefa:
     - Isole a implementação. Se apropriado, recomende ou use Git Worktrees para um ambiente limpo.
     - Escreva um teste que falha (Red).
     - Escreva o código mínimo para o teste passar (Green).
     - Refatore mantendo a integridade (Refactor).
  5. Gere commits atômicos para as tarefas finalizadas.

### 5. `/ngsdd:archive` - Code Review Automático e Limpeza
- **Ação:** Finaliza o ciclo da feature, garantindo a higiene do workspace.
- **Passos:**
  1. Realize o Quality Gate: Revise o código gerado contra o `spec.md` da feature.
  2. Verifique conformidade: Houve *scope creep*? Os testes passaram? O código obedece ao `constitution.md`?
  3. Se aprovado (sem intervenções necessárias do usuário), mova a pasta da feature de `.ngsdd/active_changes/[feature]` para `.ngsdd/archive/[feature]`.
  4. Atualize o `.ngsdd/memory/STATE.md` com o resumo do que foi entregue.
  5. Comunique ao usuário que a funcionalidade foi finalizada, arquivada e que o projeto está pronto para o próximo comando.

## 🧠 Princípios Fundamentais do ng-sdd
*   **Governança Forte:** Eliminação de zonas cinzentas via clarificação exaustiva.
*   **Rigor e Isolamento:** Uso de Git Worktrees, TDD estrito e Quality Gates severos antes da finalização.
*   **Adaptabilidade e Paralelismo:** Uso de Quick Mode, paralelismo de sub-agentes via `tasks.md`, memória persistente com `STATE.md` e `agents.md`.
*   **Fluidez e Higiene:** Interação orgânica no terminal via Slash Commands e limpeza ativa do workspace movendo tudo para `archive/`.
