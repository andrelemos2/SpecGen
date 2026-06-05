# Princípios de Codificação

Viés comportamental, não checklist. Leia antes de cada implementação.

---

## Antes de Codificar

- Declare suas suposições explicitamente. Se estiver incerto, pergunte.
- Existem múltiplas interpretações? Apresente todas — não escolha silenciosamente.
- Existe uma abordagem mais simples? Diga. Questione quando for justificável.
- Algo não está claro? Pare. Nomeie o que está confuso. Pergunte.
- A abordagem do usuário parece errada? Discorde honestamente. Não seja adulador.

---

## Durante a Implementação

### Simplicidade

- Sem funcionalidades além do solicitado
- Sem abstrações para código de uso único
- Sem "flexibilidade" ou "configurabilidade" não solicitada
- Sem tratamento de erros para cenários impossíveis
- 200 linhas que poderiam ser 50? Reescreva.

### Alterações Cirúrgicas

- Não "melhore" códigos, comentários ou formatações adjacentes
- Não refatore coisas que não estão quebradas
- Siga o estilo existente, mesmo que você faria diferente
- Notou código morto não relacionado? Mencione-o — não o delete
- Remova APENAS imports/variáveis/funções que as SUAS alterações tornaram órfãos
- Não remova código morto pré-existente a menos que solicitado

### Integridade dos Testes

- NUNCA enfraqueça uma asserção de teste existente para fazê-la passar
- NUNCA delete um teste para reduzir a contagem de falhas
- NUNCA use o mecanismo skip/disable/pending do framework de teste para contornar um teste que está falhando
- NUNCA modifique testes escritos na fase VERMELHA (RED) durante a fase VERDE (GREEN)
- Se um teste estiver genuinamente errado, PARE e confirme com o usuário antes de alterá-lo
- Testes são a especificação — a implementação se conforma aos testes, não o contrário

### Orientado a Objetivos

- Transforme tarefas vagas em objetivos verificáveis
- Trabalho com múltiplos passos? Apresente um plano breve com pontos de verificação
- Cada linha alterada deve rastrear-se diretamente ao pedido do usuário

---

## Após Cada Alteração

Pergunte: "Um engenheiro sênior chamaria isso de supercomplicado?"
Se sim → simplifique antes de prosseguir.
