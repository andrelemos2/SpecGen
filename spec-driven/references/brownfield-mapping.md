# Mapeamento Brownfield

**Gatilho:** "Mapear base de código", "Analisar código existente", "Documentar arquitetura atual" (ou equivalentes em inglês: "Map codebase", "Analyze existing code", "Document current architecture").

**Propósito:** Compreender a estrutura do projeto existente antes de adicionar novas funcionalidades.

## Processo

Antes de iniciar, verifique se a skill `codebase-navigator` está disponível para exploração de código (ver Integração com Outras Skills no SKILL.md). Se estiver disponível, prefira-a para todas as tarefas de descoberta e navegação abaixo.

**Abordagem de alto nível:**

1. Explorar a estrutura de diretórios sistematicamente
2. Identificar a stack de tecnologia a partir dos manifestos de dependências
3. Extrair padrões de amostras de código representativas
4. Documentar convenções e arquiteturas observadas
5. Catalogar integrações externas
6. Identificar preocupações: débitos técnicos, bugs conhecidos, riscos de segurança, gargalos de desempenho, áreas frágeis

**Profundidade da análise:**

- Amostrar de 5 a 10 arquivos representativos por categoria
- Focar na consistência e nos padrões, não em uma cobertura exaustiva
- Extrair exemplos reais, não suposições

## Entregável: 7 Arquivos em .specs/codebase/

---

### 1. STACK.md

**Propósito:** Documentar a stack de tecnologia e as dependências.

**Limite de tamanho:** 2.000 tokens (~1.200 palavras)

**Extrair de:**

- Arquivos de manifesto de dependências
- Configurações de build
- Configurações de runtime

**Documento:**

```markdown
# Stack de Tecnologia

**Analisado em:** [data]

## Núcleo (Core)

- Framework: [nome detectado + versão]
- Linguagem: [nome detectado + versão]
- Runtime: [nome detectado + versão]
- Gerenciador de pacotes: [gerenciador detectado]

## Frontend (se aplicável)

- Framework de UI: [nome + versão]
- Estilização: [abordagem + ferramentas]
- Gerenciamento de Estado: [biblioteca/padrão]
- Manipulação de Formulários: [biblioteca se houver]

## Backend (se aplicável)

- Estilo da API: [REST/GraphQL/gRPC + framework]
- Banco de Dados: [ORM/query builder + sistema de banco de dados]
- Autenticação: [biblioteca/abordagem]

## Testes

- Unitários: [framework]
- Integração: [framework]
- E2E: [framework se houver]

## Serviços Externos

- [Categoria]: [Nome do serviço]
- [Categoria]: [Nome do serviço]

## Ferramentas de Desenvolvimento

- [Categoria da ferramenta]: [Nome da ferramenta]
```

**Instruções:**

- Extrair dos arquivos de dependência reais
- Incluir versões para as principais dependências
- Categorizar por propósito
- Anotar os frameworks de teste explicitamente

---

### 2. ARCHITECTURE.md

**Propósito:** Documentar padrões arquiteturais e fluxo de dados.

**Limite de tamanho:** 4.000 tokens (~2.400 palavras)

**Extrair de:**

- Organização de diretórios
- Análise da estrutura do código
- Padrões repetidos nos arquivos

**Documento:**

```markdown
# Arquitetura

**Padrão:** [Padrão identificado - monolito/microserviços/modular/etc]

## Estrutura de Alto Nível

[Criar diagrama/descrição com base na organização real]

## Padrões Identificados

### [Nome do Padrão]

**Localização:** [onde este padrão reside]
**Propósito:** [o que isso alcança]
**Implementação:** [como está estruturado]
**Exemplo:** [referência ao arquivo/função real]

### [Nome do Padrão]

[Mesma estrutura]

## Fluxo de Dados

### [Fluxo Chave - ex: Autenticação/Pagamento/etc]

[Mapear o fluxo real a partir da análise do código]

### [Fluxo Chave]

[Mapear o fluxo real]

## Organização do Código

**Abordagem:** [baseada em features/baseada em camadas/domain-driven/etc]

**Estrutura:**
[Documentar a organização real de diretórios]

**Limites de Módulos:**
[Como o código é dividido em módulos/pacotes]
```

**Instruções:**

- Identificar padrões a partir do código real, não de suposições
- Documentar as decisões arquiteturais observadas
- Criar diagramas de fluxo para caminhos críticos
- Referenciar exemplos concretos da base de código

---

### 3. CONVENTIONS.md

**Propósito:** Documentar o estilo de código e as convenções de nomenclatura.

**Limite de tamanho:** 3.000 tokens (~1.800 words)

