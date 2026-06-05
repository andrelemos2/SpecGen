# Executar

**Objetivo**: Implementar UMA tarefa de cada vez. Alterações cirúrgicas. Verificar. Commit. Repetir.

É aqui que o código é escrito. Cada tarefa segue o mesmo ciclo: planejar → implementar → verificar → commit. A verificação é incorporada a cada tarefa, não sendo uma fase separada.

---

## OBRIGATÓRIO: Antes de Iniciar Qualquer Implementação

**Leia o [coding-principles.md](coding-principles.md) e declare:**

1. **Suposições** - O que estou assumindo? Alguma incerteza?
2. **Arquivos a alterar** - Liste APENAS os arquivos que esta tarefa exige
3. **Critérios de sucesso** - Como vou verificar que isso funciona?

⚠️ **Não prossiga sem declarar estes pontos explicitamente.**

---

## Processo

**Contexto do subagente:** Quando esta tarefa é executada por um subagente, ele recebe a definição da tarefa, os princípios de codificação, o TESTING.md e o contexto de especificação/design relevante. Todos os passos abaixo se aplicam de forma idêntica, seja rodando no contexto principal ou em um subagente. A única diferença: os subagentes reportam os resultados de volta ao orquestrador em vez de continuar para a próxima tarefa.

### 0. Listar Passos Atômicos (OBRIGATÓRIO quando a fase de Tarefas foi pulada)

Se não houver um `tasks.md` para esta funcionalidade, você DEVE listar os passos atômicos antes de escrever qualquer código. Isso é inegociável — evita que o agente perca o foco e faça coisas demais ao mesmo tempo.

```
## Plano de Execução

1. [Passo] → arquivos: [lista] → verificar: [como] → commit: [mensagem]
2. [Passo] → arquivos: [lista] → verificar: [como] → commit: [mensagem]
3. [Passo] → arquivos: [lista] → verificar: [como] → commit: [mensagem]
```

**Cada passo deve ser:**

- UM entregável (um componente, uma função, um endpoint, uma alteração de arquivo)
- Verificável de forma independente (pode provar que funciona antes de continuar)
- Comitável de forma independente (ganha seu próprio commit git atômico)

Se a listagem revelar >5 passos ou dependências complexas, PARE e crie um `tasks.md` formal. A fase de Tarefas foi pulada incorretamente.

### 1. Escolher a Tarefa

Do `tasks.md` (se existir) ou do plano de execução acima. O usuário especifica ("implementar T3") ou você sugere a próxima disponível.

### 2. Verificar Dependências

Se o `tasks.md` existir, verifique as dependências. Se estiver usando o plano inline, siga a ordem listada.

❌ Se estiver bloqueado: "T3 depende de T2, que não está concluída. Devo fazer a T2 primeiro?"

### 3. Declarar o Plano de Implementação

Antes de escrever o código:

```
Arquivos: [lista]
Abordagem: [breve descrição]
Sucesso: [como verificar]
```

### 4. Escrever os Testes Primeiro (RED - Vermelho)

Se a tarefa incluir testes (conforme o campo `Tests` no `tasks.md` ou a matriz de cobertura do `TESTING.md`):

1. Escreva o(s) arquivo(s) de teste ANTES de escrever qualquer implementação
2. Os testes devem refletir o comportamento esperado a partir dos critérios "Concluído quando" da tarefa
3. Execute o comando de teste — confirme que os testes FALHAM (estado RED)
4. Se os testes passarem antes de a implementação existir, eles estão muito fracos — reescreva-os

**Restrições:**

- Os testes definem o comportamento correto independentemente da implementação
- Cada critério de aceitação do "Concluído quando" deve se mapear para pelo menos uma asserção de teste
- Casos de borda do `spec.md` que se aplicam a esta tarefa também ganham casos de teste

Se a tarefa NÃO incluir testes (ex: apenas entidades ou arquivos de configuração), pule para o Passo 4b.

### 4b. Implementar (GREEN - Verde)

