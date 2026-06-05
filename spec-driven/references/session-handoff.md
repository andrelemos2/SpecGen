# Handoff de Sessão

## Pausar Trabalho

**Gatilho:** "Pausar trabalho", "Encerrar sessão", "Criar handoff" (ou equivalentes em inglês como "Pause work", "End session", "Create handoff").

**Propósito:** Registrar o estado atual como ponto de salvamento para retomada.

**Entregável:** `.specs/HANDOFF.md` (sobrescreve o anterior)

**Alvo de tamanho:** ~500 tokens

**Estrutura:**

```markdown
# Handoff

**Data:** [timestamp ISO]
**Funcionalidade:** [nome da funcionalidade]
**Tarefa:** [identificador da tarefa] - [status breve]

## Concluído ✓

- [Item de trabalho concluído]
- [Item de trabalho concluído]

## Em Progresso

- [Trabalho atual] ([porcentagem ou status])
- Localização específica: [arquivo:linha se aplicável]

## Pendente

- [Próximo passo imediato]
- [Passo seguinte]

## Impedimentos

- [Descrição do impedimento] - [impacto]

## Contexto

- Branch: [branch git se aplicável]
- Não comitados: [arquivos com alterações]
- Decisões relacionadas: [referências ao STATE.md se aplicável]
```

**Instruções:**

- Focar em informações acionáveis para a retomada
- Incluir referências específicas de arquivo/linha onde for relevante
- Anotar alterações não comitadas explicitamente
- Referenciar entradas relacionadas do STATE.md, se aplicável

## Retomar Trabalho

**Gatilho:** "Retomar trabalho", "Continuar", "Carregar handoff" (ou equivalentes em inglês como "Resume work", "Continue", "Load handoff").

**Processo:**

1. Carregar o HANDOFF.md
2. Carregar o STATE.md para contexto
3. Resumir a posição atual
4. Propor a próxima ação

**Padrão de resposta:**

- "Retomando [funcionalidade] em [tarefa]"
- "Concluído: [resumo]"
- "Próximo: [ação imediata]"
- "Continuar com [passo específico]?"
