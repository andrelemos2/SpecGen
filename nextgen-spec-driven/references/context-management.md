# Gestão de Contexto On-Demand (Redução de Tokens)

Tokens são valiosos. Carregar a base de código inteira ou todas as especificações num chat polui o raciocínio da IA, causa alucinações e custa caro. Esta skill impõe regras estritas de "Context Budgeting".

## Regras de Leitura de Arquivos

1. **Nunca leia múltiplos `.md` de uma vez desnecessariamente.**
   - Se você estiver na fase de `especificar`, leia o `ROADMAP.md` e os requisitos, mas NÃO carregue o `ARCHITECTURE.md`.
   - Se estiver focado na `Tarefa 1.1`, leia APENAS os arquivos de código diretamente mencionados nessa tarefa e o `.specs/features/.../tasks.md`.
2. **Proibição de Comandos Amplos:** Não use `cat` (ou leitura equivalente) em diretórios inteiros. Utilize ferramentas específicas (`glob`, `grep`) para buscar apenas o que precisa.
3. **Descarregamento:** Se uma documentação não for mais útil para a sessão de trabalho atual, não a re-resuma na conversa.

## Contexto para Subagentes (Delegação Paralela)

A maior economia ocorre na delegação para Subagentes (para tarefas assinaladas com `[P]`).
O agente orquestrador **NUNCA** deve passar o log completo do chat para a instância do subagente.

**A instrução ao Subagente deve conter:**
- O título da tarefa e sua descrição curta.
- Arquivos de entrada necessários.
- Regra ou convenção específica daquela tarefa (extraída do `CONVENTIONS.md`).
- Critérios de aceitação para o subagente saber quando terminou.

O subagente devolverá apenas um "DONE" ou o erro. Isso mantém a janela do orquestrador livre do ruído da tentativa e erro de compilação de código.
