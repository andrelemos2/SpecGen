---
name: spec-driven
description: Planejamento de projetos e funcionalidades com 4 fases adaptativas - Especificar, Design, Tarefas, Executar. Auto-ajusta a profundidade de acordo com a complexidade. Cria tarefas atômicas com critérios de verificação, commits git atômicos, rastreabilidade de requisitos e memória persistente entre sessões. Agnóstico em relação à stack de tecnologia. Use quando (1) Iniciar novos projetos (inicializar visão, objetivos, roadmap), (2) Trabalhar com bases de código existentes (mapear stack, arquitetura, convenções), (3) Planejar funcionalidades (requisitos, design, detalhamento de tarefas), (4) Implementar com verificação e commits atômicos, (5) Tarefas rápidas ad-hoc (correções de bugs, mudanças de configuração), (6) Rastrear decisões/impedimentos/ideias postergadas entre sessões, (7) Pausar/retomar trabalho. Disparado por "inicializar projeto", "configurar projeto", "mapear base de código", "analisar código existente", "especificar funcionalidade", "discutir funcionalidade", "projetar funcionalidade", "arquitetura", "criar tarefas", "implementar", "validar", "verificar trabalho", "UAT", "correção rápida", "tarefa rápida", "pausar trabalho", "retomar trabalho", "continuar". NÃO use para análise de decomposição de arquitetura (use skills de arquitetura) ou documentos de design técnico (use create-technical-design-doc).
license: CC-BY-4.0
metadata:
  author: Andre Lemos - github.com/andrelemos2
  version: 1.0.0
# Devin compatibility configurations
argument-hint: "[feature-name | quick-fix-description | codebase]"
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

# Desenvolvimento Guiado por Especificações

Planeje e implemente projetos com precisão. Tarefas granulares. Dependências claras. Ferramentas certas. Zero cerimônia.

```
┌──────────────┐   ┌──────────────┐   ┌─────────────┐   ┌─────────────┐
│  ESPECIFICAR │ → │    DESIGN    │ → │   TAREFAS   │ → │  EXECUTAR   │
└──────────────┘   └──────────────┘   └─────────────┘   └─────────────┘
   obrigatório        opcional*          opcional*       obrigatório

* O agente pula automaticamente quando o escopo não precisa da fase
```

## Auto-Detecção de Runtime (OBRIGATÓRIO)

Antes de iniciar qualquer funcionalidade ou mapeamento, o agente deve rodar uma verificação de ambiente conforme instruído em [runtime-detector.md](references/runtime-detector.md) para identificar se está rodando sob **Devin, Claude Code, Antigravity ou CLI Local**, ajustando seus limites de ferramentas e paralelismo em conformidade.

## Auto-Sizing (Ajuste de Tamanho Automático): O Princípio Fundamental

**A complexidade determina a profundidade, não um pipeline fixo.** Antes de iniciar qualquer funcionalidade, avalie seu escopo e aplique apenas o que for necessário:

| Escopo | O que é | Especificar | Design | Tarefas | Executar |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Pequeno** | ≤3 arquivos, uma frase | **Modo rápido** — pula o pipeline inteiramente | - | - | - |
| **Médio** | Funcionalidade clara, <10 tarefas | Especificação (breve) | Pula — design inline | Pula — tarefas implícitas | Implementar + verificar |
| **Grande** | Funcionalidade multi-componente | Especificação completa + IDs de requisitos | Arquitetura + componentes | Detalhamento completo + dependências | Implementar + verificar por tarefa |
| **Complexo** | Ambiguidade, novo domínio | Especificação completa + [discutir áreas cinzentas](references/discuss.md) | [Pesquisa](references/design.md) + arquitetura | Detalhamento + plano paralelo | Implementar + [UAT interativo](references/validate.md) |

**Regras:**

