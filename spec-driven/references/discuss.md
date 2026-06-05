# Especificar: Discutir Áreas Cinzentas

**Objetivo:** Capturar COMO o usuário visualiza a funcionalidade quando a especificação tem áreas ambíguas. Isso NÃO é uma fase separada — é disparado dentro da fase de Especificação quando o agente detecta áreas cinzentas que precisam do feedback do usuário.

**Gatilho:** Automaticamente quando áreas cinzentas são detectadas durante a criação do spec, ou explicitamente via "discutir funcionalidade", "como isso deve funcionar?", "capturar contexto" (ou equivalentes em inglês como "discuss feature", "how should this work?", "capture context").

**Quando disparar (detecção automática):** A especificação contém comportamento voltado para o usuário que pode seguir múltiplos caminhos E o usuário não expressou uma preferência. Se a especificação estiver clara e inequívoca, pule isso por completo.

**Quando NÃO disparar:** Trabalho de infraestrutura, operações CRUD, contratos de API bem definidos, qualquer coisa em que o "como" seja óbvio a partir do "o quê".

## Por que esta Fase Existe

Especificações capturam O QUE construir. O Design captura a arquitetura. Mas nenhum deles captura a visão do usuário para áreas ambíguas — preferências de layout, padrões de interação, estilo de tratamento de erros, tom do conteúdo. Sem isso, o agente adivinha. Com isso, o agente constrói o que o usuário realmente imaginou.

O entregável — `context.md` — alimenta diretamente o Design e as Tarefas:

- **O Design o lê** para saber quais decisões estão consolidadas (travadas) vs. flexíveis
- **As Tarefas o leem** para incluir comportamentos específicos nas definições das tarefas

## Processo

### 1. Analisar a Funcionalidade

Leia `.specs/features/[feature]/spec.md` e identifique o domínio:

| Domínio | Áreas cinzentas a explorar |
| :--- | :--- |
| Algo que os usuários **VEEM** | Layout, densidade, interações, estados vazios, hierarquia visual |
| Algo que os usuários **CHAMAM** (API) | Formato de resposta, erros, autenticação, versionamento, rate limiting |
| Algo que os usuários **EXECUTAM** (CLI) | Formato de saída, flags, modos, tratamento de erros, verbosidade |
| Algo que os usuários **LEEM** | Estrutura, tom, profundidade, fluxo, navegação |
| Algo que está sendo **ORGANIZADO** | Critérios de agrupamento, nomenclatura, duplicatas, exceções |

Gere de 3 a 4 áreas cinzentas **específicas da funcionalidade**. Não categorias genéricas, mas decisões concretas para ESTA funcionalidade.

### 2. Apresentar Áreas Cinzentas

Apresente o limite da funcionalidade (do spec.md) e as áreas cinzentas ao usuário. Deixe-o escolher quais discutir. NÃO inclua uma opção de "pular tudo" — o usuário invocou esta fase para discutir.

### 3. Mergulho Profundo em Cada Área

Para cada área selecionada:

1. Faça de 3 a 4 perguntas concretas com opções específicas (não categorias vagas)
2. Após as perguntas, verifique: "Mais sobre [área], ou seguimos adiante?"
3. Se mais → faça mais 3-4 perguntas, verifique novamente
4. Após todas as áreas → "Pronto para criar o context.md?"

**Design das perguntas:**

- As opções devem ser concretas ("Layout em cards" em vez de "Opção A")
- Cada resposta deve influenciar a próxima pergunta
- Inclua "Fica a seu critério" como uma opção quando razoável — captura o discricionário do agente

### 4. Válvula de Segurança de Escopo (CRÍTICO)

O limite da funcionalidade do spec.md é **fixo**. A discussão esclarece COMO implementar, nunca SE deve adicionar novas capacidades.

**Permitido:** "Como os posts devem ser exibidos?" (esclarecendo ambiguidade)
**Não permitido:** "Deveríamos também adicionar comentários?" (nova capacidade)

Quando o usuário sugerir desvio de escopo (scope creep): "Isso parece uma funcionalidade separada. Vou anotá-la nas Ideias Postergadas. De volta à área [área atual]."

### 5. Escrever o context.md

---

## Template: `.specs/features/[feature]/context.md`

```markdown
# Contexto de [Funcionalidade]

**Coletado em:** [data]
**Especificação:** `.specs/features/[feature]/spec.md`
**Status:** Pronto para design

---

## Limite da Funcionalidade

[Declaração clara do que esta funcionalidade entrega — a âncora de escopo do spec.md]

---

## Decisões de Implementação

### [Área 1 que foi discutida]

- [Decisão específica tomada]
- [Outra decisão se aplicável]

### [Área 2 que foi discutida]

- [Decisão específica tomada]

### [Área 3 que foi discutida]

- [Decisão específica tomada]

### Discricionário do Agente

[Áreas onde o usuário disse explicitamente "você decide" — o agente tem flexibilidade aqui durante o design/implementação]

---

## Referências Específicas

[Quaisquer momentos "eu quero como o X", referências de produto, comportamentos específicos, padrões de interação mencionados durante a discussão]

[Se nenhum: "Sem requisitos específicos — aberto a abordagens padrão"]

---

## Ideias Postergadas

[Ideias que surgiram durante a discussão, mas pertencem a outras funcionalidades/fases. Capturadas aqui para não serem perdidas, mas explicitamente fora do escopo]

[Se nenhum: "Nenhuma — a discussão permaneceu dentro do escopo da funcionalidade"]
```

---

## Dicas

- **Decisões, não visões** — "Layout em cards com sombras sutis" é uma decisão. "Deve parecer moderno" não é.
- **O escopo é sagrado** — As Ideias Postergadas capturam o desvio de escopo (scope creep) sem descartar as ideias do usuário
- **Usuário = visionário, Agente = construtor** — Pergunte sobre como ele imagina a funcionalidade, não sobre detalhes da implementação técnica
- **Não pergunte sobre:** Arquitetura técnica, desempenho, detalhes de implementação — isso é papel do Design
- **Confirme antes do Design** — O usuário deve aprovar o context.md antes de avançar para a fase de design
