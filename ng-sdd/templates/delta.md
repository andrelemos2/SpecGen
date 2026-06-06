# Template: Delta Spec (Contrato de Mudança)

> Copie para `.sdd/specs/[feature-slug]/delta.md`
> Owner: Tech Lead da feature
> Inspirado no padrão OpenSpec (ADDED/MODIFIED/REMOVED)

---

# Delta Spec: [Feature Name]

**ID:** FEAT-[NNN]
**Data:** YYYY-MM-DD
**Status:** DRAFT | APPROVED

> **Regra de Ouro:** Qualquer arquivo não listado aqui que for criado ou modificado
> durante a execução é **scope creep** e deve ser revertido ou adicionado aqui com aprovação.

---

## ADDED (Arquivos novos)

```
- [ ] src/modules/[feature]/[feature].module.ts
- [ ] src/modules/[feature]/[feature].service.ts
- [ ] src/modules/[feature]/[feature].controller.ts
- [ ] src/modules/[feature]/dto/create-[feature].dto.ts
- [ ] src/modules/[feature]/dto/update-[feature].dto.ts
- [ ] src/modules/[feature]/entities/[feature].entity.ts
- [ ] src/modules/[feature]/[feature].repository.ts
- [ ] tests/[feature]/[feature].service.spec.ts
- [ ] tests/[feature]/[feature].controller.spec.ts
- [ ] tests/[feature]/[feature].e2e.spec.ts
```

---

## MODIFIED (Arquivos alterados)

```
- [ ] src/app.module.ts
      Motivo: Importar [Feature]Module

- [ ] src/routes/index.ts
      Motivo: Adicionar rota /[feature]

- [ ] [outro-arquivo]
      Motivo: [descreva a mudança exata]
```

---

## REMOVED (Arquivos removidos)

```
- [ ] src/legacy/[arquivo].ts
      Motivo: Substituído por [Feature]Module

- [ ] [outro-arquivo]
      Motivo: [descreva por que está sendo removido]
```

---

## Migrations (mudanças de schema)

```
- [ ] migrations/[TIMESTAMP]-create-[table]-table.ts
      Tipo: CREATE TABLE
      Rollback: DROP TABLE [table]

- [ ] migrations/[TIMESTAMP]-add-[column]-to-[table].ts
      Tipo: ADD COLUMN
      Rollback: DROP COLUMN [column]
```

---

## Variáveis de Ambiente (novas ou alteradas)

```
- [ ] FEATURE_X_ENABLED=true          # Feature flag
- [ ] FEATURE_X_TIMEOUT_MS=5000       # Timeout em ms
```

---

## Dependências (package.json)

```
## ADDED
- [ ] [package-name]@^x.y.z    # Motivo: [para que serve]

## REMOVED
- [ ] [package-name]            # Motivo: substituído por [outro]
```
