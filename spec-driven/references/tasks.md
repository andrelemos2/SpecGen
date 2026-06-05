# Tarefas

**Objetivo**: Dividir em tarefas GRANULARES e ATÔMICAS. Dependências claras. Ferramentas certas. Plano de execução paralela.

**Pule esta fase quando:** Existirem ≤3 passos óbvios. Nesse caso, as tarefas são implícitas — vá direto para a Execução e liste-as inline no seu plano de implementação.

## Por que Tarefas Granulares?

| Tarefa Vaga (RUIM) | Tarefas Granulares (BOAS) |
| :--- | :--- |
| "Criar tela de cupons" | T1: Criar componente visual de input de cupom no carrinho |
| | T2: Adicionar tratamento de estados (sucesso, erro, carregando) no input |
| | T3: Adicionar botão de aplicar cupom |
| | T4: Exibir detalhamento da redução do subtotal na listagem do total |
| "Implementar cupons" | T1: Criar a interface e schemas do CouponService |
| | T2: Adicionar método de validação de data de expiração |
| | T3: Adicionar verificação de limite de uso cumulativo |
| | T4: Implementar cálculo de redução percentual e de valor fixo |

**Benefícios das granulares:**

- **Agentes não erram** — Foco único, sem ambiguidade
- **Fácil de testar** — Cada tarefa = um resultado verificável
- **Paralelizável** — Tarefas independentes rodam simultaneamente
- **Erros isolados** — Uma falha não bloqueia tudo

**Regra**: Uma tarefa = APENAS UM destes itens:

- Um componente
- Uma função
- Um endpoint de API
- Uma alteração de arquivo

---

## Processo

### 1. Revisar o Design

Leia o `.specs/[feature]/design.md` antes de criar as tarefas.

### 1.5. Carregar a Matriz de Cobertura de Testes

Leia o `.specs/codebase/TESTING.md` (se existir) antes de criar as tarefas. A Matriz de Cobertura de Testes e a Avaliação de Paralelismo conduzem duas decisões críticas:

**Testes co-localizados:** Toda tarefa que cria ou modifica uma camada de código com um tipo de teste obrigatório DEVE incluir a escrita/atualização desses testes na mesma tarefa. Testes NÃO são tarefas separadas.

| A tarefa cria... | Concluído Quando deve incluir... |
| :--- | :--- |
| Camada de código com requisito "unit" | Teste unitário escrito + verificação rápida (quick gate) passa |
| Camada de código com requisito "e2e" | Teste E2E escrito + verificação completa (full gate) passa |
| Camada de código com requisito "integration" | Teste de integração escrito + verificação completa (full gate) passa |
| Camada de código com requisito "none" | Verificação de gate no nível apropriado |

**Sinalizadores de paralelismo:** Cruze as informações da Avaliação de Paralelismo ao marcar tarefas como `[P]`:

- Se o tipo de teste obrigatório de uma tarefa estiver marcado como "Seguro para Paralelismo: Não" → remova a tag `[P]`
- Se o tipo de teste obrigatório de uma tarefa estiver marcado como "Seguro para Paralelismo: Sim" → a tag `[P]` é permitida
- Se uma tarefa não tiver testes → a tag `[P]` depende apenas das dependências do código

Se o `TESTING.md` não existir (projeto greenfield), pergunte ao usuário quais tipos de teste e comandos o projeto usará antes de criar as tarefas.

### 2. Dividir em Tarefas Atômicas

**Tarefa = UM entregável**. Exemplos:

- ✅ "Criar interface do UserService" (um arquivo, um conceito)
- ❌ "Implementar gerenciamento de usuários" (muito vago, múltiplos arquivos)

### 3. Definir Dependências

O que DEVE ser feito antes que esta tarefa possa ser iniciada?

### 4. Criar o Plano de Execução

Agrupe as tarefas em fases. Identifique o que pode rodar em paralelo.

### 5. Validar Antes de Apresentar (OBRIGATÓRIO)

Antes de mostrar as tarefas para o usuário, execute TODOS os três testes de pré-aprovação. Eles NÃO são opcionais — são gates de validação. Se qualquer verificação falhar, reestruture as tarefas e execute novamente até que todas passem.

**Verificação 1: Granularidade das Tarefas** — verifique se cada tarefa é atômica (ver seção Verificação de Granularidade).

