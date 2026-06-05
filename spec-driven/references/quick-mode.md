# Modo Rápido (Quick Mode)

**Objetivo:** Executar tarefas pequenas e ad-hoc com os mesmos princípios de qualidade, mas sem toda a cerimônia do pipeline completo.

**Gatilho:** "Correção rápida", "Tarefa rápida", "Mudança pequena", "Correção de bug", "Apenas faça X" (ou termos equivalentes em inglês como "Quick fix", "Quick task", "Small change", "Bug fix").

## Quando Usar

| Use o modo rápido | Use o pipeline completo |
| :--- | :--- |
| Correções de bugs com causa conhecida | Novas funcionalidades com múltiplos casos de uso (stories) |
| Mudanças de configuração | Mudanças arquiteturais |
| Pequenos ajustes de interface (UI) | Funcionalidades que exigem decisões de design |
| Adicionar um campo/coluna | Funcionalidades multi-componentes |
| Scripts de uso único (one-off) | Qualquer coisa com escopo incerto |
| Atualizações de dependências | Funcionalidades que exigem user stories |

**Regra geral:** Se você puder descrever em uma frase E tocar em no máximo 3 arquivos (≤3), é uma tarefa rápida.

## Processo

### 1. Descrever a Tarefa

O usuário fornece uma descrição clara de uma frase. Se for vaga, peça especificidades:

- ❌ "Corrigir os cupons" → Pergunte: "O que está quebrado? O cupom não está aplicando, está aplicando o valor errado ou está dando erro?"
- ✅ "Correção: cupom de desconto fixo está permitindo que o total final da compra fique menor que zero"

### 2. Verificação Pré-Implementação

Antes de escrever o código, declare:

```
Tarefa Rápida: [descrição]
Arquivos: [liste APENAS os arquivos a alterar]
Abordagem: [uma frase]
Verificar: [como provar que funciona]
```

Obtenha a aprovação do usuário antes de prosseguir. Se a verificação pré-implementação revelar que a tarefa é maior do que o esperado (>3 arquivos, dependências incertas, decisões de design necessárias), recomende o pipeline completo.

### 3. Implementar

Siga o [coding-principles.md](coding-principles.md):

- Código mais simples que funciona
- Toque APENAS nos arquivos listados
- Sem desvio de escopo (scope creep) — corrija o problema, nada mais

### 4. Verificar

Execute a verificação declarada no passo 2. Marque como concluída apenas após a verificação passar.

### 5. Commit

Commit atômico seguindo os [Commits Convencionais 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/):

```
<tipo>(<escopo>): <descrição>
```

Use o modo imperativo, letra inicial minúscula e sem ponto final. Veja o [implement.md](implement.md) para a tabela completa de tipos.

Exemplos:

- `fix(cart): impede que desconto torne total do carrinho negativo`
- `feat(cart): adiciona campo de cupom na tela de pagamento`
- `chore(deps): atualiza pacote big.js de calculo monetario`

### 6. Rastreamento

Atualize o `.specs/project/STATE.md` com o registro da tarefa rápida (veja a seção Tarefas Rápidas no `state-management.md`).

---

## Estrutura

As tarefas rápidas residem separadas das funcionalidades planejadas:

```
.specs/
└── quick/
    └── NNN-slug/
        ├── TASK.md       # Descrição + verificação
        └── SUMMARY.md    # O que foi feito + commit
```

**Template do TASK.md:**

```markdown
# Tarefa Rápida NNN: [Título]

**Data:** [data]
**Status:** Concluído | Em Progresso | Bloqueado

## Descrição

[Uma frase: o quê e por quê]

## Arquivos Alterados

- `src/caminho/do/arquivo.ts` — [o que mudou]
- `src/caminho/do/outro.ts` — [o que mudou]

## Verificação

- [ ] [Como verificar se funciona]
- [ ] [Comportamento esperado após a correção]

## Commit

`[hash]` — [mensagem do commit]
```

---

## Diretrizes de Segurança (Guardrails)

- **Máximo de 3 arquivos** — Se for mais, use o pipeline completo
- **Máximo de 1 hora** — Se demorar mais, o escopo está incorreto
- **Sem decisões de design** — Se você estiver escolhendo entre abordagens estruturais, use o pipeline completo
- **Sem novas dependências** — Adicionar novos pacotes exige revisão do pipeline completo
- **Rastreie tudo** — Até mesmo tarefas rápidas ganham commits e entradas no `STATE.md`

---

## Dicas

- **Rápido ≠ desleixado** — Os mesmos princípios de codificação se aplicam, apenas com menos cerimônia
- **Na dúvida, use o completo** — É melhor planejar demais do que entregar código quebrado
- **Tarefas rápidas se acumulam** — Se você estiver fazendo mais de 5 tarefas rápidas na mesma área, ela se tornou uma funcionalidade que precisa de planejamento
- **Verifique antes de marcar como concluído** — O ponto principal é a qualidade, mesmo para tarefas pequenas
