# Aprendizado Contínuo e Feedback Loop

O Next-Gen Spec-Driven Development exige que o agente seja consciente de seus erros e dos padrões do projeto.

## 1. O Padrão "Reflect & Fix" (Auto-Correção)

Toda vez que a IA tentar rodar o código e encontrar um erro (ex: falha em linting, falha de tipagem, compilação quebrando), ou se o usuário fornecer um feedback corretivo ("você esqueceu de injetar a dependência"), a IA **DEVE** evitar simplesmente reescrever o arquivo silenciosamente.

O agente DEVE adicionar no chat a estrutura de reflexão explícita, como o exemplo:

```markdown
### 🧠 Reflexão de Erro
- **[ERRO ENCONTRADO]**: Usei tipagem genérica `any` na interface da API e esqueci de retornar o objeto tipado.
- **[REGRA VIOLADA]**: O projeto exige TypeScript estrito e tipagem explícita para DTOs.
- **[SOLUÇÃO]**: Refatorar a função para retornar `Promise<OrderDto>` e importar o model adequado.
```
Após esta saída, a IA aplica a correção.

## 2. Aprendizado via Revisões e Feedback de PR (Sugestões)

Quando o usuário repassar um feedback vindo de um Code Review ou PR (ex: "No review do PR, pediram para usar variáveis CSS nativas em vez de hardcode hexadecimais"):

**Regra Estrita**: 
1. **NÃO USE** ferramentas automáticas (`git log`, etc) para tentar ler e alucinar todo o repositório em busca de padrões de forma cega.
2. **SUGIRA**: Ao resolver o feedback específico na tarefa, o agente DEVE perguntar ao usuário se ele quer adicionar essa lição aos padrões. 

**Exemplo de Resposta do Agente:**
> "Entendi. Vou substituir as cores hexadecimais por variáveis CSS neste arquivo. 
> 💡 *Sugestão de Aprendizado*: Deseja que eu adicione esta regra ('Sempre usar variáveis CSS nativas e evitar hexadecimais hardcoded') ao nosso documento `CONVENTIONS.md` para que eu e os subagentes não cometamos esse erro nas próximas tarefas?"

Se o usuário responder "sim", abra o arquivo `.specs/codebase/CONVENTIONS.md` (ou equivalente) e grave a nova regra. Isso mantém as diretrizes do projeto sempre evoluindo sem correr o risco de poluir o arquivo com alucinações.