**Extrair de:**

- Analisar de 5 a 10 arquivos representativos
- Identificar padrões consistentes
- Observar as convenções reais em uso

**Documento:**

```markdown
# Convenções de Código

## Convenções de Nomenclatura

**Arquivos:**
[Padrão observado - documentar a abordagem real]
Exemplos: [nomes de arquivos reais da base de código]

**Funções/Métodos:**
[Padrão observado]
Exemplos: [nomes de funções reais]

**Variáveis:**
[Padrão observado]
Exemplos: [nomes de variáveis reais]

**Constantes:**
[Padrão observado]
Exemplos: [nomes de constantes reais]

## Organização do Código

**Declaração de Importações/Dependências:**
[Padrão de ordenação observado]
[Exemplo de arquivo real]

**Estrutura do Arquivo:**
[Organização observada dentro dos arquivos]
[Exemplo de arquivo real]

## Segurança de Tipos/Documentação

**Abordagem:** [Abordagem de tipagem/documentação usada]
[Exemplo de código real]

## Tratamento de Erros

**Padrão:** [Abordagem de tratamento de erros observada]
[Exemplo de código real]

## Comentários/Documentação

**Estilo:** [Quando/como os comentários são usados]
[Exemplo de código real]
```

**Instruções:**

- Extrair padrões de amostras de código reais
- Documentar convenções observadas, não convenções ideais
- Incluir exemplos concretos da base de código
- Anotar exceções ou variações onde forem encontradas

---

### 4. STRUCTURE.md

**Propósito:** Documentar o layout de diretórios e a organização dos arquivos.

**Limite de tamanho:** 2.000 tokens (~1.200 palavras)

**Documento:**

```markdown
# Estrutura do Projeto

**Raiz:** [caminho da raiz do projeto]

## Árvore de Diretórios

[Representação visual da árvore - máx. 3 níveis de profundidade]

## Organização dos Módulos

### [Nome do Módulo/Área]

**Propósito:** [o que esta área manipula]
**Localização:** [onde os arquivos residem]
**Arquivos chave:** [arquivos importantes nesta área]

### [Nome do Módulo/Área]

[Mesma estrutura]

## Onde as Coisas Ficam

**[Capacidade/Funcionalidade]:**

- UI/Interface: [localização]
- Lógica de Negócios: [localização]
- Acesso a Dados: [localização]
- Configuração: [localização]

**[Capacidade/Funcionalidade]:**
[Mesma estrutura]

## Diretórios Especiais

**[Nome do diretório]:**
**Propósito:** [o que pertence aqui]
**Exemplos:** [arquivos chave neste diretório]
```

**Instruções:**

- Criar visão em árvore da estrutura de diretórios real
- Limitar a profundidade para manter a legibilidade
- Documentar o propósito dos diretórios principais
- Mapear capacidades para localizações físicas

---

### 5. TESTING.md

**Propósito:** Documentar a infraestrutura e os padrões de teste.

**Limite de tamanho:** 4.000 tokens (~2.400 palavras)

**Documento:**

```markdown
# Infraestrutura de Testes

## Frameworks de Teste

**Unitários/Integração:** [nome do framework + versão]
**E2E:** [nome do framework + versão]
**Cobertura:** [ferramenta se usada]

## Organização dos Testes

**Localização:** [onde os testes residem]
**Nomenclatura:** [padrão de nomenclatura de arquivos de teste]
**Estrutura:** [como os testes são organizados]

## Padrões de Teste

### Testes Unitários

**Abordagem:** [padrão observado]
**Localização:** [onde residem os testes unitários]
[Descrição do padrão real usado]

### Testes de Integração

**Abordagem:** [padrão observado]
**Localização:** [onde residem os testes de integração]
[Descrição do padrão real usado]

### Testes E2E

**Abordagem:** [padrão observado se houver]
**Localização:** [onde residem os testes E2E]
[Descrição do padrão real usado]

## Execução dos Testes

**Comandos:** [como rodar os testes]
**Configuração:** [abordagem de configuração dos testes]

## Metas de Cobertura

**Atual:** [se mensurável]
**Objetivos:** [se documentado]
**Imposição:** [se automatizado]

## Matriz de Cobertura de Testes

Analise a base de código para determinar quais camadas de código exigem quais tipos de teste.
Para cada camada, documente o tipo de teste exigido, o padrão de localização dos arquivos e o comando de execução.

| Camada de Código | Tipo de Teste Exigido | Padrão de Localização | Comando de Execução |
| :--- | :--- | :--- | :--- |
| [camada] | [unit/integration/e2e/none] | [padrão glob ou caminho] | [comando] |

## Avaliação de Paralelismo

| Tipo de Teste | Seguro para Paralelismo? | Modelo de Isolamento | Evidência |
| :--- | :--- | :--- | :--- |
| [tipo] | [Sim/Não] | [descrição] | [arquivo/padrão que comprova] |

## Comandos de Verificação de Gate

| Nível do Gate | Quando Usar | Comando |
| :--- | :--- | :--- |
| Rápido (Quick) | Após tarefas apenas com testes unitários | [comando de testes unitários] |
| Completo (Full) | Após tarefas com testes e2e/integração | [comandos de testes unitários + e2e] |
| Build | Após conclusão de fase | [build + lint + unit + e2e] |
```

