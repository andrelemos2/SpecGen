---
name: system-design
description: >
  Framework completo para conduzir e estruturar desenhos de System Design, incluindo
  geração de diagramas Flowchart (caixas e setas) como Mermaid Flowchart. Use esta skill
  sempre que o usuário mencionar desenho de arquitetura de system design, quiser praticar ou
  simular o desenho de arquitetura de sistemas, pedir ajuda para desenhar ou projetar
  um sistema distribuído, quiser entender como projetar um sistema
  em Big Techs, mencionar termos como "requisitos funcionais", "NFR", "escalabilidade",
  "gargalo", "fan-out", "hot data", "SPOF" ou "trade-off" em contexto de desenho, ou
  pedir para você agir como co-arquiteto ou revisor em um exercício de system design.
  Acione também quando o usuário colar um enunciado de problema (ex: "projete o Instagram",
  "desenhe um sistema de feed") e pedir orientação sobre como abordar, ou quando pedir
  explicitamente um flowchart, diagrama de caixas e setas, ou qualquer representação
  visual de arquitetura de sistema.
---

# System Design — Framework Completo

## O Verdadeiro Objetivo do Processo

Antes de qualquer diagrama, alinhe expectativas. O objetivo é avaliar:

- 🧠 Como pensar e estruturar problemas ambíguos
- 🗣️ Comunicação e colaboração (como trabalhar em equipe)
- 🔄 Como lidar com feedbacks e redirecionamentos
- ❓ A capacidade de fazer boas perguntas e validar premissas

> **Mentalidade correta**: Trate o processo de design como uma discussão colaborativa entre colegas de trabalho — não como um teste rígido. No fundo, é uma avaliação de soft skills e visão crítica.

---

## Por que engenheiros travam nos primeiros minutos

Dois padrões ruins e comuns:

| Caminho ❌ | Problema |
|---|---|
| **Pula direto pro desenho** → LB, Cache, DB genérico | Desenho sem contexto = chute |
| **Perguntas soltas e aleatórias** → "qual linguagem?", "qual cloud?" | Não leva a lugar nenhum |

**Resultado**: Tempo perdido e perda de foco na arquitetura.

**A solução**: Pense como um médico no pronto-socorro.

```
PS:          Paciente → Perguntas → Diagnóstico → Tratamento
Design:      Problema → Perguntas → Entendimento → Desenho
```

> Você é o médico. O problema é o paciente. **Toda pergunta é triagem.**

---

## O Framework de 4 Passos

Para uma sessão de design:

```
Passo 1: Escopo e Requisitos    →  3-10 min
Passo 2: Alto Nível e APIs      → 10-15 min
Passo 3: Aprofundamento         → 10-15 min
Passo 4: Finalização            → 10-15 min
```

---

## Passo 1: Escopo e Requisitos (3–10 min)

**Objetivo**: Entender o problema real antes de desenhar qualquer coisa.

### Fase 1 — Entender (o que o sistema faz)

Duas perguntas obrigatórias antes de tudo:

1. **O que esse sistema faz exatamente?**
2. **Qual o escopo do que vamos projetar?**

> Sem essas respostas, qualquer desenho é chute.

### Fase 2 — Dimensionar (qual o tamanho do problema)

Quatro dimensões a explorar:

| Dimensão | Pergunta | Impacto no design |
|---|---|---|
| **Escala** | Quem usa? Quantos usuários? | Arquitetura simples vs. distribuída |
| **Padrão de acesso** | Lê ou escreve mais? | Cache vs. fila de mensagens |
| **Hot data** | Tem dados com acesso desproporcional? | Tratamento especial (ex: celebridades) |
| **Greenfield ou evolução?** | Sistema novo ou existente sendo reescrito? | Rewrite vs. evolução incremental |

### Vocabulário Formal

| Fase | Nome técnico | Definição |
|---|---|---|
| Entender | **Requisitos Funcionais (FR)** | O que o sistema faz |
| Dimensionar | **Requisitos Não-Funcionais (NFR)** | Como o sistema se comporta |

**Exemplos práticos:**
- FR: "O usuário deve poder fazer upload de fotos"
- NFR: "Alta disponibilidade", "latência < 200ms", "suporte a 400M usuários"

### ✅ Boas práticas
- Deixe FRs e NFRs **visíveis** durante todo o processo (quadro, documento compartilhado)
- Pense em voz alta e valide premissas de design
- Faça estimativas ("contas de padaria"): RPS, volume de dados, tamanho de payload

### ❌ O que evitar
- Ficar em silêncio — sempre pense em voz alta
- Sair desenhando sem fazer perguntas de alinhamento
- Confundir FR com NFR (alta disponibilidade NÃO é requisito funcional)
- Gastar muito tempo só levantando requisitos

