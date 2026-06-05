# Inicialização do Projeto

**Gatilho:** "Inicializar projeto", "Configurar projeto", "Começar novo projeto" (ou equivalentes em inglês como "Initialize project", "Setup project", "Start new project").

## Processo

Extrair a visão do projeto por meio de perguntas e respostas iterativas (máximo de 3 a 5 perguntas por mensagem):

**Perguntas essenciais:**

1. O que você está construindo?
2. Para quem é e qual problema resolve?
3. Qual stack de tecnologia você está usando? (se souber)
4. O que está no escopo para a v1? O que está explicitamente excluído?
5. Restrições críticas? (cronograma, técnicas, recursos)

**Parar quando:** Houver uma compreensão clara da visão, objetivos e limites.

## Entregável: .specs/project/PROJECT.md

**Estrutura:**

```markdown
# [Nome do Projeto]

**Visão:** [descrição de 1 ou 2 frases]
**Para:** [usuários-alvo]
**Resolve:** [problema principal que está sendo abordado]

## Objetivos

- [Objetivo principal com métrica de sucesso mensurável]
- [Objetivo secundário com métrica de sucesso mensurável]

## Stack de Tecnologia

**Núcleo:**

- Framework: [nome + versão]
- Linguagem: [nome + versão]
- Banco de Dados: [nome]

**Principais dependências:** [3 a 5 bibliotecas/frameworks críticos]

## Escopo

**A v1 inclui:**

- [Capacidade principal 1]
- [Capacidade principal 2]
- [Capacidade principal 3]

**Explicitamente fora do escopo:**

- [O que NÃO está sendo construído]
- [O que NÃO está sendo construído]

## Restrições

- Cronograma: [se aplicável]
- Técnicas: [se aplicável]
- Recursos: [se aplicável]
```

**Limite de tamanho:** 2.000 tokens (~1.200 palavras)

**Validação:**

- Visão clara em 1 ou 2 frases?
- Os objetivos têm resultados mensuráveis?
- Os limites de escopo são explícitos?
