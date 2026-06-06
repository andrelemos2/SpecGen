# Fase 5 — EXECUTE: Implementação Cirúrgica

> **Owner:** Engenheiro(s) responsável(is) pela feature
> **Comando:** `/ngsdd:execute`
> **Sempre obrigatória** — Quick Path e Full Path.

---

## Objetivo

Implementar a feature com rigor, TDD e commits atômicos.
**Nenhuma linha de código sem teste. Nenhum arquivo fora do delta.md.**

---

## Antes de Começar

Verifique que você está na branch correta:

```bash
git branch --show-current
# Deve retornar: feature/FEAT-NNN-[feature-slug]

# Se não estiver:
git checkout feature/FEAT-NNN-[feature-slug]
```

Leia os artefatos aprovados na ordem:
1. `.sdd/specs/[slug]/spec.md` → o contrato
2. `.sdd/specs/[slug]/design.md` → a arquitetura
3. `.sdd/specs/[slug]/delta.md` → os arquivos a tocar
4. `.sdd/specs/[slug]/tasks.md` → a ordem de execução

---

## Passo 1 — Delegação para o Subagente (Orquestração)

**Orquestrador:** NÃO escreva o código manualmente no chat principal. Sua função é delegar as tarefas do `tasks.md` para a skill de subagente especializada (ex: `/ng-sdd-execute` com `model: swe`). 

Para cada tarefa (ou grupo de tarefas), invoque o subagente passando as instruções do que deve ser feito (incluindo o caminho da Spec e do Delta).
- **Sub-agentes Paralelos:** Se a plataforma permitir, invoque múltiplos subagentes simultaneamente para tarefas que não dependem uma da outra.
- **Acompanhamento:** Após despachar as tarefas para o(s) subagente(s), aguarde a conclusão deles antes de prosseguir.

O subagente acionado é quem deverá seguir os passos de TDD (RED-GREEN-REFACTOR) rigorosamente.

---

## Passo 2 — Ciclo TDD obrigatório por tarefa

Para cada tarefa de implementação, siga rigorosamente:

### 🔴 RED — Escreva o teste que falha
```typescript
// tests/feature-x/feature-x.service.spec.ts
describe('FeatureXService', () => {
  it('deve criar entidade e retornar com id', async () => {
    const dto = { name: 'Test', value: 42 };
    const result = await service.execute(dto);
    expect(result).toMatchObject({ name: 'Test', value: 42 });
    expect(result.id).toBeDefined();
  });
});
```
> Rode o teste. **Deve falhar.** Se passar sem implementação, o teste está errado.

### 🟢 GREEN — Escreva o mínimo para passar
```typescript
// src/modules/feature-x/feature-x.service.ts
async execute(dto: CreateFeatureXDto): Promise<FeatureXEntity> {
  return this.repo.save(this.repo.create(dto));
}
```
> Rode o teste. **Deve passar.**

### 🔵 REFACTOR — Melhore sem quebrar
- Aplique patterns (SOLID, DRY)
- Adicione validações
- Melhore nomes de variáveis
- Rode o teste novamente — **deve continuar passando**.

---

## Passo 3 — Quality Gate por Tarefa

Antes de marcar uma tarefa como DONE:

- [ ] O teste passou (GREEN)?
- [ ] O código está conforme `CONSTITUTION.md`?
- [ ] O arquivo criado/modificado está no `delta.md`?
- [ ] Nenhum arquivo "surpresa" foi criado?

Se **qualquer item falhar**: PARE. Documente o bloqueio em `STATE.md`. Comunique ao usuário.

---

## Passo 4 — Commits Atômicos (Conventional Commits)

Um commit por tarefa concluída:

```bash
# Padrão: <type>(<scope>): <descrição> [TASK-NNN]
git add src/modules/feature-x/feature-x.service.ts
git commit -m "feat(feature-x): add execute method [TASK-001]"

git add tests/feature-x/feature-x.service.spec.ts
git commit -m "test(feature-x): add unit tests for execute [TASK-002]"

git add migrations/
git commit -m "chore(db): create feature-x table migration [TASK-003]"
```

**Tipos permitidos:**
| Tipo | Quando usar |
|------|-------------|
| `feat` | Nova funcionalidade |
| `fix` | Correção de bug |
| `test` | Adicionar ou corrigir testes |
| `refactor` | Refatoração sem mudança de comportamento |
| `chore` | Configurações, build, migrations |
| `docs` | Apenas documentação |
| `perf` | Melhoria de performance |

---

## Passo 5 — Sincronização com develop (quando necessário)

Se a feature demorar mais de 1 dia, faça rebase periódico para evitar conflitos grandes:

```bash
# Puxe as atualizações do develop
git fetch origin
git rebase origin/develop

# Resolva conflitos se necessário
git rebase --continue

# Force-push na sua branch (é seguro porque é uma feature branch)
git push origin feature/FEAT-NNN-[slug] --force-with-lease
```

> **Regra:** Faça rebase com `develop` ao menos uma vez por dia em features longas.
> Para detalhes de sincronização GitFlow, leia `workflows/gitflow.md`.

---

## Passo 6 — Atualizar tasks.md

Após cada tarefa concluída, atualize o status em `tasks.md`:
```markdown
### TASK-001 — Criar FeatureXService
- **Status:** ✅ DONE
- **Commit:** abc1234
```

---

## Passo 7 — Finalizar

Quando **todas as tarefas** estiverem DONE:
1. Rode a suite de testes completa: `npm test`
2. Verifique cobertura: `npm run test:cov`
3. Rode o linter: `npm run lint`
4. Push final da branch: `git push origin feature/FEAT-NNN-[slug]`
5. Avance para `/ngsdd:archive`.