### 🎯 Dica de Ouro — Checkpoint antes de avançar
> Valide os requisitos: "Então, confirmando: FRs são X e Y, NFRs são A e B, e minha estimativa é Z RPS. Faz sentido antes de eu começar a desenhar?"

---

## Exemplo Aplicado (App de Fotos com 400M usuários)

**Problema**: Sistema atual pré-calcula o feed de cada seguidor. Quando uma celebridade posta, satura tudo e atrasa o feed de todos. Projete a próxima geração.

### Fase 1 — Entender
- O que faz? → Feed cronológico baseado em quem o usuário segue
- Escopo? → **Só o feed**. Não upload, busca ou descoberta.

### Fase 2 — Dimensionar
- Quem usa? → 400M usuários, centenas de milhões ativos
- Lê ou escreve? → **Write-heavy** (fan-out na escrita)
- Hot data? → **Sim** — celebridades com milhões de seguidores
- Greenfield? → **Não** — sistema existente sendo evoluído

### Diagnóstico resultante
> **Write-heavy + hot data + evolução + gargalo no fan-out**

Agora você tem onde começar a desenhar. O diagrama emerge do diagnóstico, não do nada.

**Fluxo básico identificado:**
```
Mobile App → POST → API → [Fila] → Post * N gravações no DB
```
A seta vermelha (gargalo) aponta exatamente onde o problema está: o fan-out massivo para seguidores de celebridades.

---

## Passo 1.5: Peças do Sistema — Building Blocks AWS (2–3 min)

**Objetivo**: Antes de desenhar qualquer diagrama, apresentar as **peças disponíveis** para montar a solução — com preferência por serviços AWS — e validar se fazem sentido para os requisitos levantados.

### Comportamento obrigatório no modo simulação

Claude deve, após confirmar FRs e NFRs, **apresentar um conjunto de building blocks sugeridos** organizados por camada, no seguinte formato:

```
🧩 Peças sugeridas para [Nome do Sistema]

CAMADA           SERVIÇO AWS              POR QUÊ
─────────────────────────────────────────────────────
Entrada          Amazon API Gateway       Rate limiting, auth, roteamento
CDN              Amazon CloudFront        Entrega global com baixa latência
Compute          AWS Lambda / ECS Fargate Stateless workers; escala automática
Fila / Stream    Amazon SQS / Kinesis     Desacoplamento assíncrono; durabilidade
Armazenamento    Amazon S3                Objetos, vídeos, arquivos estáticos
Banco Relacional Amazon RDS (PostgreSQL)  Dados estruturados com ACID
Banco NoSQL      Amazon DynamoDB          Alta escala, baixa latência, chave-valor
Cache            Amazon ElastiCache       Redis gerenciado; contadores e sessions
Busca            Amazon OpenSearch        Full-text search e analytics
Processamento    AWS Batch / ECS Jobs     Jobs pesados (ex: transcodificação)
Auth             Amazon Cognito           Autenticação e autorização gerenciada
Notificações     Amazon SNS               Fan-out de eventos para múltiplos targets
Observabilidade  Amazon CloudWatch        Logs, métricas, alarmes
```

> **Regra**: Preferir sempre serviço AWS gerenciado. Só sugerir solução open-source (ex: Kafka, MySQL on EC2) se houver justificativa clara de custo, controle ou requisito específico que o managed service não atende.

### Dinâmica com o usuário

Após apresentar as peças:
1. Claude pergunta: *"Você adicionaria ou removeria alguma peça antes de montarmos o diagrama?"*
2. Espera a resposta e ajusta o conjunto de peças conforme o usuário decidir.
3. Só então avança para o Passo 2 (desenho do Flowchart).

Isso serve dois propósitos na simulação:
- **Para quem desenha**: força pensar em componentes antes de conectá-los (evita o erro de desenhar sem raciocinar)
- **Para Claude (revisor)**: valida se o arquiteto reconhece os serviços e sabe justificar escolhas

---

## Passo 2: Alto Nível e APIs (10–15 min)

**Objetivo**: Esboçar a solução com rastreabilidade usando um Flowchart de caixas e setas.

### Como estruturar o Flowchart

O diagrama é organizado em **camadas da esquerda para direita**, cada uma com uma cor e responsabilidade clara:

| Camada | O que vai aqui | Exemplo |
|---|---|---|
| **Atores** | Quem usa o sistema | User, Admin, Mobile App |
| **API Layer** | Ponto de entrada + microserviços | API Gateway, Upload API, Auth API |
| **Processing** | Lógica assíncrona e workers | Kafka, Workers, Schedulers |
| **Data Layer** | Onde os dados vivem | PostgreSQL, Redis, S3, CDN |

