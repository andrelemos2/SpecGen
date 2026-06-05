# Gerenciamento de Estado

**Propósito:** Memória persistente entre sessões — decisões, impedimentos, aprendizados.

## Estrutura

**Entregável:** `.specs/project/STATE.md`

```markdown
# Estado

**Última Atualização:** [timestamp ISO]
**Trabalho Atual:** [Nome da funcionalidade] - [Identificador da tarefa]

---

## Decisões Recentes (Últimos 60 dias)

### AD-[NNN]: [Título da decisão] ([data])

**Decisão:** [O que foi decidido]
**Motivo:** [Por que esta escolha]
**Trade-off (Perda/Ganho):** [O que foi sacrificado]
**Impacto:** [Como isso afeta a implementação]

### AD-[NNN]: [Título da decisão] ([data])

[Mesma estrutura]

---

## Impedimentos Ativos

### B-[NNN]: [Descrição do impedimento]

**Descoberto em:** [Data]
**Impacto:** [Gravidade e escopo]
**Solução temporária:** [Solução temporária se disponível]
**Resolução:** [Caminho para correção definitiva]

---

## Lições Aprendidas

### L-[NNN]: [Descrição do aprendizado]

**Contexto:** [Situação que ocorreu]
**Problema:** [O que deu errado]
**Solução:** [Como foi resolvido]
**Previne:** [O que este conhecimento previne no futuro]

---

## Tarefas Rápidas Concluídas

| # | Descrição | Data | Commit | Status |
| :--- | :--- | :--- | :--- | :--- |
| 001 | [Descrição da tarefa rápida] | [data] | [hash] | ✅ Concluído |

---

## Ideias Postergadas

Ideias capturadas durante o trabalho que pertencem a funcionalidades ou fases futuras. Evita desvios de escopo (scope creep) ao mesmo tempo que preserva boas ideias.

- [ ] [Descrição da ideia] — Capturada durante: [funcionalidade/fase]
- [ ] [Descrição da ideia] — Capturada durante: [funcionalidade/fase]

---

## Todos (Tarefas a Fazer)

Capturar pensamentos em andamento e itens de ação que não se encaixam nas tarefas ativas.

- [ ] [TODO: item de ação]
- [ ] [TODO: item de ação]
```

## Quando Atualizar

| Evento | Ação |
| :--- | :--- |
| Escolha arquitetural significativa | Adicionar AD-[NNN] |
| Implementação bloqueada | Adicionar B-[NNN] |
| Descoberta/aprendizado importante | Adicionar L-[NNN] |
| Tarefa rápida concluída | Adicionar linha à tabela de Tarefas Rápidas |
| Desvio de escopo capturado | Adicionar às Ideias Postergadas |
| Pensamento em andamento | Adicionar aos Todos |
| Fim de sessão | Atualizar "Última Atualização" + "Trabalho Atual" |

## Gerenciamento de Tamanho (Estratégia Híbrida)

**Zonas:**

- 🟢 <7k tokens: Nenhuma ação
- 🟡 7-10k tokens: Nota de rodapé "STATE.md em [X]k. Limpeza recomendada."
- 🔴 >10k tokens: Prompt ativo "STATE.md crítico ([X]k). Limpar agora?"

**Processo de limpeza:**

- Mover decisões com mais de 60 dias para o `STATE-ARCHIVE.md`
- Manter apenas impedimentos ativos
- Preservar aprendizados recentes (<60 dias)

**Validação:**

- As decisões têm justificativa clara?
- Os impedimentos incluem caminho de resolução?
- Os aprendizados são acionáveis?

---

## Preferências

Rastrear o estado de comportamento voltado ao usuário no `STATE.md`:

```markdown
## Preferências

**Dica de Modelo Exibida:** [data ISO ou "never"]
```

**Atualizar quando:**

| Evento | Ação |
| :--- | :--- |
| Primeira dica de modelo dada | Definir data |
| Usuário reconhece/descarta | Manter data (não repetir) |

Isso previne sugestões repetitivas mantendo um comportamento natural e útil.
