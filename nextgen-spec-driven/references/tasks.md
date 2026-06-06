# Fase de Criação de Tarefas

O propósito da fase de Tarefas é pegar o `design.md` e quebrá-lo em passos de execução atômicos e roteáveis. O output será gerado no arquivo `tasks.md`.

## Tipos de Tarefas

Toda tarefa listada no `tasks.md` DEVE receber explicitamente um identificador de concorrência:
- `[P]` (Parallel): Tarefas independentes que não dependem umas das outras e não tocam nos mesmos arquivos chave simultaneamente. Podem ser enviadas para subagentes concorrentes.
- `[S]` (Sequential): Tarefas que bloqueiam outras ou precisam ser feitas uma de cada vez.

## Estrutura do Arquivo `tasks.md`

Ao usar o comando `criar tarefas`, grave o plano de ação seguindo este formato de checklist:

```markdown
# Lista de Tarefas: [Nome da Funcionalidade]

## Backend (Dominio X)
- [ ] [P] 1.1 Criar o DTO e a interface do usuário. (Arquivos alvo: `src/domains/x/dto/...`)
- [ ] [S] 1.2 Implementar a lógica do Controller que consome a interface de 1.1. (Depende de: 1.1)
- [ ] [P] 1.3 Adicionar testes unitários para a API (Mockando o service).

## Frontend (Dominio Y)
- [ ] [P] 2.1 Criar o componente visual de Card isolado (Usando Storybook ou testes simples).
- [ ] [S] 2.2 Integrar o componente Card com a store/API criada no passo 1.2. (Depende de: 1.2 e 2.1).
```

## Como o Orquestrador Lida com Tarefas
- Na fase de implementação, o agente principal (Você) deve olhar as tarefas não concluídas.
- Identifique blocos de tarefas `[P]` que estão destravadas e delegue-as **simultaneamente** para subagentes se a plataforma suportar paralelismo, repassando o mínimo de contexto necessário (ver [context-management.md](context-management.md)).
- Se a plataforma não suportar paralelismo total, execute as `[P]` isoladamente garantindo as validações de unidade.
