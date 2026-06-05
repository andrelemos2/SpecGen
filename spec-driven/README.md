<p align="center">
  <img src="https://img.shields.io/badge/Skill-Spec--Driven-blue?style=for-the-badge" alt="skill badge" />
  <img src="https://img.shields.io/badge/Stack-Agnostic-green?style=for-the-badge" alt="stack agnostic" />
  <img src="https://img.shields.io/badge/Version-1.0.0-purple?style=for-the-badge" alt="version" />
</p>

<h1 align="center">🎯 Spec-Driven</h1>

<p align="center">
  <strong>Planeje e implemente projetos com precisão. Tarefas granulares. Dependências claras. Ferramentas certas. Zero cerimônia.</strong>
</p>

<p align="center">
  <strong>Autor:</strong> <a href="https://github.com/andrelemos2">Andre Lemos</a>
</p>

## ✨ O que é esta Skill?

**Spec-Driven** transforma a forma como agentes de IA abordam projetos de software. Em vez de um pipeline rígido e burocrático, ela usa **4 fases adaptativas** que se autoajustam com base na complexidade — aplicando rigor total para funcionalidades complexas e pulando a cerimônia para as simples:

```
┌──────────────┐   ┌──────────────┐   ┌─────────────┐   ┌─────────────┐
│  ESPECIFICAR │ → │    DESIGN    │ → │   TAREFAS   │ → │  EXECUTAR   │
└──────────────┘   └──────────────┘   └─────────────┘   └─────────────┘
    obrigatório        opcional*          opcional*       obrigatório

* O agente pula automaticamente quando o escopo não precisa da fase
```

**A complexidade está no sistema, não no seu fluxo de trabalho.** Você conversa naturalmente — a skill decide quão fundo ir:

| Escopo | O que acontece |
| :--- | :--- |
| **Pequeno** (≤3 arquivos) | Modo rápido — descrever → implementar → verificar → commit |
| **Médio** (funcionalidade clara) | Especificar → Executar (design e tarefas inline) |
| **Grande** (multi-componentes) | Pipeline completo com design formal e detalhamento de tarefas |
| **Complexo** (ambiguidade, novo domínio) | Pipeline completo + discussão de áreas cinzentas + pesquisa + UAT interativo |

## 🚀 Início Rápido

### Primeiros Comandos

| O que você quer | Diga isso |
| :--- | :--- |
| Começar um novo projeto | `"Inicializar projeto"` ou `"Configurar projeto"` (`"Initialize project"` ou `"Setup project"`) |
| Trabalhar com código existente | `"Mapear base de código"` ou `"Analisar código existente"` (`"Map codebase"` ou `"Analyze existing code"`) |
| Planejar uma funcionalidade | `"Especificar funcionalidade [nome]"` (`"Specify feature [name]"`) |
| Correção rápida de bug | `"Correção rápida: [descrição]"` (`"Quick fix: [description]"`) |
| Retomar trabalho anterior | `"Retomar trabalho"` ou `"Continuar"` (`"Resume work"` ou `"Continue"`) |

> 💬 **Conversa Natural, Não Comandos**
>
> Estas são frases de gatilho de exemplo, não comandos estritos. A skill funciona por meio de **conversa natural** — fale com seu agente como falaria com um colega de trabalho. Diga coisas como _"Eu quero criar um sistema de autenticação"_ ou _"Corrija o botão de login, ele está retornando 401"_. O agente compreende o contexto e a intenção, não apenas palavras-chave em inglês ou português.

## 📁 Estrutura do Projeto

A skill cria um diretório `.specs/` para organizar toda a documentação do projeto:

```
.specs/
├── project/
│   ├── PROJECT.md      # Visão, objetivos, stack de tecnologia, restrições
│   ├── ROADMAP.md      # Marcos (milestones), funcionalidades, rastreamento de status
│   └── STATE.md        # Memória persistente: decisões, impedimentos, aprendizados, todos, ideias postergadas
│
├── codebase/           # Análise brownfield (apenas projetos existentes)
│   ├── STACK.md        # Stack de tecnologia e dependências
│   ├── ARCHITECTURE.md # Padrões, fluxo de dados, organização do código
│   ├── CONVENTIONS.md  # Nomenclatura, estilo, padrões de codificação
│   ├── STRUCTURE.md    # Layout de diretórios e módulos
│   ├── TESTING.md      # Frameworks e padrões de teste
│   ├── INTEGRATIONS.md # Serviços externos e APIs
│   └── CONCERNS.md     # Débitos técnicos, riscos, áreas frágeis
│
├── features/           # Especificações de funcionalidades
│   └── [nome-da-funcionalidade]/
│       ├── spec.md     # Requisitos com IDs rastreáveis (FEAT-01, AUTH-02...)
│       ├── context.md  # Decisões do usuário para áreas cinzentas (apenas quando necessário)
│       ├── design.md   # Arquitetura e componentes (apenas para grande/complexo)
│       └── tasks.md    # Tarefas atômicas com dependências (apenas para grande/complexo)
│
└── quick/              # Tarefas ad-hoc (modo rápido)
    └── NNN-slug/
        ├── TASK.md     # Descrição + verificação
        └── SUMMARY.md  # O que foi feito + commit
```