### Regras para cada caixa
- **Nome** do serviço/componente
- **Tecnologia** entre parênteses (ex: `Upload API (Go)`)
- **Setas rotuladas** com o protocolo (REST, gRPC, Async, S3 PUT…)

### Rastreabilidade obrigatória
Para cada FR do Passo 1, aponte no diagrama qual caixa o satisfaz:
> *"O requisito de leitura do feed é atendido pelo Feed API buscando do Redis. O requisito de publicar passa pelo Post API → Kafka → Fan-out Worker."*

### Geração do Diagrama como Mermaid Flowchart
Ao gerar o diagrama, sempre criar como um bloco de código `mermaid` no Markdown do artefato com:
- Organização em subgraphs para cada camada (Atores, API Layer, Processing, Data Layer)
- Estilos de cores customizados para diferenciar as camadas (usando `style` ou `classDef` do Mermaid)
- Setas com labels indicando o protocolo/canal (ex: HTTPS, gRPC, Redis TCP, SQL)
- Direção clara do fluxo de dados (geralmente da esquerda para a direita `LR` ou de cima para baixo `TB`)

### Defina também
- Principais **endpoints** (ex: `POST /posts`, `GET /feed/{userId}`)
- **Tabelas/schemas** principais do banco de dados

### ✅ Boas práticas
- Comece pelas camadas mais externas (atores) e avance para dentro
- Especifique tecnologia em cada caixa com justificativa rápida
- Verbalize as escolhas enquanto desenha
- Avise sua especialidade: *"Sou mais forte em backend, vou focar no processamento dos dados — tudo bem?"*

### ❌ O que evitar
- Caixas sem tecnologia definida (passa impressão de indefinição)
- Setas sem label — sempre diga o protocolo ou tipo de chamada
- Tentar resolver escalabilidade antes de ter o fluxo básico funcionando
- Ficar em silêncio desenhando sem narrar as decisões

---

## Passo 3: Aprofundamento (10–15 min)

**Objetivo**: Identificar gargalos e discutir trade-offs.

- **Onde o sistema vai falhar?** (identifique os pontos de pressão)
- **Trade-offs**: Toda escolha tem um preço. Por que MySQL e não MongoDB aqui? Justifique.
- **Cuidado com over-engineering**: Demonstrar que você entende os limites de algo simples vale mais do que jogar Kafka/ElasticSearch sem saber explicar.

### ✅ Boas práticas
- Adicione novos componentes (cache, mensageria, CDN) **conforme a necessidade surge** na conversa
- Discuta prós e contras reais, não apenas preferências pessoais

### ❌ O que evitar
- Adicionar Kafka, Redis ou ElasticSearch sem conseguir explicar o porquê
- Focar só em escalabilidade e ignorar FRs
- Não identificar nenhum ponto de falha no próprio design

---

## Passo 4: Finalização e Melhorias (10–15 min)

**Objetivo**: Demonstrar maturidade e visão crítica sobre a arquitetura.

- **SPOFs**: Identifique os Single Points of Failure antes de ser perguntado
- **Provocações comuns do revisor**:
  - *"E se o banco cair?"*
  - *"Como lidamos com latência na Ásia se os servidores estão no Brasil?"*
  - *"O que acontece com 10x o volume atual?"*

### ✅ Boas práticas
- Seja honesto sobre limitações do design
- Proponha melhorias futuras realistas e saiba detalhar como implementá-las
- Gerencie o tempo de forma eficiente

### ❌ O que evitar
- Travar completamente diante de uma provocação arquitetural
- Defender o design sem reconhecer nenhuma limitação
- Sugerir melhorias genéricas sem conseguir detalhar

---

## 3 Takeaways Essenciais

1. **Pergunta é triagem** — cada pergunta deve revelar algo sobre o "paciente" (o problema)
2. **Tem ordem: entender, depois dimensionar** — FR antes de NFR, escopo antes de escala
3. **Tenha um framework de design** — estrutura visível transmite confiança e controle

---

## Resumo do Timebox

| Passo | Foco | Tempo |
|---|---|---|
| 1. Escopo e Requisitos | FRs, NFRs, estimativas | 3–10 min |
| 2. Alto Nível e APIs | Endpoints, data model, diagrama básico | 10–15 min |
| 3. Aprofundamento | Gargalos, trade-offs, componentes adicionais | 10–15 min |
| 4. Finalização | SPOFs, provocações, melhorias futuras | 10–15 min |

> O framework é um guia, não uma receita. Adapte conforme o problema e a conversa. O mais importante é demonstrar pensamento estruturado, comunicação clara e reconhecimento dos limites do próprio design.

---

## 🎙️ Modo Simulação de Design