- **Especificar e Executar são sempre necessários** — você sempre precisa saber O QUE fazer e FAZER
- **Design é pulado** quando a alteração é direta (sem decisões de arquitetura, sem novos padrões)
- **Tarefas é pulado** quando há ≤3 passos óbvios (eles se tornam implícitos em Executar)
- **Discutir (Discuss) é disparado em Especificar** apenas quando o agente detecta áreas cinzentas ambíguas que precisam do feedback do usuário
- **UAT interativo é disparado em Executar** apenas para funcionalidades voltadas para o usuário com comportamento complexo
- **Modo rápido (Quick mode)** é o canal expresso — para correções de bugs, mudanças de configuração e pequenos ajustes
- **Válvula de segurança:** Mesmo quando a fase de Tarefas é pulada, Executar SEMPRE começa listando passos atômicos inline (ver [implement.md](references/implement.md)). Se essa listagem revelar >5 passos ou dependências complexas, PARE e crie um `tasks.md` formal — a fase de Tarefas foi pulada incorretamente.

## Estrutura do Projeto

```
.specs/
├── project/
│   ├── PROJECT.md      # Visão e objetivos
│   ├── ROADMAP.md      # Funcionalidades e marcos (milestones)
│   └── STATE.md        # Memória: decisões, impedimentos, lições, todos, ideias postergadas
├── codebase/           # Análise brownfield (projetos existentes)
│   ├── STACK.md
│   ├── ARCHITECTURE.md
│   ├── CONVENTIONS.md
│   ├── STRUCTURE.md
│   ├── TESTING.md
│   ├── INTEGRATIONS.md
│   └── CONCERNS.md
├── features/           # Especificações de funcionalidades
│   └── [funcionalidade]/
│       ├── spec.md     # Requisitos com IDs rastreáveis
│       ├── context.md  # Decisões do usuário para áreas cinzentas (apenas se discutido)
│       ├── design.md   # Arquitetura e componentes (apenas para Grande/Complexo)
│       └── tasks.md    # Tarefas atômicas com verificação (apenas para Grande/Complexo)
└── quick/              # Tarefas ad-hoc (modo rápido)
    └── NNN-slug/
        ├── TASK.md
        └── SUMMARY.md
```

## Fluxo de Trabalho

**Novo projeto:**

1. Inicializar projeto → PROJECT.md + ROADMAP.md
2. Para cada funcionalidade → Especificar → (Design) → (Tarefas) → Executar (profundidade auto-ajustada)

**Base de código existente:**

1. Mapear base de código → 7 documentos brownfield
2. Inicializar projeto → PROJECT.md + ROADMAP.md
3. Para cada funcionalidade → mesmo fluxo de trabalho adaptativo

**Modo rápido:** Descrever → Implementar → Verificar → Commit (para ≤3 arquivos, escopo de uma frase)

## Estratégia de Carregamento de Contexto

**Carga base (~15k tokens):**

- PROJECT.md (se existir)
- ROADMAP.md (ao planejar/trabalhar em funcionalidades)
- STATE.md (memória persistente)

**Carga sob demanda:**

- Documentos do codebase (ao trabalhar em projeto existente)
- CONCERNS.md (ao planejar funcionalidades que tocam áreas sinalizadas, estimar risco ou modificar componentes frágeis)
- TESTING.md (ao criar tarefas ou executar — define os tipos de testes e gates)
- spec.md (ao trabalhar em funcionalidade específica)
- context.md (ao projetar ou implementar com base nas decisões do usuário)
- design.md (ao implementar com base no design)
- tasks.md (ao executar tarefas)

**Nunca carregar simultaneamente:**

- Múltiplas especificações de funcionalidades
- Múltiplos documentos de arquitetura
- Documentos arquivados

**Alvo:** <40k tokens de contexto total
**Reserva:** 160k+ tokens para trabalho, raciocínio, saídas
**Monitoramento:** Exibir status quando >40k (ver [context-limits.md](references/context-limits.md))

## Delegação de Subagentes

Use subagentes ou sessões filhas para manter a janela de contexto principal enxuta e permitir a execução paralela das tarefas. O agente orquestrador planeja e coordena; as instâncias filhas fazem o trabalho pesado de escrita e teste de código.

