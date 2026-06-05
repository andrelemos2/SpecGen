# 🤖 Agent Skills

Este repositório reúne um conjunto de **skills estruturadas** para otimizar o fluxo de trabalho de engenharia de software e exploração de código por agentes de inteligência artificial (como Devin, Antigravity, Claude Code, Cursor e Windsurf).

---

## 📁 Skills Disponíveis

### 1. 🎯 [Spec-Driven (Desenvolvimento Guiado por Especificações)](file:///Users/andrelemos/.gemini/config/skills/spec-driven/SKILL.md)
Pipeline adaptativo baseado em 4 fases (**Especificar → Design → Tarefas → Executar**) que se ajusta automaticamente ao tamanho da funcionalidade (Modo Rápido para bugs simples, fluxo completo para grandes features).
- **Triggers:** "especificar funcionalidade", "inicializar projeto", "mapear base de código", "correção rápida", "retomar trabalho".
- **Destaque:** Compatibilidade nativa e auto-detectada para uso com subagentes locais (Antigravity) e **Child Sessions** (Devin).

### 2. 🗺️ [Codebase Navigator (Exploração de Código)](file:///Users/andrelemos/.gemini/config/skills/codebase-navigator/SKILL.md)
Guia metódico para decifrar bases de código complexas ou sem documentação, traçando investigações cirúrgicas e alimentando bases de conhecimento persistentes (`.notebook/`) de forma colaborativa com o desenvolvedor.
- **Triggers:** "corrija isso", "como isso funciona", "investigue este fluxo", "ajude-me com este código".

### 3. 📐 [System Design (Arquitetura de Sistemas)](file:///Users/andrelemos/.gemini/config/skills/system-design/SKILL.md)
Framework completo para estruturar e desenhar a arquitetura de sistemas distribuídos, fornecendo guias para definição de escopo (FR/NFR), estimativas de capacidade, listagem de componentes AWS e geração de fluxogramas interativos.
- **Triggers:** "desenho de arquitetura de system design", "projetar um sistema", "requisitos funcionais", "NFR", "SPOF", "trade-off", "diagrama de caixas e setas".

---

## ⚙️ Instalação e Compatibilidade

As definições são agnósticas e escritas no padrão aberto de Agent Skills.

### 🪐 No Antigravity (Gemini)
Para instalar localmente as skills no seu ambiente CLI:
```bash
npx agent-skills install -s spec-driven
npx agent-skills install -s codebase-navigator
npx agent-skills install -s system-design
```

### 🤖 No Devin (Cognition)
Copie o diretório da skill desejada para a pasta `.agents/skills/` do repositório do seu projeto:
```bash
# Exemplo de estrutura no seu repositório de trabalho:
.agents/
└── skills/
    ├── spec-driven/
    │   ├── SKILL.md
    │   └── references/
    └── codebase-navigator/
        └── SKILL.md
```
O Devin detectará automaticamente as regras em tempo de execução e as carregará na lista de **Skills Discovered**.

### 💻 No Claude Code / CLIs
Carregue os arquivos `SKILL.md` como contexto ou use as convenções propostas rodando comandos no seu terminal de trabalho.

### 📝 No Cursor / Windsurf
Adicione o conteúdo de `SKILL.md` ou referências correspondentes no arquivo de regras do seu agente (ex: `.cursorrules`).
