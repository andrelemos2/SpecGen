# Especificação do .notebook/

Leia este arquivo quando precisar criar ou atualizar notas durante a fase de
Debriefing, ou quando precisar entender o formato do notebook durante o
Briefing.

## Estrutura

```
.notebook/
├── INDEX.md          # Sempre lido primeiro. Índice compacto de todas as notas.
├── auth-flow.md      # Arquivos de notas individuais — lineares por padrão.
├── error-handling.md
└── checkout-race.md
```

As notas começam organizadas de forma linear (flat) na raiz do `.notebook/`.
Quando o volume exceder cerca de 15 notas, organize-as em subdiretórios por
categoria:

```
.notebook/
├── INDEX.md
├── flows/
│   ├── auth-flow.md
│   └── checkout-flow.md
├── patterns/
│   └── error-handling.md
├── gotchas/
│   └── checkout-race.md
└── domain/
    └── coupon-types.md
```

Categorias:

- **flows** — Como as coisas funcionam. Integrações, sequências, caminhos de dados.
- **patterns** — Como as coisas são feitas aqui. Convenções, estruturas recorrentes.
- **gotchas** — Armadilhas. Bugs, peculiaridades, comportamento contraintuitivo.
- **domain** — Conceitos de negócios. Terminologia, regras, lógica não óbvia no código.

Estas categorias são diretrizes, não regras rígidas. Se uma nota se encaixar
em múltiplas categorias, escolha a principal. Se nenhuma servir, coloque-a na raiz.

## Formato do INDEX.md

O índice deve ser compacto. Uma linha por nota. A IA lê isso a cada sessão,
então cada byte conta.

```markdown
# .notebook
> Inteligência do projeto — leia antes de cada missão

Última atualização: 2026-02-22

- [auth-flow](auth-flow.md) — OAuth2 + rotação de refresh | flow | auth, seguranca
- [error-handling](error-handling.md) — Error boundaries + hook customizado | pattern | react, erros
- [checkout-race](checkout-race.md) — Corrida crítica na atualização do carrinho | gotcha | checkout, carrinho
- [coupon-types](coupon-types.md) — Regras de porcentagem vs valor fixo vs compre/ganhe | domain | cupons, preco
```

Formato por linha:

```
- [slug](caminho) — resumo (máx ~80 caracteres) | categoria | tags
```

Regras para o INDEX.md:

- Mantenha os resumos curtos e fáceis de escanear.
- Tags são em letras minúsculas, separadas por vírgula. Use-as para grep rápido.
- Atualize `Última atualização` sempre que o índice mudar.
- Se usar subdiretórios, os caminhos devem incluir a pasta: `flows/auth-flow.md`.
- Ordene pelo mais recentemente atualizado, não alfabeticamente.

## Formato Individual das Notas

As notas são telegráficas. Pense em notas de campo, não em documentação.

```markdown
# Auth Flow
> OAuth2 com rotação de refresh token

Entrada: `src/middleware/auth.ts:authMiddleware()` (L12)
Fluxo: middleware → `services/auth/jwt.ts:verify()` → `services/user/find.ts:findById()`

Refresh: `services/auth/refresh.ts:rotateToken()`
- Tokens de uso único — consumidos na atualização, novo par emitido
- Armazenado no Redis com TTL (ver `lib/redis.ts:sessionStore`)

Provedores OAuth: `config/oauth.ts` — Google, GitHub
- Cada provedor mapeia para `services/auth/oauth/[provider].ts`

Sessão: Baseada em Redis via `lib/redis.ts` (L45-62)

Atualizado: 2026-02-22
```

### Princípios de formato

1. **Ponteiros, não cópias.** Sempre referencie como:
   - `caminho/do/arquivo.ts:nomeDaFuncao()` para funções
   - `caminho/do/arquivo.ts` (L10-25) para intervalos de linhas específicos
   - `caminho/do/arquivo.ts:NomeDaClasse.metodo()` para métodos de classe
   Nunca cole blocos de código nas notas. O código muda; os ponteiros podem
   ser checados novamente. Código colado torna-se mentiras desatualizadas.

2. **Um conceito por nota.** Se precisar de rolagem, divida-a.
   Uma nota sobre o fluxo de autenticação não deve cobrir também o gerenciamento
   de sessões, a menos que sejam inseparáveis.

3. **Prosa mínima.** Use fragmentos, setas, traços. Não frases completas.
   "middleware → verificar JWT → carregar usuário → anexar à req" é melhor
   do que "O middleware primeiro verifica o token JWT, depois carrega
   o usuário do banco de dados e finalmente o anexa ao objeto da requisição."

4. **Sempre inclua o Ponto de entrada.** Toda nota deve ter um ponto de entrada
   claro para que o leitor saiba por onde começar a explorar.

5. **Sempre inclua a Data de atualização.** Para que o leitor saiba quão fresca
   está a informação.

6. **Sem opiniões, apenas observações.** "Usa Redux para estado", não "Usa Redux
   em vez de uma solução melhor." Se algo for genuinamente problemático, declare
   o impacto observável: "A store do Redux tem 47 chaves de nível superior — encontrar
   o estado relevante exige pesquisar em 12 reducers."

## Criando o .notebook/ pela Primeira Vez

Quando o `.notebook/` ainda não existir:

1. Crie o diretório.
2. Crie o INDEX.md apenas com o cabeçalho:

   ```markdown
   # .notebook
   > Inteligência do projeto — leia antes de cada missão

   Última atualização: [hoje]
   ```

3. NÃO faça uma análise completa do projeto de imediato. As notas são criadas
   organicamente à medida que você trabalha. As primeiras notas virão do
   Debriefing da sua primeira missão.

## Atualizando Notas

Ao atualizar uma nota existente:

1. Leia o conteúdo atual.
2. Adicione, modifique ou remova informações com base no que você descobriu.
3. Atualize a data de `Atualizado` na parte inferior.
4. Se o resumo no INDEX.md mudou, atualize-o também.

Quando as informações se tornarem inválidas (por exemplo, um fluxo mudou por causa
do seu trabalho), atualize a nota imediatamente — notas desatualizadas são piores
do que nenhuma nota.

## Orçamento de Tokens

Todo o sistema do `.notebook/` é projetado para divulgação progressiva (progressive disclosure):

- **INDEX.md** é lido a cada sessão (~5-50 linhas). Custo: mínimo.
- **Notas individuais** são lidas apenas quando relevantes para a missão atual.
  A IA decide quais abrir com base nas tags do INDEX.md.
- **Custo total por sessão:** INDEX.md + 0-3 notas relevantes.

Se o INDEX.md crescer além de 50 entradas, considere arquivar as notas antigas
em um subdiretório `archive/` e removê-las do índice ativo. Notas arquivadas
ainda são pesquisáveis, mas não são carregadas por padrão.
