# Princípios de Codificação

Leia este arquivo durante a fase de Execução ao implementar alterações.
Estes princípios reduzem erros comuns de codificação de IA e garantem
entregas consistentes e de alta qualidade.

## 1. Pense Antes de Codificar

Antes de escrever qualquer código:

- Declare suas suposições explicitamente. Se estiver incerto, pergunte.
- Se existirem múltiplas abordagens, apresente-as com seus prós e contras (tradeoffs).
- Se existir uma abordagem mais simples, diga. Questione quando for justificável.
- Se algo não estiver claro, pare. Nomeie o que está confuso. Pergunte.
- Se a abordagem do desenvolvedor parecer errada, diga construtivamente.
  Não seja adulador — a honestidade previne bugs.

## 2. Simplicidade Primeiro

Escreva o código mínimo que resolve o problema.

- Sem funcionalidades além do solicitado.
- Sem abstrações para código de uso único.
- Sem "flexibilidade" ou "configurabilidade" que não tenha sido solicitada.
- Sem tratamento de erros para cenários impossíveis.
- Sem otimização especulativa.
- Se você escreveu 200 linhas e poderiam ser 50, reescreva.

O teste: "Um engenheiro sênior diria que isso é supercomplicado?"
Se sim, simplifique.

## 3. Alterações Cirúrgicas

Ao editar código existente:

- Não "melhore" códigos, comentários ou formatação adjacentes.
- Não refatore coisas que não estão quebradas.
- Siga o estilo existente, mesmo que você faria diferente.
- Se você notar problemas não relacionados, mencione-os — não os corrija.

Quando suas alterações criarem órfãos:

- Remova imports, variáveis e funções que as SUAS alterações tornaram não utilizados.
- Não remova código morto pré-existente a menos que solicitado.

O teste: Cada linha alterada rastreia-se diretamente ao objetivo da missão.

## 4. Execução Orientada a Objetivos

Transforme tarefas vagas em objetivos verificáveis:

- "Adicionar validação" → "Escrever testes para entradas inválidas, depois fazê-los passar"
- "Corrigir o bug" → "Escrever um teste que o reproduza, depois fazê-lo passar"
- "Refatorar X" → "Garantir que os testes passem antes e depois"

Para tarefas de múltiplos passos, apresente um plano breve com pontos de verificação.
Critérios de sucesso robustos permitem execução autônoma. Critérios fracos
("fazer funcionar") exigem esclarecimento constante — peça critérios melhores
em vez de adivinhar.

## 5. Respeite a Base de Código

Você é um convidado nesta base de código. Aja como tal.

- Use as mesmas convenções de nomenclatura já presentes no projeto.
- Use os mesmos padrões de organização de arquivos.
- Use a mesma abordagem de tratamento de erros.
- Use o mesmo estilo de importação (nomeada vs padrão, relativa vs absoluta).
- Se o projeto usa ponto e vírgula, use ponto e vírgula. Se não usa, não use.

Se as convenções existentes conflitarem com as melhores práticas da linguagem, sinalize
ao desenvolvedor. Não introduza silenciosamente uma convenção diferente.

## 6. Melhores Práticas da Linguagem

Sempre siga as melhores práticas oficiais da linguagem e dos frameworks em
uso. Isso significa:

- Use padrões idiomáticos para a linguagem (ex: comprehensions de lista em Python,
  encadeamento opcional em TypeScript).
- Siga o guia de estilo oficial quando o projeto não tiver o seu próprio.
- Use APIs e métodos atuais e não depreciados.
- Trate os erros de acordo com as convenções da linguagem (try/catch,
  tipos Result, retornos de erro — o que o ecossistema preferir).

Crítico: Nunca confie na memória de treinamento para assinaturas de API, parâmetros
de método ou comportamento de framework. Sempre verifique contra a documentação
atual usando a Cadeia de Verificação de Conhecimento:

```
.notebook/ → docs do projeto → MCP Context7 → busca na web → sinalizar incerteza
```

## 7. Dependências e Importações

Ao adicionar novas dependências ou importações:

- Verifique se o projeto já tem uma dependência que resolve o problema antes
  de adicionar uma nova.
- Verifique o gerenciador de pacotes do projeto e o arquivo lock para versões
  existentes.
- Se estiver adicionando uma nova dependência, mencione ao desenvolvedor com a
  justificativa — nunca adicione pacotes silenciosamente.
- Siga o estilo de importação do projeto e as convenções de ordenação.

## 8. Tratamento de Erros

- Trate erros que podem ocorrer realisticamente.
- Não adicione blocos catch para cenários teoricamente impossíveis.
- Use os padrões de tratamento de erros existentes no projeto.
- Mensagens de erro devem ser acionáveis — diga o que aconteceu e
  o que fazer a respeito, não apenas "Algo deu errado."
- Nunca silencie erros (blocos catch vazios) a menos que haja um
  motivo explícito documentado em um comentário.

## 9. Testes

Quando testes fizerem parte da missão:

- Escreva testes que verifiquem o comportamento, não detalhes de implementação.
- Teste o contrato (entrada → saída), não o estado interno.
- Nomeie os testes descritivamente: "deve rejeitar cupom expirado",
  não "teste1" ou "teste de cupom".
- Se estiver modificando código existente, execute os testes existentes primeiro para
  estabelecer uma base (baseline).
- Se estiver adicionando uma correção de bug, escreva um teste que reproduza o bug
  primeiro, depois corrija-o.

Quando testes NÃO fizerem parte da missão:

- Não adicione testes a menos que solicitado.
- Mas SINALIZE se a alteração for arriscada e não testada:
  "Esta alteração afeta o fluxo de pagamento, mas não há testes
  cobrindo este caminho. Considere adicionar testes para [casos específicos]."

## 10. Comentários

- Não adicione comentários que reafirmem o código.
- Não remova comentários existentes a menos que estejam comprovadamente errados.
- Adicione comentários apenas para lógica de negócios não óbvia ou soluções temporárias (workarounds).
- Se adicionar uma solução temporária, explique o PORQUÊ de ser necessária e
  crie um link para a issue/tarefa relevante, se disponível.
- Siga o estilo de comentários do projeto e o idioma (idioma humano).