## 🔄 As Quatro Fases Adaptativas

### Especificar (Sempre)

**Objetivo:** Capturar O QUE construir com requisitos testáveis e rastreáveis.

O agente atua como um parceiro de pensamento — não um entrevistador. Ele faz perguntas de esclarecimento, questiona ambiguidades e captura requisitos com IDs rastreáveis:

```markdown
### P1: Aplicar Cupom de Desconto no Carrinho ⭐ MVP

**Caso de Uso:** Como comprador, quero inserir um cupom de desconto no carrinho para obter uma redução no valor total da minha compra.

| ID do Requisito | Critérios de Aceitação |
| :--- | :--- |
| CART-01 | QUANDO o usuário insere um cupom válido ENTÃO o sistema DEVE calcular o desconto e atualizar o total |
| CART-02 | QUANDO o cupom inserido for inválido ou expirado ENTÃO o sistema DEVE exibir um erro claro e manter o valor original |
| CART-03 | QUANDO o cupom exceder o limite de uso ENTÃO o sistema DEVE rejeitá-lo com a mensagem apropriada |
```

**Discussão de áreas cinzentas (disparada automaticamente):** Quando a especificação possui decisões ambíguas voltadas para o usuário (preferências de layout, padrões de interação, estilo de tratamento de erros), o agente pergunta automaticamente sobre elas — criando um `context.md` que consolida essas decisões antes do design. Isso NÃO é uma fase separada — ocorre apenas dentro da fase de Especificação quando a ambiguidade é detectada.

### Design (Quando Necessário)

**Objetivo:** Definir COMO construir. Arquitetura, componentes, o que reaproveitar.

**Pulado quando:** A alteração é direta — sem decisões de arquitetura, sem novos padrões. Para funcionalidades simples, o design ocorre inline durante a Execução.

**Inclui pesquisa:** Antes de projetar com tecnologia desconhecida, o agente segue a **Cadeia de Verificação de Conhecimento** (base de código → documentos do projeto → MCP Context7 → busca na web → sinalizar incerteza). Ele **nunca assume ou inventa** — se não encontrar documentação, diz isso.

**Entregável:** `design.md` com diagramas de arquitetura, definições de componentes e pontos de integração.

### Tarefas (Quando Necessário)

**Objetivo:** Dividir em tarefas GRANULARES e ATÔMICAS com dependências claras.

**Pulado quando:** Existem ≤3 passos óbvios. Nesse caso, as tarefas são listadas inline no início da Execução.

**Válvula de segurança:** Se listagem de passos inline revelar >5 passos ou dependências complexas, o agente PARA e cria um `tasks.md` formal — reconhecendo que a fase de Tarefas foi pulada incorretamente.

| ❌ Tarefa Vaga | ✅ Tarefas Atômicas |
| :--- | :--- |
| "Implementar cupons" | T1: Criar a interface do CouponService e contrato de dados |
| | T2: Adicionar método de validação de expiração e limite de uso |
| | T3: Implementar cálculo de redução percentual e valor fixo |
| | T4: Integrar componente visual de input de cupom na tela do carrinho |

Cada tarefa inclui: O quê (entregável), Onde (caminho do arquivo), Depende de (pré-requisitos), Reaproveita (código existente), Requisito (ID rastreável), Concluído quando (critério verificável), Commit (formato da mensagem).

### Executar (Sempre)

**Objetivo:** Implementar uma tarefa de cada vez. Verificar. Commit. Repetir.

Cada tarefa segue o mesmo ciclo:

```
Plano → Implementar → Verificar → Commit → Próxima
```

**Princípios fundamentais:**

