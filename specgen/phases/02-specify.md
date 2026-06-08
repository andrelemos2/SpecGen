# Fase 2 — SPECIFY: Especificação (Source of Truth)

> **Owner:** Product Engineer / Tech Lead da feature
> **Comando:** `/specgen:specify [feature-slug]`
> **Sempre obrigatória** — Quick Path e Full Path.

---

## Objetivo

Criar o contrato de software que guiará toda a implementação.
A spec aprovada é a única fonte da verdade — nenhuma implementação pode ir além dela.

---

## Passo 1 — Criar estrutura da feature

```bash
mkdir -p .sdd/specs/[feature-slug]
```



---

## Passo 2 — Criar spec.md

Copie o template em `templates/spec.md` e preencha **todas as seções**.
Salve em `.sdd/specs/[feature-slug]/spec.md`.

### Seções obrigatórias da spec:

**Cabeçalho:**
```markdown
# Spec: [Feature Name]
**ID:** FEAT-[NNN]
**Slug:** [feature-slug]
**Tipo:** Feature | Bugfix | Refactor | Spike
**Path:** Full Path | Quick Path
**Data:** YYYY-MM-DD
**Status:** DRAFT
```

**Corpo (nunca pule nenhuma seção):**
- **Contexto:** Por que essa feature existe? Qual dor resolve?
- **User Stories / Jobs-to-be-done:** "Como [persona], quero [ação] para que [valor]."
- **Requisitos Funcionais (RF):** Lista numerada, cada item verificável e testável.
- **Requisitos Não-Funcionais (RNF):** Performance, segurança, escalabilidade, acessibilidade.
- **Critérios de Aceite (Gherkin/BDD):** Cenário principal + edge cases.
- **Fora do Escopo:** Lista explícita do que **não** será feito nessa feature.
- **Dependências:** Outras features, sistemas externos, infraestrutura.
- **Riscos Conhecidos:** Risco + mitigação para cada item.

---

## Passo 3 — Clareza dos Requisitos Funcionais

Cada RF deve ser:
- ✅ Testável: "O sistema deve retornar 200 OK em < 200ms"
- ✅ Específico: "O usuário pode filtrar por data, categoria e status"
- ❌ Vago: "O sistema deve ser rápido"
- ❌ Ambíguo: "O usuário pode ver seus dados"

**Exemplo de RF bem escrito:**
```markdown
- [ ] RF-01: O endpoint `POST /api/users` deve criar um novo usuário e retornar
  status 201 com o objeto do usuário criado (sem o campo `password`).
- [ ] RF-02: Senhas devem ser armazenadas com hash bcrypt (salt rounds = 12).
- [ ] RF-03: O email deve ser único; duplicatas retornam 409 Conflict com
  mensagem: `{"error": "EMAIL_ALREADY_EXISTS"}`.
```

---

## Passo 4 — Critérios de Aceite (BDD obrigatório)

Escreva ao menos: 1 cenário feliz (happy path) + 1 edge case + 1 cenário de erro.

```gherkin
Scenario: Criar usuário com dados válidos
  Given que o email "user@example.com" não existe no sistema
  When envio POST /api/users com {"email": "user@example.com", "password": "Str0ng!"}
  Then recebo status 201
  And o body contém {"id": "<uuid>", "email": "user@example.com"}
  And o campo "password" não está presente no response

Scenario: Tentar criar usuário com email duplicado
  Given que o email "user@example.com" já existe no sistema
  When envio POST /api/users com {"email": "user@example.com", "password": "Str0ng!"}
  Then recebo status 409
  And o body contém {"error": "EMAIL_ALREADY_EXISTS"}
```

---

## Passo 5 — Gate de Aprovação ✋

> Apresente a spec completa ao usuário.
> **Não avance para a próxima fase sem aprovação explícita.**
>
> Checklist de aprovação:
> - [ ] Todos os RFs são verificáveis e testáveis?
> - [ ] Os critérios BDD cobrem happy path e edge cases?
> - [ ] O "Fora do Escopo" está explícito?
> - [ ] As dependências estão mapeadas?
>
> Após aprovação, atualize `status` para `APPROVED` no cabeçalho da spec.
> Atualize `.sdd/foundation/STATE.md` com a nova feature em progresso.
