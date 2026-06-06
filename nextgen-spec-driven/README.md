<p align="center">
  <img src="https://img.shields.io/badge/Skill-NextGen--Spec--Driven-blue?style=for-the-badge&logo=rocket&logoColor=white" alt="skill badge" />
  <img src="https://img.shields.io/badge/Token_Cost-Extremely_Low-success?style=for-the-badge&logo=cashapp&logoColor=white" alt="token cost" />
  <img src="https://img.shields.io/badge/Version-1.0.0-purple?style=for-the-badge&logo=semver&logoColor=white" alt="version" />
</p>

<h1 align="center">🚀 NextGen Spec-Driven</h1>

<p align="center">
  <strong>Desenvolvimento impecável guiado por especificações. Custo mínimo de tokens. Arquitetura isolada (Bounded Contexts) e Aprendizado contínuo (Anti-Alucinação).</strong>
</p>

<p align="center">
  <strong>Autor:</strong> <a href="https://github.com/andrelemos2">Andre Lemos</a>
</p>

## ✨ O Paradigma "Token-Efficient" & Comparativo de Custo

A grande revolução do **NextGen Spec-Driven** é o seu *Context Budgeting*. Para garantir o melhor custo-benefício, esta skill blinda o LLM contra vazamentos de contexto e histórico inflado. Veja como nos comparamos com outras metodologias líderes de mercado:

| Framework / Skill | Estratégia de Contexto (Input Tokens) | Delegação para Subagentes | Custo (Token Burn) |
| :--- | :--- | :--- | :--- |
| **GitHub Spec Kit** | **Massiva:** Lê e injeta diretrizes globais e histórico para cada comando. | Não nativo (depende do host). | 🔴 Muito Alto |
| **OpenSpec** | **Pesada:** Reavalia a árvore de design e specs inteira no Apply/Archive. | Orquestrador repassa alto payload. | 🔴 Alto |
| **SuperPowers** | **Moderada a Alta:** Prompts base massivos injetando muitas skills na raiz. | Compartilha longos estados da sessão. | 🟡 Médio/Alto |
| **Spec-Driven (Antiga)** | **Média:** Lê `STATE.md`, `ROADMAP.md` livremente em qualquer fase. | Delegação sem travas rígidas de chat. | 🟡 Médio |
| **NextGen Spec-Driven** | **Cirúrgica:** A fase carrega **apenas** o estritamente necessário. Não varre git log. | **Payload Limpo:** Zero Chat History herdado. | 🟢 **Extremamente Baixo** |

### 🛡️ Onde os Vazamentos Ocorrem e Como Evitamos:

1. **Vazamento por Histórico de Chat:** Subagentes recebem apenas a instrução da tarefa atual + o arquivo (`[P] Tasks`). Eles não processam conversas anteriores do Orquestrador.
2. **Leitura Excessiva de Docs:** A fase técnica está proibida de ler o `ROADMAP.md` ou descrições abstratas. Lê apenas o que precisa no momento.
3. **Alucinação de Revisão:** A IA não gasta milhares de tokens varrendo diffs do `git log` cega. Ela **aprende sob demanda**, gerando sugestões ativas quando você repassa um feedback.
4. **Vazamento de Output:** Erros disparam o bloco obrigatório de reflexão (`[Erro] -> [Causa] -> [Solução]`) em vez de simplesmente reescrever arquivos massivos sem rumo.

## 🔄 Fluxo de Trabalho de 5 Fases

```
┌─────────────┐   ┌────────────┐   ┌───────────┐   ┌────────────┐   ┌────────────┐
│ ESPECIFICAR │ → │   DESIGN   │ → │  TAREFAS  │ → │  EXECUTAR  │ → │  REFLETIR  │
└─────────────┘   └────────────┘   └───────────┘   └────────────┘   └────────────┘
  (Obrigatório)     (Opcional)      (Opcional)     (Obrigatório)    (Obrigatório)
```

Para ver o detalhamento de cada fase, consulte o código da skill e os arquivos em `references/`.
