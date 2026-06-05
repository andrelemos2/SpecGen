# Auto-Detecção de Runtime do Agente

Para manter compatibilidade total e se auto-ajustar a diferentes ferramentas (Devin, Claude Code, Antigravity, Cursor/Windsurf), o agente deve rodar esta verificação no início de cada sessão ou tarefa complexa.

---

## 🔍 Como Detectar o Ambiente

O agente deve avaliar as variáveis de ambiente e o sistema usando comandos simples no shell (`env` ou `echo`), identificando a plataforma sob a qual está rodando:

| Agente / Plataforma | Variável de Ambiente Principal | Outros Indicadores de Sistema |
| :--- | :--- | :--- |
| **Devin** (Cognition) | Presença de qualquer variável contendo `DEVIN` | Diretório `/opt/.devin` ou `/home/devin` existente; usuário `whoami` é `devin`. |
| **Claude Code** (Anthropic) | `CLAUDE_CODE_SESSION_ID` presente | Variável `CLAUDE_CODE_REMOTE` pode estar presente. |
| **Antigravity** (Gemini) | Caminho de workspace sob `.gemini/` | Rodando nativamente no macOS/Linux do usuário, sem sandbox do tipo container Devin. |
| **Cursor / Windsurf** | `TERM_PROGRAM=vscode` | Variáveis `VSCODE_` presentes no ambiente de subprocesso. |

---

## ⚙️ Regras Adaptativas por Ambiente

Após detectar o ambiente, aplique as seguintes regras de comportamento e limites:

### 🤖 Se rodando no Devin (Cognition)

1. **Orquestração via Child Sessions:** O Devin suporta paralelismo e isolamento criando sessões filhas gerenciadas (*Managed Devins*).
   - *Ação:* Para cada tarefa marcada como paralela `[P]` (ou tarefas sequenciais cujo contexto de arquivos seja grande), o Devin principal deve disparar uma **Child Session** para implementar, testar e relatar o resultado.
   - *Ação:* O Devin coordenador monitora as sessões filhas e junta os resultados ao final. O Devin NÃO usa a ferramenta de MCP de subagentes locais (`Task`).
2. **Priorizar Playbooks/Knowledge:** O Devin responde de forma extremamente robusta a itens na sua Knowledge Base interna.
   - *Ação:* Consulte a Knowledge Base para alinhar os padrões de commits, especificações e estrutura de diretórios do projeto.
3. **Sem Integração de MCPs Externos:** O Devin não possui suporte ao ecossistema de MCPs locais de outras IAs (como `mermaid-studio` ou `codebase-navigator`).
   - *Ação:* Use diagramação mermaid inline em markdown normal.

### 💻 Se rodando no Claude Code (Anthropic)

1. **Uso Intensivo de Ferramentas de Terminal:** O Claude Code prefere executar comandos diretos em vez de ferramentas de alto nível.
   - *Ação:* Sempre execute testes unitários e de build via comandos diretos no shell (`npm test`, `vitest`, etc.).
2. **Histórico Git Convencional:** Claude Code é ótimo com Git.
   - *Ação:* Siga estritamente a convenção de commits atômicos gerados após a conclusão de cada tarefa rápida ou detalhada.

### 🪐 Se rodando no Antigravity ou outras ferramentas (exceto Devin)

1. **Usar Orquestrador e Subagentes Locais:** Antigravity e outros agentes similares têm suporte nativo a subagentes de tarefas (via ferramenta de MCP `Task` ou spawn local).
   - *Ação:* Delegar a execução das tarefas (principalmente as marcadas com `[P]`) para subagentes paralelos locais para manter a janela de contexto principal limpa.
2. **Integrar com Outras Skills:**
   - *Ação:* Buscar e delegar a `mermaid-studio` para renderização de diagramas e `codebase-navigator` para mapeamento de base de código.

---

## 📋 Comando de Verificação Rápida

Se estiver em dúvida sobre qual ambiente está ativo, o agente pode rodar o seguinte script inline no terminal para obter um diagnóstico imediato:

```bash
if [ -n "$CLAUDE_CODE_SESSION_ID" ]; then
  echo "DETECTED: Claude Code"
elif [ -d "/opt/.devin" ] || env | grep -qi "devin"; then
  echo "DETECTED: Devin (Cognition)"
elif env | grep -q "gemini"; then
  echo "DETECTED: Antigravity (Gemini)"
else
  echo "DETECTED: Standard Local CLI / Editor Agent"
fi
```