Escreva a implementação mínima necessária para satisfazer os critérios de sucesso da tarefa: passar em todos os testes relevantes (quando presentes) e atender às verificações/gate checks definidos quando não houver testes diretos.

**RESTRIÇÕES RÍGIDAS:**

- NÃO modifique os testes escritos no Passo 4. Os testes são a especificação — a implementação se conforma a eles.
- NÃO enfraqueça as asserções (tornando-as menos específicas para passar mais facilmente)
- NÃO delete ou pule casos de teste
- NÃO use o mecanismo skip/disable/pending do framework de teste para contornar testes que falham
- Código mínimo para passar — salve melhorias estruturais para uma tarefa de refatoração

Se um teste estiver genuinamente errado (testa o comportamento incorreto segundo a especificação), PARE e pergunte ao usuário antes de modificá-lo. Nunca altere um teste silenciosamente.

Siga o [coding-principles.md](coding-principles.md):

- Código mais simples que funciona
- Toque APENAS nos arquivos listados
- Sem desvio de escopo (scope creep)

### 5. Verificação de Gate (VERIFY)

Execute o comando de verificação de gate a partir da definição da tarefa. Isso é OBRIGATÓRIO — não "se aplicável".

1. Procure o comando para o nível de Gate da tarefa (quick/full/build) na seção de Comandos de Verificação de Gate do `TESTING.md`, depois execute-o
2. Código de saída diferente de zero = PARE. Corrija a falha. Execute novamente. Não prossiga até estar tudo verde.
3. Confirme se a contagem de testes corresponde às expectativas (nenhum teste foi deletado ou pulado silenciosamente)

**Gates em camadas (dos Comandos de Verificação de Gate do TESTING.md):**

| A tarefa inclui | Nível de Gate | O que executa |
| :--- | :--- | :--- |
| Apenas testes unitários | Rápido (Quick) | Comando de testes unitários |
| Testes E2E ou de integração | Completo (Full) | Comandos de testes unitários + E2E |
| Última tarefa em uma fase | Build | Build + lint + todos os testes |
| Sem testes (config, entidades, etc) | Build | Apenas build + lint |

A verificação de gate é determinística. O executor de testes decide se o código está correto, não a autoavaliação do agente.

### 6. Revisão Pós-Gate

Depois que a verificação de gate passar:

1. Verifique a contagem de testes: Há pelo menos a mesma quantidade de testes de antes? (evita deleção silenciosa)
2. Verifique se não há desvios da especificação (SPEC_DEVIATION): Se a implementação divergiu da especificação ou do design, adicione um marcador:

```
// SPEC_DEVIATION: [o que divergiu]
// Motivo: [por que o desvio foi necessário]
```

3. Verificação rápida de complexidade: "Um engenheiro sênior sinalizaria isso como supercomplicado?"
   - Sim → Simplifique, execute o gate novamente
   - Não → Prossiga para o commit

### 7. Commit Git Atômico

Cada tarefa ganha seu próprio commit imediatamente após a verificação. Nunca agrupe múltiplas tarefas em um único commit.

**Formato ([Commits Convencionais 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)):**

```
<tipo>(<escopo>): <descrição>

[corpo opcional]

[rodapé(s) opcional(is)]
```

**Tipos:**

| Tipo | Quando usar |
| :--- | :--- |
| `feat` | Nova funcionalidade ou capacidade |
| `fix` | Correção de bug |
| `refactor` | Alteração de código que não corrige um bug nem adiciona funcionalidade |
| `docs` | Apenas documentação |
| `test` | Adição ou correção de testes |
| `style` | Formatação, ponto e vírgula ausente, etc. (sem alteração de código) |
| `perf` | Melhoria de desempenho |
| `build` | Sistema de build ou dependências externas |
| `ci` | Arquivos e scripts de configuração de CI |
| `chore` | Tarefas de manutenção que não modificam arquivos src ou de teste |

**Escopo:** Nome da funcionalidade ou área do módulo, em letras minúsculas, ex: `auth`, `cart`, `api`

**Regras de descrição:**