**Instruções:**

- Identificar frameworks de teste a partir de dependências e código
- Documentar os padrões reais de teste observados
- Anotar a abordagem de organização dos testes
- Incluir instruções de execução
- **Matriz de Cobertura de Testes:** Amostrar de 5 a 10 arquivos de teste existentes para identificar quais camadas são testadas e como. Observar a localização dos arquivos de teste em relação ao código-fonte para determinar padrões. Extrair os comandos de execução de `package.json`, `project.json`, `Makefile`, configs de CI. Marcar camadas sem testes existentes como "none" com uma nota no CONCERNS.md.
- **Avaliação de Paralelismo:** Sinais de que NÃO é seguro para paralelismo: conexão compartilhada de BD (mesma URL de configuração), limpeza no nível da tabela no `beforeEach`/`afterAll` (`.del()`, `DELETE FROM`, `TRUNCATE`), reset de estado de mock compartilhado em variáveis globais. Sinais de que é seguro para paralelismo: criação de BD por teste (Testcontainers, schema dinâmico, SQLite em memória), namespacing de dados (todos os dados identificados por ID exclusivo do teste), sem estado mutável compartilhado entre arquivos de teste, todas as dependências mockadas (`jest.fn()`, `vi.fn()`).
- **Comandos de Verificação de Gate:** Extrair dos comandos reais do projeto — não invente comandos.

---

### 6. INTEGRATIONS.md

**Propósito:** Documentar integrações com serviços externos.

**Limite de tamanho:** 5.000 tokens (~3,000 palavras)

**Documento:**

```markdown
# Integrações Externas

## [Categoria do Serviço]

**Serviço:** [nome do serviço]
**Propósito:** [o que esta integração fornece]
**Implementação:** [onde a integração reside no código]
**Configuração:** [como o serviço é configurado]
**Autenticação:** [abordagem de autenticação, se aplicável]

## [Categoria do Serviço]

[Mesma estrutura]

## Integrações de API

### [Nome da API]

**Propósito:** [o que esta API fornece]
**Localização:** [onde o cliente/código da API reside]
**Autenticação:** [método de autenticação]
**Endpoints principais:** [endpoints principais utilizados]

## Webhooks

### [Origem do Webhook]

**Propósito:** [quais eventos são tratados]
**Localização:** [localização do handler do webhook]
**Eventos:** [tipos de eventos processados]

## Tarefas em Segundo Plano (Background Jobs)

**Sistema de fila:** [sistema usado, se houver]
**Localização:** [onde as definições das tarefas residem]
**Tarefas:** [tarefas chave em segundo plano]
```

**Instruções:**

- Identificar integrações a partir do código e da configuração
- Documentar abordagens de autenticação
- Anotar os tratadores (handlers) de webhook se presentes
- Incluir a infraestrutura de tarefas em segundo plano

---

### 7. CONCERNS.md

**Propósito:** Expor avisos acionáveis sobre a base de código — débitos técnicos, bugs conhecidos, falhas de segurança, gargalos de desempenho, áreas frágeis, limites de escala, dependências arriscadas, funcionalidades ausentes e lacunas na cobertura de testes.

**Limite de tamanho:** 5.000 tokens (~3.000 palavras)

Consulte [concerns.md](concerns.md) para obter o template completo, diretrizes e exemplos.

**Instruções:**

- Documentar apenas preocupações fundamentadas em evidências (caminhos de arquivos, medições, passos para reprodução)
- Incluir abordagens de correção, não apenas problemas
- Omitir seções sem descobertas
- Priorizar por risco/impacto
- Usar um tom profissional e orientado a soluções

---

## Orçamento de Contexto Total

**Combinado:** ~19.000 tokens (10% da janela de contexto)
**Aceitável para:** Projetos brownfield que exigem compreensão da base de código
**Estratégia de carregamento:** Carregar documentos relevantes sob demanda com base na tarefa