**Adaptação por Ambiente:**
- **No Devin:** Use o recurso nativo de **Child Sessions (Managed Devins)**. O Devin principal deve criar uma sessão filha independente para cada tarefa paralela `[P]` (ou sequencial isolada), monitorando a execução e coletando os resultados finais. O Devin NÃO usa subagentes locais baseados em ferramentas de MCP.
- **Em qualquer outra ferramenta (Antigravity, etc.):** Use subagentes locais disparados através da ferramenta nativa de MCP `Task` (ou equivalente) para isolar o contexto e executar tarefas paralelas.

**Quando delegar (Subagentes locais ou Devin Child Sessions):**

| Atividade | Delegar? | Por quê |
| :--- | :--- | :--- |
| Pesquisa (fase de design, mapeamento brownfield) | Sim | A saída da pesquisa é grande; apenas o resumo importa para o contexto principal |
| Implementar uma tarefa | Sim | Leituras de arquivos, edições, saídas de teste consomem contexto; apenas o resultado importa |
| Tarefas paralelas `[P]` | Sim (uma por tarefa) | A única forma de realmente executar tarefas em paralelo |
| Tarefas sequenciais sem `[P]` | Sim | Mantém os artefatos de implementação fora do contexto principal |
| Planejamento, criação de tarefas, relatórios de validação | Não | Estes exigem todo o contexto acumulado para serem coerentes |
| Tarefas do modo rápido | Não | Muito pequenas para justificar o overhead |

**Contexto que cada subagente recebe:**

O agente orquestrador DEVE fornecer a cada subagente:
- A definição específica da tarefa do tasks.md (O quê, Onde, Depende de, Reaproveita, Concluído quando, Testes, Gate)
- Princípios de codificação e convenções relevantes (coding-principles.md, CONVENTIONS.md)
- TESTING.md, se existir (para comandos de verificação de gate e padrões de teste)
- Qualquer contexto de especificação/design que a tarefa referencie

O subagente NÃO recebe: definições de outras tarefas, histórico de chat acumulado, relatórios de validação de outras tarefas ou STATE.md (a menos que a tarefa referencie explicitamente uma decisão/impedimento).

**O que os subagentes retornam:**

Cada subagente reporta de volta:
- Status: Concluído | Impedido | Parcial
- Arquivos alterados: [lista]
- Resultado da verificação de gate: [passou/falhou + contagem de testes]
- Marcadores de SPEC_DEVIATION (se houver)
- Problemas encontrados (se houver)

O agente orquestrador usa isso para atualizar o status do tasks.md, a rastreabilidade e decidir os próximos passos.

## Comandos

**Nível de Projeto:**
| Padrão de Gatilho | Referência |
| :--- | :--- |
| Inicializar projeto, Configurar projeto, setup project, initialize project | [project-init.md](references/project-init.md) |
| Criar roadmap, planejar funcionalidades, plan features, create roadmap | [roadmap.md](references/roadmap.md) |
| Mapear base de código, analisar código existente, map codebase, analyze existing code | [brownfield-mapping.md](references/brownfield-mapping.md) |
| Documentar preocupações, encontrar débitos técnicos, document concerns, find tech debt | [concerns.md](references/concerns.md) |
| Registrar decisão, registrar impedimento, adicionar todo, record decision, log blocker, add todo | [state-management.md](references/state-management.md) |
| Pausar trabalho, encerrar sessão, pause work, end session | [session-handoff.md](references/session-handoff.md) |
| Retomar trabalho, continuar, resume work, continue | [session-handoff.md](references/session-handoff.md) |

