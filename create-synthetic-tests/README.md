# Create Synthetic Tests

![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-000000?style=for-the-badge&logo=semver&logoColor=white)
![Type](https://img.shields.io/badge/Type-Agent_Skill-8A2BE2?style=for-the-badge&logo=openai&logoColor=white)
![Compatibility](https://img.shields.io/badge/Agentes-Antigravity_%7C_Devin_%7C_Cursor-007EC6?style=for-the-badge&logo=probot&logoColor=white)

**Create Synthetic Tests** é uma skill projetada para guiar Agentes de IA na estruturação e implementação de testes sintéticos via AWS Lambda, comumente atrelados aos Lifecycle Hooks do AWS CodeDeploy (ex: `AfterAllowTestTraffic`).

A skill fornece a base arquitetural para garantir validações automatizadas de cenários antes de liberar a nova versão de uma aplicação para os usuários finais, reduzindo a probabilidade de falhas e permitindo rollbacks automáticos eficientes.

## 🚀 Como Funciona

Ao invocar essa skill, o agente irá gerar e orientar a estruturação dos seguintes artefatos:

1. **Diretório de Cenários (`scenarios/`)**: Um diretório local com arquivos JSON contendo cenários de teste pré-definidos (ex: rotas, métodos e assertions esperadas).
2. **Lambda Handler (`handler.js` / `handler.py`)**: O código boilerplate pronto para receber o evento do CodeDeploy, extrair o `DeploymentId`, iterar pelos cenários e notificar o CodeDeploy com o resultado (`Succeeded` ou `Failed`).
3. **Mecanismo de Execução (`runner.js`)**: O responsável por processar iterativamente os cenários contra o endpoint alvo da nova versão, antes do switch definitivo de tráfego.

## 🤖 Compatibilidade com Ferramentas e Agentes de IA

### 🪐 Antigravity (Gemini)
Esta skill é carregada automaticamente a partir do diretório de configurações do Antigravity. O agente reconhece gatilhos como "criar teste sintético", "codedeploy hook" e aplicará o padrão arquitetural no seu projeto de imediato.

### 🤖 Devin (Cognition)
Para usar no Devin, copie a pasta `create-synthetic-tests/` (contendo o `SKILL.md`) para o diretório `.agents/skills/` na raiz do seu repositório. O Devin fará o carregamento automático em sua lista de **Skills Discovered**.

### 📝 Cursor / Windsurf
Você pode incluir uma instrução simples em suas regras de projeto (ex: `.cursorrules`) para apontar o agente às diretrizes presentes nesta skill.
