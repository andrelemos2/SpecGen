# Princípios Fundamentais do SpecGen

> Este arquivo é imutável no dia-a-dia. Alterações requerem aprovação do Tech Lead.
> Owner: Tech Lead / Principal Engineer.

---

## 1. 📜 Spec como Source of Truth

O `spec.md` é o contrato de software. **Nenhum código é escrito antes da spec ser aprovada.**
Qualquer divergência entre spec e código é um bug — não uma feature.
A spec evolui com o produto, nunca fica obsoleta.

## 2. ⚙️ Modo Adaptativo sem Burocracia Desnecessária

Features simples ativam o **Quick Path**. O framework se adapta à complexidade real.
Regra: **use o mínimo de fases necessário para eliminar ambiguidade e garantir qualidade**.
Nunca imponha burocracia onde ela não agrega valor.

## 3. 🔒 Fases Gated com Human-in-the-Loop

No Full Path, cada fase requer aprovação explícita do usuário antes de avançar.
O agente **nunca** assume aprovação implícita. Sem aprovação, sem avanço.

## 4. 🧪 TDD Obrigatório (Red → Green → Refactor)

Código sem teste não é código completo.
O ciclo TDD é o mecanismo que garante que a implementação honra os critérios de aceite da spec.
O teste é escrito **antes** da implementação, sempre.

## 5. 📐 Diagramas Mermaid como Linguagem de Design

No Full Path, arquitetura sem diagrama não é arquitetura documentada.
Mermaid é o padrão: legível por humanos, renderizável por máquinas, versionável em Git.
Tipos obrigatórios: `flowchart` (arquitetura), `sequenceDiagram` (fluxo), `erDiagram` (dados).

## 6. 🔀 Paralelismo Inteligente

Tarefas independentes rodam em paralelo via sub-agentes especializados.
A dependência entre tarefas é **explícita** no `tasks.md`, nunca implícita.
Grupos PARALELO e SEQUENCIAL são identificados antes da execução.

## 7. 📦 Modularidade e Lazy Loading

Boundaries de módulos são definidos no design **antes** de existirem no código.
Módulos com lazy loading são identificados e marcados explicitamente nos diagramas.
A skill em si segue o mesmo princípio: cada fase é carregada sob demanda.

## 8. 🧹 Higiene de Workspace (Zero Scope Creep)

O `delta.md` é o contrato de mudança.
Qualquer arquivo criado ou modificado que **não esteja no delta.md** é scope creep
e deve ser imediatamente questionado e revertido.

## 9. 💾 Memória Persistente entre Sessões

O `STATE.md` é a memória viva do projeto.
Uma nova sessão **sempre** começa lendo `STATE.md` para garantir continuidade.
Nenhum contexto é perdido entre sessões ou agentes.

## 10. 🏛️ Governança para Grandes Empresas

O framework é projetado para **times**, não indivíduos.
- `CONSTITUTION.md`: regras do time (todos respeitam)
- Matriz de Sub-Agentes: define responsabilidades claras
- Quality Gate: garante rastreabilidade e auditabilidade
- Arquivos separados por fase: evita conflitos de código
