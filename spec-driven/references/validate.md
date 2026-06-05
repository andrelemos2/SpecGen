# Executar: Validar e Verificar

**Objetivo**: Verificar se a implementação atende à especificação E aos princípios de codificação. Isso NÃO é uma fase separada — a verificação faz parte da conclusão de cada tarefa dentro de Executar.

**Dois níveis de verificação:**

1. **Verificação por tarefa (sempre):** Após implementar cada tarefa, verifique seus critérios "Concluído quando" antes de commitar. Isso é obrigatório e automático.

2. **Validação a nível de funcionalidade (na conclusão ou sob demanda):** Depois que todas as tarefas de uma funcionalidade (ou grupo prioritário) estiverem concluídas, execute uma validação abrangente. Inclui a verificação dos critérios de aceitação, revisão da qualidade do código e, opcionalmente, UAT interativo.

**O UAT interativo é disparado quando:** A funcionalidade tem comportamento complexo voltado ao usuário, no qual o julgamento humano importa (fluxos de interface, padrões de interação, design visual). Para trabalhos focados apenas em backend ou infraestrutura, as verificações automatizadas são suficientes.

**Gatilho para validação explícita:** "Validar", "verificar trabalho", "UAT", "testar comigo", "passo a passo" (ou termos equivalentes em inglês como "Validate", "verify work", "UAT", "test with me", "walk me through it").

---

## Processo

### 1. Verificar Tarefas Concluídas

Percorra o `tasks.md`:

- [ ] Todas as tarefas marcadas como concluídas?
- [ ] Alguma impedida ou parcial?

### 2. Verificar Critérios de Aceitação

Para cada história de usuário no `spec.md`:

```markdown
### P1: [Título da História]

**Critérios de Aceitação**:

1. QUANDO [X] ENTÃO [Y] → [PASSOU/FALHOU]
2. QUANDO [X] ENTÃO [Y] → [PASSOU/FALHOU]
```

### 3. Verificar Casos de Borda

A partir dos casos de borda do `spec.md`:

- [ ] [Caso de borda 1] tratado corretamente
- [ ] [Caso de borda 2] tratado corretamente

### 4. Executar Verificação de Gate no Nível do Build (OBRIGATÓRIO)

Execute a verificação de gate no nível do Build a partir do `TESTING.md`. Isso NÃO é opcional.

Se o `TESTING.md` não existir (projeto greenfield), use o comando de gate acordado com o usuário durante a fase de Tarefas.

1. Execute: `[comando de gate do build do TESTING.md, ou o comando acordado durante o planejamento]`
2. Código de saída diferente de zero = PARE. Não prossiga para a Verificação de Qualidade do Código.
3. Registre os resultados:
   - Contagem total de testes: [N]
   - Passaram: [N]
   - Falharam: [lista]
   - Pulados (Skipped): [lista — cada teste pulado deve ser justificado]

**Verificação de Integridade dos Testes:**

- Compare a contagem de testes atual com a contagem anterior à implementação desta funcionalidade
- Se a contagem de testes DIMINUIU: investigue o motivo. Testes só devem ser excluídos com justificativa explícita.
- Se as asserções foram enfraquecidas (menos específicas que antes): sinalize como regressão potencial

### 5. Verificação de Qualidade do Código (OBRIGATÓRIO)

Para cada arquivo alterado, verifique em relação ao [coding-principles.md](coding-principles.md):

| Verificação | Passou? |
| :--- | :--- |
| Nenhuma funcionalidade além do solicitado | |
| Nenhuma abstração para código de uso único | |
| Nenhuma "flexibilidade" desnecessária adicionada | |
| Apenas alterou arquivos exigidos para a tarefa | |
| Não "melhorou" código não relacionado | |
| Segue padrões/estilo existentes | |
| Um engenheiro sênior aprovaria? | |

❌ Qualquer "Não"? → Corrija antes de marcar como concluído.

### 6. UAT Interativo (se funcionalidade voltada ao usuário)

Para cada entregável testável, apresente um teste de cada vez:

```
Teste [N]: [Nome do Teste]

Esperado: [O que deve acontecer — específico e observável]

→ Isso funciona? Descreva o que você vê.
```

Aguarde a resposta do usuário:

| O usuário diz | Interpretar como |
| :--- | :--- |
| "sim", "passou", "funciona", "próximo" | ✅ Passou |
| "pular", "não posso testar", "n/a" | ⏭️ Pular |
| Qualquer outra coisa | ❌ Problema — registrar literalmente |

**Inferência de gravidade (nunca pergunte ao usuário a gravidade):**

| A descrição do usuário contém | Gravidade inferida |
| :--- | :--- |
| crash, erro, exceção, falha, quebrado | Impedimento (Blocker) |
| não funciona, incorreto, ausente, não consigo | Grave (Major) |
| lento, estranho, esquisito, menor, pequeno | Leve (Minor) |
| cor, fonte, espaçamento, alinhamento, visual | Cosmética (Cosmetic) |
| (não está claro) | Grave (padrão) |