**Verificação 2: Validação Cruzada entre Diagrama e Definições** — verifique se o diagrama de execução coincide com o campo `Depends on` de cada tarefa (ver seção Validação Cruzada). Monte a tabela correspondente e inclua-a no entregável.

**Verificação 3: Validação de Co-localização de Testes** — verifique se o campo `Tests` de cada tarefa coincide com a matriz de cobertura do `TESTING.md` (ver seção Co-localização de Testes). Monte a tabela correspondente e inclua-a no entregável.

**Exiba ambas as tabelas junto com as tarefas** para que o usuário possa visualizar os resultados da validação. Qualquer ❌ significa que você DEVE reestruturar antes de apresentar — não mostre tarefas falhas ao usuário esperando aprovação.

### 6. PERGUNTAR sobre MCPs e Skills

**CRÍTICO**: Antes da execução, pergunte ao usuário:

> "Para cada tarefa, quais ferramentas devo usar?"
>
> **MCPs Disponíveis**: [lista do projeto ou do usuário]
> **Skills Disponíveis**: [lista do projeto ou do usuário]

---

## Template: `.specs/[feature]/tasks.md`

```markdown
# Tarefas de [Funcionalidade]

**Design**: `.specs/[feature]/design.md`
**Status**: Rascunho | Aprovado | Em Progresso | Concluído

---

## Plano de Execução

### Fase 1: Fundação (Sequencial)

Tarefas que devem ser feitas primeiro, em ordem.

T1 → T2 → T3

### Fase 2: Implementação Principal (Paralelismo OK)

Após a fundação, estas tarefas podem rodar em paralelo.

     ┌→ T4 ─┐
T3 ──┼→ T5 ─┼──→ T8
     └→ T6 ─┘
T7 ──────→

### Fase 3: Integração (Sequencial)

Unindo todas as partes.

T8 → T9

---

## Detalhamento das Tarefas

### T1: [Criar Interface X]

- **O quê**: [Uma frase: entregável exato]
- **Onde**: `src/caminho/do/arquivo.ts`
- **Depende de**: Nenhum
- **Reaproveita**: `src/existente/BaseInterface.ts`
- **Requisito**: [FEAT]-01
- **Ferramentas**:
  - MCP: `filesystem` (ou NONE)
  - Skill: NONE
- **Concluído quando**:
  - [ ] Interface definida com todos os métodos do design
  - [ ] Tipos exportados corretamente
  - [ ] Sem erros de TypeScript
- **Testes**: [unit/e2e/integration/none — da matriz de cobertura]
- **Gate**: [quick/full/build — dos comandos de verificação de gate]

---

### T2: [Implementar Serviço Y] [P]

- **O quê**: [Entregável exato]
- **Onde**: `src/services/YService.ts`
- **Depende de**: T1
- **Reaproveita**: Padrões de `src/services/BaseService.ts`
- **Ferramentas**:
  - MCP: `filesystem`, `context7`
  - Skill: NONE
- **Concluído quando**:
  - [ ] Implementa a interface da T1
  - [ ] Trata cenários de erro do design
  - [ ] Verificação de gate passa: `[comando de gate rápido do TESTING.md]`
  - [ ] Contagem de testes: [N] testes passam (sem deleções silenciosas)
- **Testes**: unit
- **Gate**: quick

---

### T3: [Criar Componente Z] [P]

- **O quê**: [Entregável exato]
- **Onde**: `src/components/ZComponent.tsx`
- **Depende de**: T1
- **Reaproveita**: `src/components/BaseComponent.tsx`
- **Ferramentas**:
  - MCP: `filesystem`
  - Skill: NONE
- **Concluído quando**:
  - [ ] Componente renderiza corretamente
  - [ ] Manipula props da interface
  - [ ] Segue padrões de componentes existentes
  - [ ] Verificação de gate passa: `[comando de gate rápido do TESTING.md]`
  - [ ] Contagem de testes: [N] testes passam (sem deleções silenciosas)
- **Testes**: unit
- **Gate**: quick

---

### T4: [Adicionar Funcionalidade A ao Y]

- **O quê**: [Entregável exato]
- **Onde**: `src/services/YService.ts` (modificar)
- **Depende de**: T2, T3
- **Reaproveita**: Padrões de serviço existentes
- **Ferramentas**:
  - MCP: `filesystem`, `github`
  - Skill: `api-design`
- **Concluído quando**:
  - [ ] Funcionalidade atende aos critérios de aceitação
  - [ ] Verificação de gate passa: `[comando de gate completo do TESTING.md]`
  - [ ] Contagem de testes: [N] testes passam (sem deleções silenciosas)
- **Testes**: integration
- **Gate**: full
- **Commit**: `feat([scope]): [descrição]`

---

## Mapa de Execução Paralela

Representação visual do que pode rodar simultaneamente:

```
Fase 1 (Sequencial):
  T1 ──→ T2 ──→ T3