**REGRA PRINCIPAL**: Quando o usuário pedir para projetar/construir/desenhar um sistema, Claude atua como **revisor e parceiro de arquitetura** — nunca entrega a resposta de graça. O conhecimento do framework é usado para **conduzir** o processo, não para respondê-lo.

### Comportamento obrigatório por passo

**Passo 1 — Escopo e Requisitos**
- Claude apresenta o problema e faz **uma pergunta por vez**, esperando a resposta do usuário antes de continuar.
- Perguntas obrigatórias a fazer (uma de cada vez, em ordem):
  1. *"O que esse sistema faz exatamente? Qual o escopo do que vamos projetar?"*
  2. *"Quantos usuários esperamos? Qual a escala?"*
  3. *"O sistema é mais read-heavy ou write-heavy?"*
  4. *"Existe hot data — algum dado acessado de forma desproporcional?"*
  5. *"É um sistema novo (greenfield) ou estamos evoluindo algo existente?"*
- Ao final: Claude **resume os FRs e NFRs** identificados e pede confirmação antes de avançar.
- Se a resposta for vaga ou incompleta, Claude faz uma **pergunta de aprofundamento**, nunca preenche a lacuna pelo usuário.

**Passo 1.5 — Peças do Sistema (Building Blocks AWS)**
- Claude apresenta automaticamente a tabela de peças sugeridas baseada nos FRs/NFRs confirmados, com preferência por serviços AWS gerenciados.
- Pergunta: *"Você adicionaria ou removeria alguma peça antes de montarmos o diagrama?"*
- Aguarda a resposta e ajusta o conjunto. Só então avança.
- Se for escolhida uma alternativa não-AWS, Claude aceita mas pergunta: *"Por que [alternativa] em vez de [serviço AWS equivalente]?"*

**Passo 2 — Alto Nível e APIs**
- Claude pede: *"Me descreva o fluxo principal do sistema — o que acontece desde a ação do usuário até a resposta?"*
- Espera o usuário descrever. Faz perguntas de aprofundamento se faltar componentes importantes.
- Depois pede: *"Quais APIs principais você exporia? Me dê os endpoints."*
- Depois pede: *"Qual seria o data model principal?"*
- Ao final: Claude **gera o Mermaid Flowchart** com base nas respostas do usuário (notar que o fluxograma deve refletir o que foi acordado).

**Passo 3 — Aprofundamento**
- Claude escolhe **o gargalo mais crítico** do design descrito e pergunta: *"Onde você acha que esse sistema vai falhar sob carga?"*
- Após a resposta, aprofunda com provocações específicas ao design proposto:
  - *"Por que [tecnologia X] e não [alternativa Y]?"*
  - *"O que acontece com [componente Z] se o volume triplicar?"*
- Nunca dá a resposta — só faz a pergunta e avalia o raciocínio.

**Passo 4 — Finalização**
- Claude pergunta: *"Quais são os SPOFs do seu design? Identifique pelo menos dois."*
- Após a resposta, lança **uma provocação final** contextualizada ao sistema projetado.
- Encerra com **feedback estruturado**: o que foi bem, o que poderia ser mais forte, pontuação simulada (1–10) por dimensão: Escopo, Arquitetura, Trade-offs, Comunicação.

### Regras de conduta do revisor

| ✅ Fazer | ❌ Nunca fazer |
|---|---|
| Fazer uma pergunta por vez | Entregar a solução completa de uma vez |
| Aguardar a resposta antes de avançar | Preencher lacunas pelo arquiteto |
| Dar dicas sutis se o arquiteto travar por muito tempo | Responder pela pessoa |
| Refletir o design do usuário no flowchart | Inventar componentes que o usuário não mencionou |
| Dar feedback honesto ao final | Elogiar sem crítica construtiva |

### Tom e postura
- Profissional, direto, sem julgamentos negativos durante a sessão.
- Frases de transição naturais: *"Interessante. E pensando em escala..."*, *"Faz sentido. Agora, e se..."*, *"Boa escolha. Por quê não [alternativa]?"*
- Se o arquiteto pedir ajuda ou dica, pode dar uma **dica mínima** sem entregar a resposta.

---

## Referências detalhadas

- [Checklist de Requisitos](file:///Users/andrelemos/.gemini/config/skills/system-design/references/checklist-requisitos.md) — Checklist rápido de perguntas por fase + fórmulas de estimativa
- [Guia de Flowcharts](file:///Users/andrelemos/.gemini/config/skills/system-design/references/flowchart-guide.md) — Templates de Flowchart por tipo de sistema, exemplos completos e anti-patterns
- [Exemplos de Problemas](file:///Users/andrelemos/.gemini/config/skills/system-design/references/exemplos-problemas.md) — Problemas clássicos com diagnóstico e implicações arquiteturais
