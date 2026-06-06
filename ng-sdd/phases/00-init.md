# Fase 0 — INIT: Fundação do Projeto

> **Owner:** Tech Lead / Staff Engineer
> **Comando:** `/ngsdd:init`
> **Sempre obrigatória** — Quick Path e Full Path.

---

## Objetivo

Criar a base de conhecimento do projeto antes de qualquer feature.
Detectar o contexto (Greenfield ou Brownfield) e gerar os artefatos de fundação.

---

## Passo 1 — Detectar contexto

| Condição | Contexto |
|---|---|
| Repositório com código existente | **Brownfield** |
| Repositório vazio ou novo projeto | **Greenfield** |

Declare imediatamente: "🔍 Contexto detectado: **Brownfield**" ou "🌱 Contexto detectado: **Greenfield**".

---

## Passo 2A — Fluxo Brownfield

1. **Varredura do repositório:**
   - Stack e versões (linguagem, frameworks, libs principais)
   - Estrutura de pastas e padrão de organização
   - Dependências externas críticas (bancos de dados, APIs, queues, cache)
   - Padrões de testes existentes (framework, cobertura estimada)
   - Pipeline CI/CD existente

2. **Mapeamento de context debt:**
   - Código sem documentação ou sem testes
   - Acoplamentos ocultos (módulos que dependem de outros sem contrato explícito)
   - Contratos implícitos (interfaces não documentadas que outros módulos usam)
   - TODOs e FIXMEs relevantes

3. **Geração de `.sdd/foundation/RESEARCH.md`** com o mapa do sistema atual.

---

## Passo 2B — Fluxo Greenfield

1. **Elicitação socrática** (perguntas sequenciais, não simultâneas):
   - "Qual problema central esse produto resolve?"
   - "Quem são os usuários primários e qual o contexto de uso?"
   - "Qual stack você prefere ou já tem expertise?"
   - "Quais são as restrições não negociáveis (performance, compliance, infra)?"
   - "Existe deadline ou MVP definido?"

2. **Definição de convenções iniciais:**
   - Naming conventions (arquivos, variáveis, branches)
   - Estrutura de pastas proposta
   - Padrão de commits (Conventional Commits)
   - Ferramentas de lint e formatação
   - Estratégia de testes (unitário, integração, e2e)

3. **Scaffold inicial** (se necessário): estrutura de pastas vazia conforme convenções.

---

## Passo 3 — Criar Artefatos de Fundação

### `.sdd/foundation/CONSTITUTION.md`

Regras globais do projeto. Exemplo:

```markdown
# CONSTITUTION

## Stack
- Linguagem: TypeScript 5.x
- Runtime: Node.js 20 LTS
- Framework: NestJS 10
- Banco de dados: PostgreSQL 15 + TypeORM
- Testes: Jest + Supertest
- CI/CD: GitHub Actions

## Convenções Obrigatórias
- Commits: Conventional Commits (feat, fix, chore, docs, test, refactor)
- Branches: GitFlow (feature/*, hotfix/*, release/*, develop, main)
- Cobertura mínima de testes: 80%
- PRs: requerem ao menos 1 aprovação
- Todas as APIs públicas devem ter contrato OpenAPI documentado
- Nenhum `console.log` em produção (use logger estruturado)

## Proibições
- Sem `any` explícito no TypeScript
- Sem segredos no código (use variáveis de ambiente)
- Sem merge direto em `main` ou `develop` sem PR

## Matriz de Sub-Agentes
| Role     | Responsabilidade                      |
|----------|---------------------------------------|
| Backend  | Services, repositories, controllers   |
| Frontend | Components, pages, state management   |
| QA       | Testes unitários e de integração       |
| Infra    | Migrations, configurações, CI/CD       |
```

### `.sdd/foundation/PRD.md`

Copie de `templates/prd.md` e preencha com as informações elicitadas.

### `.sdd/foundation/STATE.md`

```markdown
# STATE — [Nome do Projeto]

## Iniciado em: YYYY-MM-DD
## Contexto: Brownfield | Greenfield

## Stack Identificada
[resumo da stack]

## Decisões Arquiteturais
| Data | Decisão | Justificativa |
|------|---------|---------------|
| YYYY-MM-DD | [decisão] | [por quê] |

## Bloqueios Ativos
- Nenhum

## Histórico de Features
| Feature | Status | Data |
|---------|--------|------|
```

---

## Passo 4 — Inicializar GitFlow

```bash
# Instalar git-flow se não existir
brew install git-flow-avh   # macOS
apt-get install git-flow    # Linux

# Inicializar no repositório
git flow init

# Configuração recomendada (Enter em todas as perguntas padrão):
# Branch de produção: main
# Branch de desenvolvimento: develop
# Prefixo de features: feature/
# Prefixo de releases: release/
# Prefixo de hotfixes: hotfix/
# Prefixo de support: support/
# Tag prefix: v
```

Para detalhes completos da integração GitFlow, leia `workflows/gitflow.md`.

---

## Passo 5 — Apresentar Resumo

Apresente ao usuário:
- Contexto detectado (Greenfield/Brownfield)
- Stack identificada ou definida
- Artefatos criados
- Próximo passo sugerido (`/ngsdd:specify [nome-da-feature]` ou `/ngsdd:research`)

Aguarde confirmação antes de avançar.
