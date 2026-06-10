# 📐 SpecGen - Next Gen Spec-Driven Development

Este repositório contém o **SpecGen** (v2.2.0), um framework enterprise de Spec-Driven Development para otimizar o fluxo de trabalho de engenharia de software e exploração de código por agentes de inteligência artificial autônomos (como Antigravity, Devin, Claude Code, Cursor e Windsurf).

> **Premissa fundamental:** A especificação é a fonte da verdade. O código é consequência dela.
> Nenhuma linha de código é escrita sem uma spec aprovada.

---

## 🧩 Arquitetura e Subagentes

O SpecGen possui uma arquitetura modular com *lazy loading* de fases, pipeline de 7 fases gated e **integração nativa com GitFlow**. Ele opera no modelo Orquestrador + Subagentes, delegando tarefas complexas para agentes especialistas em background:

- **[SpecGen (Orquestrador)](specgen/SKILL.md):** Gerencia o ciclo de vida (INIT, RESEARCH, SPECIFY, DESIGN, TASKS, EXECUTE, ARCHIVE), rotendo o lazy loading e o fluxo de aprovações. Possui suporte a **Modo Adaptativo** (Quick Path vs Full Path).
- **[SpecGen Research](specgen-research/SKILL.md):** Subagente de pesquisa que varre o código em background para mapear *blast radius*, sistemas afetados e dependências implícitas.
- **[SpecGen Execute](specgen-execute/SKILL.md):** Subagente executor que implementa as tarefas atômicas em background de forma isolada e autônoma, adotando rígido TDD (Red-Green-Refactor).
- **[SpecGen Reviewer](specgen-reviewer/SKILL.md):** Subagente revisor focado em pair programming agêntico, que audita o código antes do commit buscando reduzir entropia, magic numbers e validando o delta modificado.

### ⚡ Triggers Principais
`/specgen:init`, `/specgen:research`, `/specgen:specify`, `/specgen:design`, `/specgen:tasks`, `/specgen:execute`, `/specgen:archive`, `/specgen:status`, `SpecGen`.

---

## ⚙️ Instalação e Compatibilidade

As definições são agnósticas e escritas no padrão aberto de Agent Skills.

### 🪐 No Antigravity (Gemini)
As skills no Antigravity operam a partir do diretório de configurações local. Para instalar o SpecGen, clone este repositório no seu diretório de skills:
```bash
git clone https://github.com/andrelemos2/agent-skills.git ~/.gemini/config/skills/
```

### 🤖 No Devin (Cognition)
Copie as pastas das skills para a pasta `.agents/skills/` do repositório do seu projeto:
```bash
.agents/
└── skills/
    ├── specgen/
    │   └── SKILL.md
    ├── specgen-execute/
    │   └── SKILL.md
    ├── specgen-research/
    │   └── SKILL.md
    └── specgen-reviewer/
        └── SKILL.md
```
O Devin detectará automaticamente as regras e subagentes em tempo de execução.

### 💻 No Claude Code / CLIs
Carregue os arquivos `SKILL.md` como contexto ou use as convenções propostas rodando comandos no seu terminal de trabalho.

### 📝 No Cursor / Windsurf
Adicione o conteúdo de `specgen/SKILL.md` (e as menções aos demais subagentes) no arquivo de regras do seu agente (ex: `.cursorrules`).
