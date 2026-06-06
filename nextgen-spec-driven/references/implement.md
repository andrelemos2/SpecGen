# Fase de Implementação (Executar)

O comando `implementar` é onde o código real é escrito, guiado pelo `tasks.md`.

## Fluxo de Implementação

1. **Ler o Plano**: Leia o arquivo `tasks.md` da feature atual.
2. **Identificar as Tarefas**: Encontre as próximas tarefas marcadas com `[ ]`.
3. **Delegar (Subagente)** ou **Fazer**: Se for paralelizável `[P]`, invoque um subagente contendo APENAS o escopo da tarefa atual para economizar tokens. Se não houver subagentes ou for simples, você mesmo executa.
4. **Verificar a Conclusão**: O código passa no linter? Compila? Os testes quebram? Se der erro, invoque OBRIGATORIAMENTE o padrão descrito em [continuous-learning.md](continuous-learning.md) seção "Reflect & Fix" antes de re-editar os arquivos.
5. **Aprender**: Se o código passar, mas receber feedback humano corretivo de um pull request ou review de código, você deve usar o padrão de **Sugestão** para possivelmente atualizar o `CONVENTIONS.md`.
6. **Atualizar Tarefas**: Marque a tarefa concluída com `[x]` no arquivo `tasks.md`.
7. **Iterar**: Vá para a próxima tarefa até concluir todas.

## Modo "Quick Mode" (Bypass)

Se o usuário fornecer uma tarefa muito simples (ex: "ajuste a margem do botão de login", "corrija esse TypeError"), o workflow não precisa criar arquivos de especificação ou tarefas. Você está autorizado a:
1. Ir direto ao arquivo alvo.
2. Ler apenas ele.
3. Fazer o patch/edição.
4. Finalizar o turno (mantendo o Reflect & Fix ativo em caso de erros).