- Modo imperativo ("adiciona", "corrige" - ex: "adiciona validação", "corrige bug")
- Primeira letra em minúscula
- Sem ponto final
- Deve completar a frase: "Se aplicado, este commit irá _[sua descrição]_"

**Mudanças drásticas (Breaking changes):** Adicione um `!` após o tipo/escopo E insira o rodapé `BREAKING CHANGE:`:

```
feat(api)!: altera o formato de resposta do endpoint de autenticação

BREAKING CHANGE: o endpoint de login agora retorna o JWT no corpo em vez de cookie
```

**Exemplos:**

```
feat(auth): adiciona validação de e-mail ao formulário de login
```

```
fix(cart): impede quantidade negativa no decremento do item
```

```
refactor(cart): extrai lógica de cálculo de imposto para o DiscountService

Move o cálculo de descontos e taxas adicionais do handler inline do checkout para
o DiscountService dedicado para reuso em múltiplos canais de venda.
```

**Regras:**

- Uma tarefa = um commit
- A descrição se refere ao que foi FEITO, não ao que foi planejado
- Inclua apenas arquivos listados na tarefa — nunca coloque alterações do tipo "já que estou aqui"
- Se os testes fizerem parte da tarefa, inclua-os no mesmo commit

### 8. Válvula de Segurança de Escopo

Durante a implementação, você notará coisas que poderiam ser melhoradas, refatoradas ou adicionadas. **Não aja sobre elas.** Em vez disso:

- Se for um bug: anote no `STATE.md` como um impedimento ou use o modo rápido
- Se for uma melhoria: anote no `STATE.md` em "Ideias Postergadas" ou "Lições Aprendidas"
- Se for relacionado à tarefa atual: inclua apenas se estiver nos critérios "Concluído quando"

**A heurística:** "Isso está na minha definição de tarefa?" Se não, não toque.

### 9. Atualizar Status da Tarefa

Marque a tarefa como concluída no `tasks.md`. Atualize a rastreabilidade dos requisitos no `spec.md` se IDs de requisitos forem usados.

---

## Template de Execução

```markdown
## Implementando T[X]: [Título da Tarefa]

**Lendo**: definição da tarefa de tasks.md
**Dependências**: [Todas concluídas? ✅ | Bloqueado por: TY]
**Testes**: [unit/e2e/integration/none]
**Gate**: [quick/full/build]

### Pré-Implementação (OBRIGATÓRIO)

- **Suposições**: [declare explicitamente]
- **Arquivos a alterar**: [liste APENAS estes]
- **Critérios de sucesso**: [como verificar]

### RED: Escrever Testes

- Arquivo(s) de teste: [caminhos]
- Contagem de testes: [N casos de teste]
- Falha confirmada: [Sim — todos os N testes falham como esperado]

### GREEN: Implementar

[Escreva o código mínimo para passar nos testes]

- Testes modificados: Nenhum
- Testes pulados/deletados: Nenhum

### VERIFY: Verificação de Gate

- Comando: [comando de gate check]
- Resultado: [X passaram, 0 falharam]
- Contagem de testes: [N — coincide com a contagem da fase RED]

### Pós-Gate

- [x] Sem desvios da especificação (SPEC_DEVIATION)
- [x] Sem alterações desnecessárias feitas
- [x] Segue os padrões existentes

**Status**: ✅ Concluído | ❌ Impedido | ⚠️ Parcial
```

---

## Dicas

- **Uma tarefa de cada vez** — O foco evita erros
- **Ferramentas importam** — MCP incorreto = abordagem incorreta
- **Reuso economiza tokens** — Copie padrões, não reinvente
- **Verifique antes de commitar** — Valide todos os critérios, depois faça o commit
- **Mantenha-se cirúrgico** — Toque apenas no que for necessário
- **Commit por tarefa** — Histórico git limpo permite busca fácil (bisect) e reversão
- **Nunca faça "já que estou aqui"** — O desvio de escopo durante a implementação é o principal assassino de qualidade
- **Aprenda com os erros** — Se algo der errado, adicione uma Lição Aprendida ao `STATE.md`