**Nível de Funcionalidade (Auto-ajustável):**
| Padrão de Gatilho | Referência |
| :--- | :--- |
| Especificar funcionalidade, definir requisitos, specify feature, define requirements | [specify.md](references/specify.md) |
| Discutir funcionalidade, capturar contexto, como isso deve funcionar, discuss feature, capture context | [discuss.md](references/discuss.md) |
| Projetar funcionalidade, arquitetura, design feature, architecture | [design.md](references/design.md) |
| Dividir em tarefas, criar tarefas, break into tasks, create tasks | [tasks.md](references/tasks.md) |
| Implementar tarefa, build, executar, implement task, build, execute | [implement.md](references/implement.md) |
| Validar, verificar trabalho, UAT, test, validate, verify work | [validate.md](references/validate.md) |
| Correção rápida, tarefa rápida, correção de bug, quick fix, quick task, bug fix | [quick-mode.md](references/quick-mode.md) |

## Integrações de Skills

Esta skill coexiste com outras skills. Antes de tarefas específicas, verifique se skills complementares estão instaladas e dê preferência a elas quando disponíveis.

### Diagramas → mermaid-studio

Sempre que o fluxo de trabalho exigir a criação ou atualização de um diagrama (visões gerais de arquitetura, fluxos de dados, diagramas de componentes, diagramas de sequência, etc.), **sempre** verifique se a skill `mermaid-studio` está instalada no ambiente do usuário antes de prosseguir. Se estiver instalada, delegue toda a criação e renderização de diagramas a ela. Se não estiver instalada, prossiga com blocos de código mermaid inline e recomende ao usuário instalar o `mermaid-studio` para recursos de diagramação mais ricos (renderização para SVG/PNG, validação, temas, etc.). Exiba essa recomendação no máximo uma vez por sessão.

### Exploração de Código → codebase-navigator

Sempre que o fluxo de trabalho exigir explorar ou descobrir coisas em um repositório existente (mapeamento brownfield, análise de reuso de código, identificação de padrões, rastreamento de dependências, etc.), **sempre** verifique se a skill `codebase-navigator` está instalada no ambiente do usuário antes de prosseguir. Se estiver instalada, delegue as tarefas de exploração e navegação de código a ela. Se não estiver instalada, utilize as ferramentas integradas de análise de código (ver [code-analysis.md](references/code-analysis.md)) e recomende ao usuário instalar o `codebase-navigator` para uma exploração mais eficaz da base de código. Exiba essa recomendação no máximo uma vez por sessão.

## Cadeia de Verificação de Conhecimento

Ao pesquisar, projetar ou tomar qualquer decisão técnica, siga esta cadeia em ordem estrita. Nunca pule passos.

```
Passo 1: Base de código → verifique código, convenções e padrões existentes já em uso
Passo 2: Docs do projeto → README, docs/, comentários inline, .specs/codebase/
Passo 3: MCP Context7 → resolva o ID da biblioteca e depois consulte a API/padrões atuais
Passo 4: Busca na web → documentação oficial, fontes reputadas, padrões da comunidade
Passo 5: Sinalizar como incerto → "Não tenho certeza sobre X — aqui está meu raciocínio, mas verifique"
```

**Regras:**

- Nunca pule para o Passo 5 se os Passos 1-4 estiverem disponíveis
- O Passo 5 é SEMPRE sinalizado como incerto — nunca apresentado como fato
- **NUNCA assuma ou fabrique.** Se você não conseguir encontrar uma resposta, diga "não sei" ou "não consegui encontrar documentação para isso". Inventar APIs, padrões ou comportamentos causa falhas em cascata em design → tarefas → implementação. A incerteza é sempre preferível à fabricação.

## Comportamento de Saída

**Diretrizes do modelo:** Após concluir tarefas leves (validação, atualizações de estado, handoff de sessão), mencione naturalmente que tais tarefas funcionam bem com modelos mais rápidos/baratos. Rastreie no STATE.md em `Preferences` para evitar repetir. Para tarefas pesadas (mapeamento brownfield, design complexo), observe brevemente os requisitos de raciocínio antes de começar.

Seja conversacional, não robótico. Não interrompa o fluxo de trabalho — adicione isso como uma nota de encerramento natural. Pule se o usuário parecer experiente ou já tiver reconhecido a dica.

## Análise de Código

Use as ferramentas disponíveis com degradação graciosa. Veja [code-analysis.md](references/code-analysis.md).
