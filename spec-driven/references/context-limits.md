# Limites de Contexto e Análise de Tokens

Este documento detalha os limites sugeridos de tamanho de arquivos para manter o contexto do agente enxuto (<40k tokens ativos), além de apresentar a estimativa real de consumo de tokens por fase do workflow.

---

## 📈 Limites de Tamanho de Arquivo

| Arquivo | Max Tokens | ~Palavras | Alerta Em |
| :--- | :--- | :--- | :--- |
| PROJECT.md | 2.000 | 1.200 | 1.600 (80%) |
| ROADMAP.md | 3.000 | 1.800 | 2.400 |
| STATE.md | 10.000 | 6.000 | 7.000 (70%) |
| spec.md | 5.000 | 3.000 | 4.000 |
| design.md | 8.000 | 4.800 | 6.400 |
| tasks.md | 10.000 | 6.000 | 8.000 |
| STACK.md | 2.000 | 1.200 | 1.600 |
| ARCHITECTURE.md | 4.000 | 2.400 | 3.200 |
| CONVENTIONS.md | 3.000 | 1.800 | 2.400 |
| STRUCTURE.md | 2.000 | 1.200 | 1.600 |
| TESTING.md | 4.000 | 2.400 | 3.200 |
| INTEGRATIONS.md | 5.000 | 3.000 | 4.000 |

---

## 🔍 Zonas de Contexto do Agente Principal

*   🟢 **Saudável** (<40k total): Operação silenciosa, excelente custo-benefício.
*   🟡 **Moderada** (40-60k): Nota de rodapé discreta com status.
*   🔴 **Crítica** (>60k): Alerta ativo, sugerir arquivamento ou delegação para subagente/child session.

### Exemplo de Alerta de Monitoramento (>40k)
```text
📊 Contexto: 52k tokens (moderado)
  - STATE.md: 8k (zona amarela)
  - tasks.md: 11k (ok)
  - Total: 52k / 200k (26% da janela de contexto típica)
```

---

## 🧪 Estimativa de Consumo de Tokens (Por Cenário)

Abaixo estão os dados simulados baseados em uma funcionalidade real (ex: *"Criação de fila de notificações"*).

### Cenário 1 — Modo Rápido (Quick Fix de escopo pequeno)
*   **Fluxo:** Descrever → Implementar → Verificar → Commit.
*   **Fase Única:** ~6.800 tokens.
*   *Recomendação:* Ideal para pequenas correções de bugs, ajustes simples de estilo ou configurações que tocam até 3 arquivos. Muito barato e rápido.

### Cenário 2 — Funcionalidade Média (Especificar + Executar)
*   **Fluxo:** Especificar → [Design/Tarefas: pulados] → Executar (com plano inline).
*   **Fase 1 (Especificar):** ~7.530 tokens.
*   **Fase 2 (Executar com plano inline):** ~16.968 tokens.
*   **Total Estimado:** ~24.500 tokens.

### Cenário 3 — Funcionalidade Grande (Pipeline Completo + Agentes)
*   **Fluxo:** Mapeamento → Especificar → Design → Tarefas → Orquestração.
*   **Fase 0 (Mapear Codebase - Uma vez por projeto):** ~32.000 tokens (amortizado em todas as features).
*   **Fase 1 (Especificar):** ~12.630 tokens.
*   **Fase 2 (Design):** ~20.825 tokens.
*   **Fase 3 (Tarefas):** ~17.720 tokens.
*   **Fase 4 (Executar - Contexto Principal Coordenador):** ~14.640 tokens.
*   **Fase 4 (Executar - Por subagente/child session):** ~9.328 tokens por tarefa isolada.
*   **Total Estimado (10 tarefas):** ~158.000 tokens (sem contar mapeamento inicial).

---

## 📊 Distribuição de Custo do Pipeline Completo

```text
Distribuição típica de tokens em uma feature complexa:
│
├── 49% Subagentes de implementação (Contexto isolado)
├── 17% Mapeamento de codebase (Gasto único inicial)
├── 11% Design & Arquitetura
├── 9%  Especificação de Requisitos (spec.md)
├── 9%  Breakdown de Tarefas (tasks.md)
└── 8%  Orquestrador Principal
```

---

## 💡 Dicas de Otimização de Custo

1.  **Delegação é a Chave:** O maior ganho do Spec-Driven é o uso de subagentes (ou *Child Sessions* no Devin). Cada tarefa executada em uma sessão isolada consome apenas ~9k tokens de input, enquanto se fosse executada na sessão principal, acumularia dezenas de milhares de tokens de logs de testes e arquivos lidos no histórico do chat.
2.  **Modelos Inteligentes vs. Baratos:**
    *   **Fases Leves (Especificar, Handoff, Atualizar STATE.md):** Use modelos rápidos e baratos (ex: Gemini Flash, Claude Haiku).
    *   **Fases Pesadas (Design, Tarefas e Executar):** Use modelos avançados de raciocínio (ex: Claude Sonnet, Gemini Pro).
3.  **Não acumule documentos de design/especificações antigos:** Mantenha ativos no contexto apenas a especificação e o design da funcionalidade *atual*. Arquive ou descarregue os documentos de outras features finalizadas.
