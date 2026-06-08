# Fase 5 — EXECUTE: Implementação Cirúrgica

> **Owner:** Engenheiro(s) responsável(is) pela feature
> **Comando:** `/specgen:execute`
> **Sempre obrigatória** — Quick Path e Full Path.

---

## Objetivo

Implementar a feature com rigor e TDD.
**Nenhuma linha de código sem teste. Nenhum arquivo fora do delta.md.**

---



Leia os artefatos aprovados na ordem:
1. `.sdd/specs/[slug]/spec.md` → o contrato
2. `.sdd/specs/[slug]/design.md` → a arquitetura
3. `.sdd/specs/[slug]/delta.md` → os arquivos a tocar
4. `.sdd/specs/[slug]/tasks.md` → a ordem de execução

---

## Passo 1 — Delegação para os Subagentes (Pair Programming Agêntico)

**Orquestrador:** NÃO escreva o código manualmente no chat principal. Sua função é delegar as tarefas do `tasks.md` seguindo o fluxo de Pair Programming Agêntico:

1. **Implementação:** Invoque a skill `specgen-execute` passando as instruções da tarefa (incluindo os caminhos de `spec.md` e `delta.md`). O `specgen-execute` deverá seguir rigorosamente o ciclo TDD (RED-GREEN-REFACTOR).
2. **Revisão:** Assim que o `specgen-execute` terminar, invoque a skill `specgen-reviewer` passando a mesma tarefa e os arquivos alterados para auditoria e combate à entropia.
3. **Feedback Loop:** Se o revisor apontar problemas ou entropia, devolva o feedback para o `specgen-execute` corrigir. Repita até a aprovação.

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
- [ ] O código foi aprovado e revisado pelo `specgen-reviewer` (Pair Programming Agêntico)?

Se **qualquer item falhar**: PARE. Documente o bloqueio em `STATE.md`. Comunique ao usuário.

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
4. Avance para `/specgen:archive`.
