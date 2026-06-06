# Fase de Especificação (Specify)

A primeira etapa (Obrigatória para funcionalidades significativas) que deve traduzir a vontade do usuário para um documento markdown que ditará as regras.

Quando o comando `especificar` for chamado:
1. Identifique o objetivo funcional a partir do prompt do usuário.
2. Crie ou atualize o arquivo `.specs/features/[nome-funcionalidade]/spec.md`.
3. **Não escreva código nem cite estruturas tecnológicas.** Fique restrito ao Domínio Funcional (O quê, por que, histórias de usuários, critérios de aceitação).

Exemplo de Conteúdo:
```markdown
# Spec: Sistema de Assinaturas

## O Que e Por Que
Precisamos que usuários possam pagar por um plano recorrente. Isso irá destravar os recursos "Pro" listados em features anteriores.

## Histórias de Usuário
- Como cliente, eu quero poder inserir meu cartão de crédito e pagar R$ 10 mensais.
- Como admin, eu quero poder cancelar a assinatura de um cliente caso haja disputa.

## Critérios de Aceite
- [ ] O sistema não pode reter dados crus do cartão.
- [ ] Emissão de webhooks em pagamentos rejeitados.
```

Após gerar o `.spec.md`, pare e peça feedback ao usuário. Se ele aprovar, proceda para a fase de `projetar` (Design).
