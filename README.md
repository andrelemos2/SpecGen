# 🤖 Agent Skills

Este repositório reúne um conjunto de **skills estruturadas** para otimizar o fluxo de trabalho de engenharia de software e exploração de código por agentes de inteligência artificial (como Devin, Antigravity, Claude Code, Cursor e Windsurf).

---

## 📁 Skills Disponíveis

### 1. 📐 [Next Gen Spec-Driven Development (SpecGen)](file:///Users/andrelemos/.gemini/config/skills/specgen/SKILL.md)
Framework enterprise de Spec-Driven Development (v2.1). Arquitetura modular com *lazy loading* de fases (15 arquivos estruturados), pipeline de 7 fases gated e **integração nativa com GitFlow**. Suporte a PRD, Greenfield/Brownfield, diagramas Mermaid, TDD, sub-agentes paralelos e **modo adaptativo** (Quick Path vs Full Path).
- **Triggers:** `/specgen:init`, `/specgen:research`, `/specgen:specify`, `/specgen:design`, `/specgen:tasks`, `/specgen:execute`, `/specgen:archive`, `/specgen:status`.

### 2. 📐 [System Design (Arquitetura de Sistemas)](file:///Users/andrelemos/.gemini/config/skills/system-design/SKILL.md)
Framework completo para estruturar e desenhar a arquitetura de sistemas distribuídos, fornecendo guias para definição de escopo (FR/NFR), estimativas de capacidade, listagem de componentes AWS e geração de fluxogramas interativos.
- **Triggers:** "desenho de arquitetura de system design", "projetar um sistema", "requisitos funcionais", "NFR", "SPOF", "trade-off", "diagrama de caixas e setas".



---

## ⚙️ Instalação e Compatibilidade

As definições são agnósticas e escritas no padrão aberto de Agent Skills.

### 🪐 No Antigravity (Gemini)
As skills no Antigravity operam a partir do diretório de configurações local. Para instalar todas as skills, basta clonar este repositório:
```bash
git clone https://github.com/andrelemos2/agent-skills.git ~/.gemini/config/skills/
```
*(Ou, se preferir instalar apenas uma skill específica, copie a pasta dela diretamente para dentro de `~/.gemini/config/skills/`)*

### 🤖 No Devin (Cognition)
Copie o diretório da skill desejada para a pasta `.agents/skills/` do repositório do seu projeto:
```bash
# Exemplo de estrutura no seu repositório de trabalho:
.agents/
└── skills/
    ├── specgen/
    │   ├── SKILL.md
    │   └── README.md
    └── system-design/
        └── SKILL.md
```
O Devin detectará automaticamente as regras em tempo de execução e as carregará na lista de **Skills Discovered**.

### 💻 No Claude Code / CLIs
Carregue os arquivos `SKILL.md` como contexto ou use as convenções propostas rodando comandos no seu terminal de trabalho.

### 📝 No Cursor / Windsurf
Adicione o conteúdo de `SKILL.md` ou referências correspondentes no arquivo de regras do seu agente (ex: `.cursorrules`).