Fase 2 (Paralela):
  T3 concluída, então:
    ├── T4 [P]
    ├── T5 [P]  } Podem rodar simultaneamente
    └── T6 [P]

Fase 3 (Sequencial):
  T4, T5, T6 concluídas, então:
    T7 ──→ T8
```

**Restrição de paralelismo:** Uma tarefa marcada com `[P]` deve cumprir TODOS os seguintes requisitos:

- Nenhuma dependência inacabada
- O tipo de teste obrigatório é seguro para paralelismo (segundo a Avaliação de Paralelismo do TESTING.md)
- Nenhum estado mutável compartilhado com outras tarefas `[P]` na mesma fase

Se os testes de uma tarefa NÃO forem seguros para paralelismo, ela DEVE rodar de forma sequencial, mesmo que o código da sua implementação não tenha dependências. A execução de testes é o gargalo.

**Como funciona a execução paralela:**

As tarefas marcadas como `[P]` são executadas via subagentes — um subagente por tarefa, iniciados simultaneamente. Cada subagente recebe apenas a sua definição de tarefa e o contexto do projeto relevante (veja Delegação de Subagentes no SKILL.md). O agente orquestrador aguarda a conclusão de todos os subagentes de uma fase antes de avançar para a próxima.

As tarefas sequenciais (sem `[P]`) também são delegadas a subagentes, porém uma por vez. Isso mantém os artefatos de implementação (leituras de arquivos, saídas de testes, logs de gate) fora do contexto principal.

**O papel do agente orquestrador durante a Execução:**
1. Escolher a(s) próxima(s) tarefa(s) para execução
2. Fornecer a cada subagente sua definição de tarefa + contexto
3. Monitorar a conclusão dos subagentes
4. Atualizar o tasks.md com os resultados
5. Decidir se deve prosseguir, corrigir ou escalar

---

## Verificação de Granularidade das Tarefas

Antes de aprovar as tarefas, verifique se são granulares o suficiente:

| Tarefa | Escopo | Status |
| :--- | :--- | :--- |
| T1: Criar input de cupom | 1 componente | ✅ Granular |
| T2: Adicionar validação de expiração | 1 função | ✅ Granular |
| T3: Criar regras de validação, cálculo e tela | 3+ arquivos/responsabilidades | ❌ Divida-a! |
| T4: Conectar à API de cupom | 1 função | ✅ Granular |

**Verificação de granularidade**:

- ✅ 1 componente / 1 função / 1 endpoint = Bom
- ⚠️ 2 a 3 coisas relacionadas no mesmo arquivo = OK se houver forte coesão
- ❌ Múltiplos componentes ou arquivos = DEVE dividir

---

## Validação Cruzada entre Diagrama e Definições

Antes de aprovar as tarefas, verifique se o diagrama de execução está consistente com as definições das tarefas. Tratam-se de artefatos independentes que podem divergir — o diagrama é desenhado para clareza visual, enquanto os corpos das tarefas são escritos para precisão. Ambos devem coincidir.

Para cada tarefa, verifique:

| Tarefa | Depende De (corpo da tarefa) | Diagrama Mostra | Status |
| :--- | :--- | :--- | :--- |
| T[N] | [deps do corpo] | [deps das setas do diagrama] | ✅ Coincide ou ❌ Diverge |

**Regras:**

- Cada `Depends on` no corpo de uma tarefa deve ter uma seta correspondente no diagrama.
- Cada seta no diagrama deve corresponder a um `Depends on` no corpo da tarefa de destino.
- Tarefas exibidas como paralelas (`[P]`) no diagrama não podem depender umas das outras.
- Se uma tarefa depender de outra na mesma fase paralela, elas NÃO são paralelas — corrija o diagrama ou remova a tag `[P]`.

---

## Validação de Co-localização de Testes

Antes de aprovar as tarefas, verifique se o campo `Tests` de CADA tarefa está consistente com a Matriz de Cobertura do `TESTING.md`. Este é um gate rígido — tarefas que falharem nesta verificação DEVEM ser corrigidas.

Para cada tarefa, verifique: a tarefa cria ou modifica uma camada de código que possui um tipo de teste obrigatório na matriz de cobertura? Se sim, o campo `Tests` da tarefa DEVE coincidir.

| Tarefa | Camada de Código Criada/Modificada | Matriz Exige | A Tarefa Diz | Status |
| :--- | :--- | :--- | :--- | :--- |
| T[N]: [nome] | [camada da matriz de cobertura] | [tipo de teste] | [campo Tests da tarefa] | ✅ OK ou ❌ VIOLAÇÃO |

**Regras:**

- "Testado em outra tarefa" NÃO é uma justificativa válida para `Tests: none`. Isso é adiamento de testes — exatamente o antipadrão que esta validação evita.
- `Tests: none` só é válido quando a matriz de cobertura diz "none" para aquela camada de código.
- Se uma tarefa cria MÚLTIPLAS camadas de código (ex: serviço + controller), use o tipo de teste MAIS ALTO exigido por qualquer uma delas.
- Qualquer ❌ VIOLAÇÃO → reestruture a tarefa para incluir os testes obrigatórios antes de prosseguir.

**Resolução de dependências de compilação:**

Quando uma tarefa cria código que não pode ser testado até que uma tarefa posterior seja concluída (ex: um controller que precisa de configuração de módulo antes de seus testes e2e rodarem), NÃO adie os testes para uma tarefa separada. Em vez disso, reestruture:

1. **Mesclar para frente (Merge forward):** Mova os testes da tarefa não testável para a tarefa mais próxima em que se tornem executáveis (ex: a tarefa de configuração de módulo inclui a fiação + os testes e2e do controller que ela ativa).
2. **Mesclar para trás (Merge backward):** Absorva a dependência de bloqueio na tarefa atual para que ela se torne testável por si mesma (ex: a tarefa do controller inclui sua própria declaração/registro de módulo).

Escolha a opção que mantiver as tarefas mais atômicas e coesas. O objetivo: nenhuma tarefa produz código não verificado. Se o código não puder ser testado na tarefa que o cria, os limites da tarefa estão incorretos.

---

## Dicas

- **[P] = Paralelismo OK** — Marque tarefas que podem rodar simultaneamente
- **Reaproveitamento = Economia de tokens** — Sempre referencie códigos existentes
- **Ferramentas por tarefa** — MCPs e Skills evitam abordagens incorretas
- **Dependências são gates** — Defina claramente o que bloqueia o quê
- **Concluído quando = Testável** — Se você não conseguir verificar, reescreva
- **ID de requisito = Rastreável** — Toda tarefa se conecta a um requisito do spec
- **Um commit por tarefa** — Planeje o formato da mensagem do commit antecipadamente

---

## Padrões de Verificação de Tarefas

Toda tarefa DEVE incluir:

**Checklist "Concluído quando":**

- Resultados específicos e testáveis
- Critérios de sucesso binários (passou/falhou)
- O comando de teste específico da tabela de Comandos de Gate Check
- Contagem esperada de testes que passam (evita deleção silenciosa)

**Seção "Verificar":**

- Comandos para provar a funcionalidade
- Resultados esperados
- Indicadores de sucesso

**Estrutura:**

```markdown
### T1: [Nome da tarefa]

- **O quê:** [Entregável]
- **Onde:** [Caminho do arquivo]
- **Testes**: [unit/e2e/integration/none]
- **Gate**: [quick/full/build]
- **Concluído quando:**
  - [ ] [Resultado específico]
  - [ ] [Resultado específico]
  - [ ] Verificação de gate passa: `[comando dos Comandos de Gate Check]`
  - [ ] Contagem de testes: [N] testes passam (sem deleções silenciosas)
- **Verificar:**
  [Comando para provar que funciona]
  [Resultado/comportamento esperado]
```

**Verificação de qualidade:**

- A tarefa pode ser verificada sem julgamento humano?
- O critério de sucesso é binário (passa/falha)?
- A verificação pode ser automatizada?
```