- **Alterações cirúrgicas** — Toque apenas nos arquivos necessários
- **Sem desvio de escopo (scope creep)** — Se não está na tarefa, não toque. Capture ideias no STATE.md como Ideias Postergadas
- **Verifique antes de commitar** — Cheque todos os critérios "Concluído quando"
- **Commits git atômicos** — Uma tarefa = um commit, seguindo os [Commits Convencionais 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)

```
feat(cart): adiciona validação de cupons expirados no serviço de checkout

refactor(cart): extrai cálculo de desconto percentual para um utilitário puro

fix(cart): impede que o desconto torne o valor total da compra negativo
```

**A validação a nível de funcionalidade** ocorre depois que todas as tarefas são concluídas — incluindo verificações de critérios de aceitação, revisão de qualidade do código e, opcionalmente, UAT interativo para recursos complexos voltados para o usuário.

## ⚡ Modo Rápido (Quick Mode)

Para tarefas pequenas (correções de bugs, mudanças de configuração, ajustes em ≤3 arquivos) que não precisam do pipeline completo:

```
Você: Correção rápida: o desconto fixo de R$10 está permitindo que o total do carrinho fique negativo quando a compra é menor que R$10

Agente: Tarefa Rápida: Validar total mínimo pós-desconto fixo
       Arquivos: src/services/discount.ts
       Abordagem: Adicionar um Math.max(0, total - desconto) na aplicação de cupom de valor fixo
       Verificar: Carrinho de R$8 com cupom de R$10 de desconto deve resultar em total de R$0

       [Implementando...]

       ✅ Concluído. Committed: fix(cart): garante que o total do carrinho nunca seja menor que zero
```

**Diretrizes de Segurança:** Máximo de 3 arquivos, máximo de 1 hora, sem decisões de design, sem novas dependências. Se qualquer um destes limites for excedido, o agente recomendará o pipeline completo.

## 📋 Referência Completa de Comandos

Estes padrões de gatilho ajudam o agente a reconhecer sua intenção, mas você não precisa usá-los literalmente. Fale naturalmente — o agente entende variações e contextos.

### Nível de Projeto

| Padrão de Gatilho | Descrição |
| :--- | :--- |
| `Inicializar projeto`, `Configurar projeto`, `Initialize project`, `Setup project` | Cria o PROJECT.md com visão, objetivos e restrições |
| `Criar roadmap`, `Planejar funcionalidades`, `Create roadmap`, `Plan features` | Cria o ROADMAP.md com marcos e funcionalidades |
| `Mapear base de código`, `Analisar código existente`, `Map codebase`, `Analyze existing code` | Cria os 7 documentos brownfield para projetos existentes |
| `Documentar preocupações`, `Encontrar débitos técnicos`, `Document concerns`, `Find tech debt` | Identifica e documenta os riscos da base de código |
| `Registrar decisão`, `Registrar impedimento`, `Adicionar todo`, `Record decision`, `Log blocker`, `Add todo` | Adiciona entradas ao STATE.md |
| `Pausar trabalho`, `Encerrar sessão`, `Pause work`, `End session` | Cria um arquivo de handoff para continuidade da sessão |
| `Retomar trabalho`, `Continuar`, `Resume work`, `Continue` | Carrega o estado anterior e continua o trabalho |

### Nível de Funcionalidade (Auto-ajustável)

| Padrão de Gatilho | Descrição |
| :--- | :--- |
| `Especificar funcionalidade`, `Definir requisitos`, `Specify feature`, `Define requirements` | Cria o spec.md com IDs de requisitos |
| `Discutir funcionalidade`, `Como isso deve funcionar`, `Discuss feature`, `How should this work` | Captura as decisões do usuário para áreas cinzentas |
| `Projetar funcionalidade`, `Arquitetura`, `Design feature`, `Architecture` | Cria o design.md com a arquitetura |
| `Dividir em tarefas`, `Criar tarefas`, `Break into tasks`, `Create tasks` | Cria o tasks.md com detalhamento atômico |
| `Implementar tarefa`, `Build`, `Executar`, `Implement task`, `Build`, `Execute` | Executa tarefa específica com verificação |
| `Validar`, `Verificar trabalho`, `UAT`, `Validate`, `Verify work`, `UAT` | Validação e testes a nível de funcionalidade |
| `Correção rápida`, `Tarefa rápida`, `Correção de bug`, `Quick fix`, `Quick task`, `Bug fix` | Canal expresso para pequenas alterações |

