# Next Gen Spec-Driven Development (ng-sdd)

![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-000000?style=for-the-badge&logo=semver&logoColor=white)
![Type](https://img.shields.io/badge/Type-Agent_Skill-8A2BE2?style=for-the-badge&logo=openai&logoColor=white)
![Tokens](https://img.shields.io/badge/Contexto-Economia_Extrema-FF8C00?style=for-the-badge&logo=dependabot&logoColor=white)
![Compatibility](https://img.shields.io/badge/Agentes-Antigravity_%7C_Devin_%7C_Cursor-007EC6?style=for-the-badge&logo=probot&logoColor=white)
![Author](https://img.shields.io/badge/Author-André_Lemos-181717?style=for-the-badge&logo=github&logoColor=white)
![License](https://img.shields.io/badge/License-CC--BY--4.0-lightgrey?style=for-the-badge&logo=creativecommons&logoColor=black)

**ng-sdd** é um framework definitivo de governança, paralelismo e execução cirúrgica para Agentes de Inteligência Artificial. Projetado para máxima economia de tokens e precisão, ele transforma o modelo tradicional de "documentação passiva" em um fluxo de trabalho governado por **Slash Commands** e **Gestão Dinâmica de Contexto**.

## 🚀 Como Funciona

Ao contrário de frameworks que exigem a leitura de pesadas bases de conhecimento a cada iteração, o **ng-sdd** é magro, focado na ação. Ele opera exclusivamente através de gatilhos:

*   `/ngsdd:init`: Inicializa o repositório, mapeia a arquitetura e gera a constituição do projeto.
*   `/ngsdd:propose [feature]`: Aplica questionamento socrático para remover ambiguidades e estrutura o escopo (`spec.md`, `design.md`, `tasks.md`).
*   `/ngsdd:pause`: Empacota a memória e orienta o usuário a fechar o chat, salvando contexto e economizando tokens.
*   `/ngsdd:apply`: Aciona o pipeline de execução paralela (se aplicável), utilizando TDD estrito (Red-Green-Refactor).
*   `/ngsdd:archive`: Executa o Quality Gate final e higieniza o workspace movendo tudo para um arquivo histórico.

Toda a memória é mantida dinamicamente no seu próprio projeto (dentro da pasta `.ngsdd/memory/`), o que garante que o LLM só leia aquilo que é estritamente relevante para o código atual.

---

## 🆚 Comparativo com Outros Frameworks (A Evolução)

A **ng-sdd** foi arquitetada com o objetivo de integrar as melhores práticas estabelecidas por seus precursores, otimizando as áreas que tradicionalmente geram maior custo computacional ou complexidade operacional:

| Framework Precursor | Principais Contribuições Absorvidas | Oportunidades de Otimização Abordadas |
| :--- | :--- | :--- |
| **GitHub Spec Kit** | **Governança forte** e uso de princípios estruturados (`constitution.md`). | Redução da verbosidade e substituição de arquivos estáticos extensos para poupar o limite de contexto do LLM. |
| **Superpowers** | **Rigor na execução**, isolamento de ambiente e adoção do TDD estrito (Red-Green-Refactor). | Substituição de fluxos puramente lineares por arquiteturas de execução mais eficientes e de menor custo de tokens. |
| **TLC Spec-Driven** | **Paralelismo de sub-agentes** via `tasks.md` e a memória de projeto persistente (`STATE.md`). | Consolidação da documentação de referência, simplificando a multiplicidade de arquivos isolados de instrução. |
| **OpenSpec** | **Fluidez de interação** no terminal via Slash Commands e organização estruturada de pastas (arquivamento). | Incorporação de um modelo de governança de código robusto, ausente em modelos focados apenas em interface. |

**Veredito:** O **ng-sdd** integra a sólida governança do Spec Kit, o alto rigor de qualidade do Superpowers, a orquestração paralela do TLC e a interface ágil do OpenSpec. Essa união é viabilizada com extrema eficiência de recursos (tokens), substituindo modelos densos de referência por interações enxutas e contextuais.

---

## 📉 Economia de Tokens (Context Economy)

O maior diferencial da **ng-sdd** na prática do dia a dia é o impacto financeiro e de performance no consumo de contexto do LLM. Como a skill não carrega arquivos passivos de documentação, a diferença no uso de tokens é drástica:

*   **Modelos Tradicionais (ex: TLC, Spec Kit, Superpowers):** O agente carrega a skill juntamente com grandes arquivos de referência e exemplos para entender como operar. Isso resulta frequentemente em **~5.000 a 15.000 tokens** gastos apenas de "overhead" na inicialização do prompt, encarecendo a operação, aumentando a latência e poluindo a janela de atenção do modelo.
*   **ng-sdd:** O agente carrega apenas as diretrizes enxutas do `SKILL.md` (baseadas em Slash Commands determinísticos) e busca os artefatos locais contextuais (como o `STATE.md`). O overhead base despenca para **menos de 1.000 tokens**. Isso garante que a janela de contexto seja usada para pensar quase inteiramente no seu **código** e na **arquitetura**, gerando execuções mais baratas, rápidas e menos propensas a alucinações.

---

## 🤖 Compatibilidade com Ferramentas e Agentes de IA

A definição agnóstica do **ng-sdd** permite sua execução transparente nos principais orquestradores e IDEs focados em IA:

### 🪐 Antigravity (Gemini)
A ferramenta pode ser invocada naturalmente no terminal ou orquestrada com o comando padrão. Os sub-agentes serão gerenciados automaticamente pelo Antigravity em rotinas paralelas quando detectado pelo arquivo `tasks.md`.

### 🤖 Devin (Cognition)
Para usar no Devin, copie toda a pasta `ng-sdd/` (contendo o `SKILL.md`) para o diretório `.agents/skills/` na raiz do seu repositório de trabalho. O Devin fará o carregamento imediato em sua lista de **Skills Discovered**, aplicando automaticamente as regras e lendo os Slash Commands no chat.

### 📝 Cursor / Windsurf
A melhor abordagem para estas IDEs é referenciar a skill em suas regras de projeto. Você pode anexar o conteúdo do `SKILL.md` ou criar uma referência dentro do arquivo `.cursorrules` ou do prompt de projeto no Windsurf:
```text
Sempre que for solicitado criar código ou iterar sobre ele, siga o framework ng-sdd. O usuário ativará os fluxos usando /ngsdd:init, /ngsdd:propose, etc...
```

### 💻 Claude Code / Outras CLIs
No uso via terminal com Claude Code, basta incluir o arquivo `SKILL.md` como contexto ao iniciar o projeto (`cat SKILL.md | claude ...`) ou criar o seu alias de prompt customizado contendo as instruções principais, usando o chat para dar trigger nos slash commands diretamente.
