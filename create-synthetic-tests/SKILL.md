---
name: create-synthetic-tests
description: >
  Skill para criação e estruturação de testes sintéticos via AWS Lambda,
  atrelados aos Lifecycle Hooks do AWS CodeDeploy (ex: AfterAllowTestTraffic).
  Auxilia na implementação de varredura e execução de cenários de teste para
  validar a aplicação antes de disponibilizá-la totalmente para os clientes.
  Use quando o usuário mencionar testes sintéticos, CodeDeploy,
  AfterAllowTestTraffic, ou validação de deploy automatizada na AWS.
---

# Create Synthetic Tests


## Objetivo

Esta skill orienta a criação de funções AWS Lambda atuando como Lifecycle Hooks para o AWS CodeDeploy, com foco no gatilho `AfterAllowTestTraffic` (podendo ser adaptado para `BeforeAllowTraffic` ou afins). A função é responsável por realizar uma varredura em um diretório de `scenarios/` e executar testes sintéticos iterativamente. O deploy só será disponibilizado ao cliente se **todos** os cenários passarem com sucesso.

## Padrão Arquitetural e Fluxo

1. **Trigger CodeDeploy:** O deploy atinge o hook configurado (ex: `AfterAllowTestTraffic`), e o CodeDeploy invoca a AWS Lambda repassando o `DeploymentId` e o `LifecycleEventHookExecutionId`.
2. **Varredura de Cenários:** A Lambda acessa o diretório de cenários (`scenarios/`) empacotado no próprio código (ou lido de um bucket S3 / base de dados).
3. **Testes Sintéticos (Iteração):**
   - Cada cenário define a entrada (método, endpoint, payload) e a saída esperada (status code, body parcial).
   - A Lambda testa o tráfego da **nova versão** da aplicação (via load balancer de teste, porta alternativa ou API Gateway test stage).
4. **Decisão do Deploy (Feedback Loop):**
   - **Sucesso:** Se todos os cenários da varredura passarem, a Lambda reporta `Succeeded` via `putLifecycleEventHookExecutionStatus`. O CodeDeploy segue em frente.
   - **Falha:** Se algum cenário não passar, a Lambda aborta a execução, loga o incidente e reporta `Failed`. O CodeDeploy intercepta a falha e dispara o processo de **Rollback Automático**.

---

## Como atuar quando acionado

Ao utilizar esta skill para guiar um usuário ou estruturar o código, siga estas etapas e providencie a seguinte estrutura base:

### 1. Estrutura de Diretório Sugerida

Recomende a seguinte estrutura para o projeto de testes sintéticos:

```text
synthetic-tests/
├── scenarios/
│   ├── 01-healthcheck.json
│   ├── 02-user-journey.json
│   └── 03-edge-cases.json
├── package.json (ou requirements.txt)
├── runner.js (Módulo para iterar os cenários e executar asserções)
└── handler.js (Ponto de entrada da Lambda e integração com AWS SDK)
```

### 2. O Handler da Lambda (Integração com CodeDeploy)

Gere a casca do Lambda demonstrando o recebimento do evento e o envio do status de volta.

**Exemplo em Node.js:**
```javascript
const { CodeDeployClient, PutLifecycleEventHookExecutionStatusCommand } = require("@aws-sdk/client-codedeploy");
const { runScenarios } = require('./runner');
const path = require('path');

const codedeploy = new CodeDeployClient();

exports.handler = async (event) => {
    console.log("Iniciando CodeDeploy Hook:", JSON.stringify(event));
    
    const deploymentId = event.DeploymentId;
    const lifecycleEventHookExecutionId = event.LifecycleEventHookExecutionId;

    try {
        // 1. Descobrir a URL alvo (pode vir via env vars, parameters do SSM, etc)
        const targetUrl = process.env.TEST_TARGET_URL;
        
        // 2. Fazer varredura e rodar cada cenário em ./scenarios
        const scenariosPath = path.join(__dirname, 'scenarios');
        await runScenarios(scenariosPath, targetUrl);

        // 3. Sucesso: todos os cenários rodaram sem falhas
        console.log("Todos os cenários sintéticos passaram com sucesso.");
        await reportStatus(deploymentId, lifecycleEventHookExecutionId, 'Succeeded');

    } catch (error) {
        // 4. Falha: algum cenário falhou, acionar Rollback
        console.error("Falha na validação sintética. Abortando deploy.", error);
        await reportStatus(deploymentId, lifecycleEventHookExecutionId, 'Failed');
        throw error; // Garantir que a Lambda falhe também no CloudWatch
    }
};

async function reportStatus(deploymentId, executionId, status) {
    const params = {
        deploymentId,
        lifecycleEventHookExecutionId: executionId,
        status // 'Succeeded' ou 'Failed'
    };
    await codedeploy.send(new PutLifecycleEventHookExecutionStatusCommand(params));
}
```

### 3. Lógica do Runner e Cenários

O runner deve ser agnóstico e iterar pelos arquivos lendo regras de assert. Exemplo de cenário (`01-healthcheck.json`):
```json
{
  "name": "Verificar Healthcheck da Nova Versão",
  "request": {
    "method": "GET",
    "path": "/health"
  },
  "assertions": {
    "statusCode": 200,
    "bodyContains": "UP"
  }
}
```
A função `runScenarios` deve carregar os arquivos (usando `fs.readdirSync`), realizar o fetch para a `targetUrl + path` e validar as `assertions`.

### 4. Permissões IAM Necessárias

Avise o usuário que a **Execution Role** da Lambda precisa obrigatoriamente da permissão abaixo, caso contrário o deploy ficará travado esperando resposta por até 1 hora:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "codedeploy:PutLifecycleEventHookExecutionStatus",
            "Resource": "*"
        }
    ]
}
```

---

## 🚦 Checklist de Refinamento (Para perguntar ao usuário)

Antes de considerar o código pronto, faça as seguintes perguntas de alinhamento:
1. **Descoberta do Alvo:** *"Como a Lambda saberá para onde enviar as requisições sintéticas (Load Balancer de teste, variável do Lambda, API Gateway stage)?"*
2. **Tempo de Execução:** *"Quantos cenários são esperados? É preciso ajustar o `timeout` padrão da Lambda (ex: de 3s para 30s ou mais) para dar tempo de varrer tudo?"*
3. **Massa de Dados:** *"Os cenários de teste são idempotentes? Será preciso gerar e limpar dados (teardown) ao final da iteração?"*
4. **Segurança:** *"Há necessidade de injetar headers de autenticação (Tokens, Chaves de API) para os testes rolarem de forma autorizada?"*