## 🔁 Exemplos de Fluxo de Trabalho

### Iniciando um Novo Projeto

```
Você: Inicializar projeto

Agente: Vou ajudar você a configurar o projeto. Deixe-me fazer algumas perguntas:
       1. O que você está construindo?
       2. Para quem é e qual problema ele resolve?
       ...

Você: [Responde às perguntas]

Agente: ✅ Criado .specs/project/PROJECT.md
       Próximo passo: Gostaria de criar um roadmap? Diga "Criar roadmap"
```

### Trabalhando com uma Base de Código Existente

```
Você: Mapear base de código

Agente: Vou analisar a base de código existente e documentar:
       - Stack de tecnologia, Padrões de arquitetura, Convenções de código
       - Estrutura de diretórios, Infraestrutura de testes, Integrações externas
       - Preocupações (débitos técnicos, riscos, áreas frágeis)

       [Analisa a base de código...]

       ✅ Criados 7 documentos brownfield em .specs/codebase/
       Próximo passo: Inicializar projeto para definir objetivos e roadmap
```

### Implementando uma Funcionalidade (Auto-ajustável)

```
Você: Especificar funcionalidade aplicar-cupom-desconto

Agente: [Faz perguntas de esclarecimento, cria o spec.md com IDs de requisitos]
       Percebi algumas áreas cinzentas na regra de negócio — cupons percentuais aplicam-se ao frete ou apenas aos itens?
       [Discute as áreas cinzentas, cria o context.md]

Você: Projetar a funcionalidade

Agente: [Pesquisa sobre cupons cumulativos e estruturação de descontos no banco, cria o design.md]

Você: Dividir em tarefas

Agente: [Cria o tasks.md com 5 tarefas atômicas + ordem de dependências]

Você: Implementar T1

Agente: Implementando T1: Criar interface do CouponService e contratos
       Arquivos: src/services/coupon.interface.ts
       Abordagem: Definir a assinatura dos métodos de validação e cálculo com base no design
       Verificar: Interface compila sem erros e exporta tipos corretamente

       [Implementando...]

       ✅ Committed: feat(cart): cria interface do CouponService e schemas de validação
       Próxima disponível: T2 (implementar lógica de expiração e limite de uso)
```

### Correção Rápida de Bug

```
Você: Correção rápida: alternância do modo escuro não persiste após atualizar a página

Agente: Tarefa Rápida: Persistir preferência de modo escuro
       Arquivos: src/hooks/useTheme.ts, src/utils/storage.ts
       Abordagem: Salvar preferência no localStorage ao alternar
       Verificar: Alternar modo escuro, atualizar página, a preferência persiste

       [Implementando...]

       ✅ Committed: fix(theme): persiste preferência de modo escuro no localStorage
```

### Continuidade de Sessão

```
Você: Pausar trabalho

Agente: ✅ Criado .specs/HANDOFF.md
       - Funcionalidade: aplicar-cupom-desconto
       - Concluído: T1 (interface), T2 (lógica de validação)
       - Em progresso: T3 (lógica de cálculo - 60%)
       - Próxima sessão: Concluir T3, depois iniciar T4 (componente de tela)

--- Mais tarde, nova sessão ---

Você: Retomar trabalho

Agente: Retomando aplicar-cupom-desconto em T3
       - Concluído: T1 (interface de cupons), T2 (regras de validação de expiração)
       - Em progresso: T3 - cálculo de descontos em src/services/coupon.service.ts:32
       - Próximo: Concluir T3 e seus respectivos testes unitários, depois iniciar T4

       Continuar com T3?
```

## 🧠 Gerenciamento de Contexto

A skill foi projetada para trabalhar dentro dos limites de contexto:

| Estratégia de Carga | Documentos | Tokens |
| :--- | :--- | :--- |
| **Carga base** (sempre) | PROJECT.md, ROADMAP.md, STATE.md | ~15k |
| **Sob demanda** | Especificação atual, context, design ou tarefas | +5-10k |
| **Nunca simultâneos** | Múltiplas especificações ou documentos de arquitetura | — |

**Objetivo:** <40k tokens carregados (20% do contexto)
**Reserva:** 160k+ tokens para trabalho, raciocínio, saídas

Quando o contexto excede 40k tokens, a skill exibe um indicador de status e sugere otimizações.

## 🔗 Integração com Outras Skills

A Spec-Driven funciona ainda melhor quando combinada com skills complementares:

