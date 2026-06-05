# Ferramentas de Análise de Código

Use degradação graciosa para busca de código e análise estrutural.

## Prioridade das Ferramentas

1. **ast-grep** (`sg`) - Busca estrutural baseada em padrões
2. **ripgrep** (`rg`) - Busca rápida de texto com consciência de contexto
3. **grep** - Busca de texto padrão (sempre disponível)

## Detecção

Verifique a disponibilidade das ferramentas antes do uso:

```bash
# Verificar ast-grep
if command -v sg >/dev/null 2>&1; then
  # Usar ast-grep para busca estrutural
elif command -v rg >/dev/null 2>&1; then
  # Usar ripgrep como fallback
else
  # Usar grep padrão como último recurso
fi
```

## Exemplos de Uso

**Encontrando definições de funções:**

```bash
# ast-grep (melhor - estrutural)
sg -p 'function $NAME($$$) { $$$ }'

# ripgrep (fallback - busca rápida de texto)
rg '^function\s+\w+\(' --type-add 'source:*.[extension]' -t source

# grep (último recurso - básica)
grep -r '^function ' --include="*.[extension]"
```

**Encontrando importações/requires:**

```bash
# ast-grep
sg -p 'import { $$$ } from "$MODULE"'

# ripgrep
rg '^import .* from' --type-add 'source:*.[extension]' -t source

# grep
grep -r '^import ' --include="*.[extension]"
```

**Encontrando definições de classes/componentes:**

```bash
# ast-grep
sg -p 'class $NAME { $$$ }'

# ripgrep
rg '^(class|export class)\s+\w+' --type-add 'source:*.[extension]' -t source

# grep
grep -r '^class ' --include="*.[extension]"
```

## Escopo da Busca

**Melhores práticas:**

- Limitar às extensões de arquivo de código relevantes para o projeto
- Excluir diretórios: `node_modules`, `vendor`, `dist`, `build`, `.git`
- Focar em diretórios de código-fonte: `src`, `lib`, `app`
- Usar filtros de tipo de arquivo quando disponíveis

**Dicas de desempenho:**

- Usar padrões específicos em vez de buscas amplas
- Limitar a profundidade dos diretórios com `--max-depth` (ripgrep/grep)
- Fazer cache dos resultados para consultas repetidas

## Aviso de Fallback

Se o ast-grep não estiver disponível, exiba uma vez por sessão:

```
⚠️ ast-grep não detectado. Instale para uma análise estrutural de código mais precisa.
   https://ast-grep.github.io/guide/quick-start.html
```

## Quando Usar

- Encontrar padrões de uso em toda a base de código
- Identificar a estrutura e organização do código
- Localizar definições de funções/classes/componentes
- Analisar padrões de importações/dependências
- Análise de impacto de refatoração
- Navegação de código em bases de código desconhecidas
