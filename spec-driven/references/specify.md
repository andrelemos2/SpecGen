# Especificar

**Objetivo**: Capturar O QUE construir com requisitos testáveis e rastreáveis.

Se a funcionalidade possuir áreas cinzentas ambíguas (múltiplas abordagens válidas para comportamento voltado ao usuário), o agente disparará automaticamente o processo de [discutir áreas cinzentas](discuss.md) dentro desta fase. Para funcionalidades claras e bem definidas, vai direto para a próxima fase.

## Processo

### 1. Esclarecer Requisitos

Você é um parceiro de pensamento, não um entrevistador. Comece de forma aberta — deixe o usuário expor seu modelo mental. Siga a energia: no que ele enfatizar, aprofunde-se.

Pergunte de forma conversacional (não como um checklist):

- "Qual problema você está resolvendo?"
- "Quem é o usuário e qual é a dor dele?"
- "Como é o sucesso?"

Se necessário:

- "Quais são as restrições (tempo, tecnologia, recursos)?"
- "O que está explicitamente fora do escopo?"

**Questione a imprecisão.** Nunca aceite respostas vagas. "Bom" significa o quê? "Usuários" significa quem? "Simples" significa como? Torne o abstrato concreto: "Explique-me passo a passo como usar isso." "Como isso realmente se parece?"

**Saiba quando parar.** Quando você entender o que está sendo construído, por que, para quem é e como se parece a conclusão — ofereça para prosseguir.

### 2. Capturar Histórias de Usuário (User Stories) com Prioridades

**P1 = MVP** (deve ser entregue), **P2** (deveria ter), **P3** (desejável ter)

Cada história DEVE ser **testável de forma independente** — você pode implementar e demonstrar apenas aquela história.

### 3. Escrever Critérios de Aceitação

Use o formato **QUANDO/ENTÃO/DEVE** — é preciso e testável:

- QUANDO [evento/ação] ENTÃO [sistema] DEVE [resposta/comportamento]

---

## Template: `.specs/[feature]/spec.md`

```markdown
# Especificação de [Nome da Funcionalidade]

## Descrição do Problema

[Descreva o problema em 2 ou 3 frases. Qual dor estamos resolvendo? Por que agora?]

## Objetivos

- [ ] [Objetivo principal com resultado mensurável]
- [ ] [Objetivo secundário com resultado mensurável]

## Fora do Escopo

Explicitamente excluído. Documentado para evitar desvios de escopo (scope creep).

| Funcionalidade | Motivo |
| :--- | :--- |
| [Funcionalidade X] | [Por que foi excluída] |
| [Funcionalidade Y] | [Por que foi excluída] |

---

## Histórias de Usuário

### P1: [Título da História] ⭐ MVP

**História de Usuário**: Como [papel], quero [capacidade] para que [benefício].

**Por que P1**: [Por que isso é crítico para o MVP]

**Critérios de Aceitação**:

1. QUANDO [ação/evento do usuário] ENTÃO o sistema DEVE [comportamento esperado]
2. QUANDO [ação/evento do usuário] ENTÃO o sistema DEVE [comportamento esperado]
3. QUANDO [caso de borda] ENTÃO o sistema DEVE [tratamento gracioso]

**Teste Independente**: [Como verificar esta história de forma isolada - ex: "Pode ser demonstrado fazendo X e visualizando Y"]

---

### P2: [Título da História]

**História de Usuário**: Como [papel], quero [capacidade] para que [benefício].

**Por que P2**: [Por que isso não é MVP, mas ainda é importante]

**Critérios de Aceitação**:

1. QUANDO [evento] ENTÃO o sistema DEVE [comportamento]
2. QUANDO [evento] ENTÃO o sistema DEVE [comportamento]

**Teste Independente**: [Como verificar]

---

### P3: [Título da História]

**História de Usuário**: Como [papel], quero [capacidade] para que [benefício].

**Por que P3**: [Por que isso é desejável (nice-to-have)]

**Critérios de Aceitação**:

1. QUANDO [evento] ENTÃO o sistema DEVE [comportamento]

---

## Casos de Borda

- QUANDO [condição limite] ENTÃO o sistema DEVE [comportamento]
- QUANDO [cenário de erro] ENTÃO o sistema DEVE [tratamento gracioso]
- QUANDO [entrada inesperada] ENTÃO o sistema DEVE [resposta de validação]

---

## Rastreabilidade de Requisitos

Cada requisito ganha um ID exclusivo para rastreamento em design, tarefas e validação.

| ID do Requisito | História | Fase | Status |
| :--- | :--- | :--- | :--- |
| [FEAT]-01 | P1: [História] | Design | Pendente |
| [FEAT]-02 | P1: [História] | Design | Pendente |
| [FEAT]-03 | P2: [História] | - | Pendente |

**Formato do ID:** `[CATEGORIA]-[NÚMERO]` (ex: `CART-01`, `CART-02`, `DISC-03`)

**Valores de status:** Pendente → Em Design → Em Tarefas → Implementando → Verificado

**Cobertura:** X total, Y mapeados para tarefas, Z não mapeados ⚠️

---

## Critérios de Sucesso

Como sabemos que a funcionalidade é bem-sucedida:

- [ ] [Resultado mensurável - ex: "O usuário consegue concluir X em < 2 minutos"]
- [ ] [Resultado mensurável - ex: "Zero erros no cenário Y"]
```

---

## Dicas

- **P1 = Fatia Vertical** — Uma funcionalidade completa e demonstrável, não apenas backend ou frontend
- **QUANDO/ENTÃO é código** — Se você não puder escrever o critério como um teste, reescreva-o
- **IDs de requisitos são obrigatórios** — Cada história mapeia para IDs rastreáveis
- **Casos de borda importam** — O que quebra? O que está vazio? O que é gigante?
- **Fora do Escopo previne o creeping** — Se não estiver listado aqui, não será construído
- **Confirme antes de Discutir** — O usuário deve aprovar a especificação antes de avançar para a fase de discussão