| Skill | Integração |
| :--- | :--- |
| **mermaid-studio** | Diagramas — visões gerais de arquitetura, fluxos de dados, diagramas de sequência |
| **codebase-navigator** | Exploração de código — mapeamento brownfield, identificação de padrões, rastreamento de dependências |

A skill detecta automaticamente se essas ferramentas estão instaladas e delega tarefas especializadas a elas. Caso não estejam, ela faz o fallback graciosamente e as recomenda uma vez por sessão.

## 📚 Arquivos de Referência

A skill inclui documentação de referência detalhada carregada sob demanda:

| Arquivo | Propósito |
| :--- | :--- |
| `project-init.md` | Processo de inicialização do projeto e template |
| `roadmap.md` | Criação de roadmap e acompanhamento de marcos |
| `brownfield-mapping.md` | Análise abrangente da base de código existente (7 docs) |
| `concerns.md` | Identificação e documentação de riscos e débitos técnicos |
| `specify.md` | Levantamento de requisitos com IDs rastreáveis |
| `discuss.md` | Discussão de áreas cinzentas e captura de decisões do usuário |
| `design.md` | Arquitetura, pesquisa técnica e design de componentes |
| `tasks.md` | Metodologia para detalhamento de tarefas granulares |
| `implement.md` | Executar: implementação + verificação + commits atômicos |
| `validate.md` | Validação de funcionalidades e UAT interativo |
| `quick-mode.md` | Canal expresso para tarefas rápidas |
| `session-handoff.md` | Fluxo de pausa e retomada de trabalho |
| `state-management.md` | Memória persistente: decisões, impedimentos, lições, todos, ideias postergadas |
| `coding-principles.md` | Diretrizes comportamentais e boas práticas para implementação |
| `context-limits.md` | Orçamento de tokens de contexto e monitoramento |
| `code-analysis.md` | Ferramentas de análise de código disponíveis e fallbacks |

## ⚡ Dicas para Melhores Resultados

### O que fazer ✅

- **Comece com a inicialização do projeto** — Mesmo para bases de código existentes
- **Seja específico sobre o escopo** — Limites claros evitam desvio de escopo (creeping)
- **Confie no ajuste de tamanho automático (auto-sizing)** — O agente aplicará a profundidade certa
- **Use linguagem natural** — Não há necessidade de decorar comandos de terminal
- **Diga "pausar trabalho" antes de terminar** — Permite uma retomada perfeita
- **Questione o agente** — Se algo parecer errado ou impreciso, diga

### O que não fazer ❌

- **Não force todas as fases** — Deixe o agente pular o que for desnecessário
- **Não trabalhe em várias funcionalidades ao mesmo tempo** — Uma por ciclo
- **Não ignore a verificação** — Mesmo tarefas rápidas precisam de um passo de verificação
- **Não aceite respostas vagas** — Se o agente disser algo impreciso, peça detalhes

## 💡 Recomendação de Modelos

> **Melhores resultados com modelos modernos e capazes de raciocínio:**
>
> - **Claude 3.5 Sonnet / Claude 3 Opus** — Excelentes para todas as fases
> - **Gemini 1.5 Pro / Gemini 3 Pro / GPT-4o** — Raciocínio forte e janela de contexto grande
> - **Gemini 1.5 Flash / Gemini 3 Flash / Claude 3 Haiku** — Ótimos desempenhos gerais e rápidos
>
> Para otimização de custo, a skill sugerirá quando modelos mais leves são suficientes para tarefas simples como validação ou handoff de sessão.

## 🤖 Compatibilidade

Esta skill funciona de forma unificada e é **100% compatível com qualquer agente de codificação de IA** que suporte skills, playbooks ou instruções personalizadas, auto-detectando o runtime em tempo de execução para adaptar seu comportamento.

**Testado e verificado em:**

| Agente | Status | Como Usar / Instalar |
| :--- | :--- | :--- |
| **Antigravity (Gemini)** | ✅ Testado | Nativamente via CLI: `npx agent-skills install -s spec-driven` |
| **Claude Code** | ✅ Testado | Carrega as regras a partir do `SKILL.md` ou referências do repositório. |
| **Devin (Cognition)** | ✅ Testado | Copie o diretório da skill para a pasta `.agents/skills/spec-driven/` do seu projeto. |
| **GitHub Copilot** | ✅ Testado | Por meio do carregamento do `SKILL.md` como Custom Instructions. |
| **Cursor / Windsurf** | ✅ Testado | Configurando o `SKILL.md` nas configurações de regras do agente (.cursorrules). |