### 7. Gerar Planos de Correção (se problemas forem encontrados)

Para cada problema encontrado durante o UAT:

1. **Diagnosticar** — Analise a base de código para encontrar a causa raiz
2. **Criar tarefa de correção** — Escreva uma definição de tarefa com:
   - O quê: A correção específica
   - Onde: Caminhos de arquivo
   - Verificar: Como provar que a correção funciona
   - Concluído quando: Critérios de aceitação para a correção
3. **Apresentar plano de correção** — Mostre todas as tarefas de correção ao usuário para aprovação

As tarefas de correção seguem o mesmo formato que as tarefas regulares e podem ser executadas junto com a fase de implementação.

**Diretriz de Segurança:** Máximo de 3 iterações de diagnóstico por problema. Se a causa raiz não for encontrada após 3 tentativas, sinalize para investigação humana.

### 8. Relatório

---

## Template do Relatório de Validação

```markdown
# Validação de [Funcionalidade]

**Data**: [AAAA-MM-DD]
**Especificação**: `.specs/features/[feature]/spec.md`

---

## Conclusão de Tarefas

| Tarefa | Status | Notas |
| :--- | :--- | :--- |
| T1 | ✅ Concluído | - |
| T2 | ✅ Concluído | - |
| T3 | ⚠️ Parcial | [Problema] |

---

## Validação de Histórias de Usuário

### P1: [Título da História] ⭐ MVP

| Critério | Resultado |
| :--- | :--- |
| QUANDO X ENTÃO Y | ✅ PASSOU |
| QUANDO A ENTÃO B | ✅ PASSOU |

**Status**: ✅ P1 Concluído

### P2: [Título da História]

| Critério | Resultado |
| :--- | :--- |
| QUANDO X ENTÃO Y | ❌ FALHOU - [motivo] |

**Status**: ⚠️ Problemas no P2

---

## Resultados do UAT Interativo (se realizado)

| # | Teste | Resultado | Detalhes |
| :--- | :--- | :--- | :--- |
| 1 | [Nome do teste] | ✅ Passou | - |
| 2 | [Nome do teste] | ❌ Problema | [Resposta literal do usuário] — Gravidade: [inferida] |
| 3 | [Nome do teste] | ⏭️ Pular | [Motivo] |

---

## Qualidade do Código

| Princípio | Status |
| :--- | :--- |
| Código mínimo | ✅ |
| Alterações cirúrgicas | ✅ |
| Sem desvio de escopo | ✅ |
| Segue padrões | ✅ |

---

## Casos de Borda

- [x] Caso de borda 1: Tratado corretamente
- [ ] Caso de borda 2: NÃO tratado - precisa de correção

---

## Testes

- **Comando de gate**: [comando completo]
- **Resultado**: [X] passaram, [Y] falharam, [Z] pulados
- **Contagem de testes antes da funcionalidade**: [N]
- **Contagem de testes depois da funcionalidade**: [M]
- **Diferença**: [+(M - N) novos testes]
- **Testes pulados**: [lista com justificativa para cada um]
- **Falhas**: [lista com detalhes]

---

## Planos de Correção (se problemas forem encontrados)

### Correção 1: [Descrição do problema]

- **Causa raiz**: [O que está realmente errado]
- **Tarefa de correção**: [Definição da tarefa]
- **Prioridade**: [Impedimento/Grave/Leve/Cosmética]

---

## Atualização de Rastreabilidade de Requisitos

Atualizar os status de requisitos no `spec.md`:

| Requisito | Status Anterior | Novo Status |
| :--- | :--- | :--- |
| [FEAT]-01 | Implementando | ✅ Verificado |
| [FEAT]-02 | Implementando | ❌ Precisa de Correção |

---

## Resumo

**Geral**: ✅ Pronto | ⚠️ Problemas | ❌ Não Pronto

**O que funciona**: [Lista]

**Problemas encontrados**: [Problema 1: Como corrigir]

**Próximos passos**: [Ação]
```

---

## Dicas

- **P1 primeiro** — O MVP deve funcionar antes do P2/P3
- **QUANDO/ENTÃO = Teste** — Cada critério é um caso de teste
- **Seja específico** — "Não funciona" não ajuda
- **Recomende correções** — Não apenas reporte problemas, crie tarefas de correção
- **A checagem de qualidade é obrigatória** — Não opcional
- **Infira a gravidade** — Nunca pergunte ao usuário "quão ruim é isso?"
- **Máximo de 3 iterações diagnósticas** — Previne loops infinitos de investigação
- **Atualize a rastreabilidade** — Cada requisito verificado atualiza o status no `spec.md`