### 🚀 Setup Específico para Devin (Cognition)

O Devin possui suporte nativo e automático para esta skill a partir de um único repositório unificado:

#### 1. Skill de Repositório (Único Source of Truth)
Copie todo o diretório desta skill para a pasta `.agents/skills/spec-driven/` na raiz do seu projeto.
- O Devin escaneia o diretório `.agents/skills/` ao iniciar o projeto e adicionará a skill `spec-driven` na lista de **Skills Discovered**.
- Ele auto-detectará o ambiente Devin (ver [runtime-detector.md](references/runtime-detector.md)) e desativará tarefas paralelas de subagentes locais de forma transparente, executando todas as tarefas sequencialmente na mesma sessão.
- Todos os caminhos de referência (`references/`) continuam funcionando relativamente dentro do repositório da skill copiada.

#### 2. Base de Conhecimento (Knowledge Base UI)
Para contextualização global e permanente de todos os projetos, você pode criar os seguintes itens na aba **Settings & Library > Knowledge** da plataforma Devin:
- **Git Commit Convention:** Gatilho: `When writing git commit messages`. Conteúdo: Regras de Conventional Commits da skill.
- **Specs Directory Structure:** Gatilho: `Using the .specs folder`. Conteúdo: Estrutura padrão de arquivos em `.specs/`.
- **Auto-sizing Rules:** Gatilho: `Deciding which development phases to use`. Conteúdo: Tabela de escopo (Pequeno, Médio, Grande, Complexo).
- **Quick Mode Guardrails:** Gatilho: `Executing a quick fix`. Conteúdo: Limites de ≤3 arquivos modificados.
- **Requirement Traceability:** Gatilho: `Using requirement IDs`. Conteúdo: Rastreabilidade com ids `[FEAT]-NN`.


> **Nota:** Se o seu agente suporta o carregamento de instruções personalizadas ou skills, esta skill deve funcionar. Os agentes acima são simplesmente os locais onde ela foi ativamente testada.

## ❓ FAQ

**P: Posso pular fases?**
R: Sim! A skill se autoajusta. Design e Tarefas são pulados para funcionalidades simples. O modo rápido pula o pipeline inteiro para pequenas mudanças. Você só tem cerimônia quando o escopo exige.

**P: E se meu projeto já tiver código?**
R: Use `"Mapear base de código"` primeiro. Isso cria 7 documentos analisando sua arquitetura, convenções, stack e preocupações existentes antes de você começar a adicionar novas funcionalidades.

**P: Como funciona a rastreabilidade dos requisitos?**
R: Cada requisito ganha um ID único (ex: `AUTH-01`) no spec.md. As tarefas fazem referência a esses IDs, e a validação checa quais requisitos foram verificados. Você tem uma trilha clara de spec → design → tarefa → commit.

**P: O que são commits git atômicos?**
R: Cada tarefa produz exatamente um commit seguindo os [Commits Convencionais 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). Isso significa um histórico git limpo, busca fácil por bugs via bisect e reversões simples quando necessário.

**P: Posso usar isso para tarefas pequenas ou correções rápidas?**
R: Sim! Diga `"Correção rápida: [descrição]"` para correções de bugs, mudanças de configuração ou pequenos ajustes. Você ganha salvaguardas de qualidade (verificação + commit) sem o overhead de planejamento.

**P: O que acontece se eu fechar minha sessão no meio de uma tarefa?**
R: Diga `"Pausar trabalho"` antes de terminar sua sessão. Isso cria um documento de handoff. Na próxima sessão, diga `"Retomar trabalho"` para continuar exatamente de onde parou.

**P: Isso funciona com qualquer stack de tecnologia?**
R: Sim! A skill é totalmente agnóstica em termos de stack. Funciona com qualquer linguagem, framework ou arquitetura.

**P: E se o agente inventar uma API ou padrão que não existe?**
R: A skill impõe uma **Cadeia de Verificação de Conhecimento** estrita: base de código → docs do projeto → MCP Context7 → busca na web → sinalizar incerteza. Ela NUNCA inventa informações. Se o agente não puder encontrar a documentação oficial, ele dirá "não sei" ou "não consegui encontrar" em vez de chutar.

## 📄 Licença

CC-BY-4.0 © [Andre Lemos](https://github.com/andrelemos2)

<p align="center">
  <sub>Construído por Andre Lemos</sub>
</p>
