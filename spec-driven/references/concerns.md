# Fase: Preocupações da Base de Código (Codebase Concerns)

**Gatilho:** Parte do mapeamento brownfield, ou explicitamente "documentar preocupações", "encontrar débitos técnicos", "o que é arriscado nesta base de código" (ou termos equivalentes em inglês como "document concerns", "find tech debt", "what's risky in this codebase").

**Propósito:** Expor avisos acionáveis sobre a base de código. Focado em "o que prestar atenção ao fazer alterações". Esta é uma documentação viva, não uma lista de reclamações.

## Quando Gerar

O `CONCERNS.md` é gerado como parte do fluxo de mapeamento brownfield (junto com STACK.md, ARCHITECTURE.md, etc.). Ele também pode ser criado ou atualizado de forma independente quando:

- A exploração de uma nova área da base de código revela riscos
- A investigação de um bug revela problemas sistêmicos
- A implementação de uma funcionalidade encontra fragilidades inesperadas
- Uma auditoria de dependências revela riscos

## Processo

### 1. Coletar Evidências

Durante a exploração da base de código, procure por sinais concretos — não opiniões. Fontes de evidência:

- Padrões de código que indicam atalhos (comentários TODO/FIXME/HACK, lógica duplicada, falta de tratamento de erros)
- Lacunas na cobertura de testes (caminhos críticos não testados, casos de borda ausentes)
- Manifestos de dependências (pacotes desatualizados, bibliotecas depreciadas, alertas de segurança)
- Indicadores de desempenho (consultas N+1, índices ausentes, chamadas bloqueantes síncronas)
- Padrões de segurança (verificações de autenticação apenas no lado do cliente, entradas não validadas, segredos expostos)

### 2. Classificar e Documentar

Cada preocupação deve conter: **o que** é o problema, **onde** ele reside (caminhos dos arquivos), **por que** ele importa (impacto) e **como** corrigi-lo (abordagem).

### 3. Priorizar por Risco

Foque em preocupações que podem causar danos reais — perda de dados, brechas de segurança, falhas voltadas ao usuário, limites de escala. Problemas de estilo menores e TODOs normais não pertencem a este documento.

---

## Template: `.specs/codebase/CONCERNS.md`

**Limite de tamanho:** 5.000 tokens (~3.000 palavras)

```markdown
# Preocupações da Base de Código

**Data da Análise:** [AAAA-MM-DD]

## Débitos Técnicos

**[Área/Componente]:**

- Problema: [Qual é o atalho/solução temporária]
- Arquivos: [Caminhos de arquivo específicos entre crases]
- Por quê: [Por que foi feito desta forma]
- Impacto: [O que quebra ou degrada por causa disso]
- Abordagem de correção: [Como resolver isso adequadamente]

## Bugs Conhecidos

**[Descrição do bug]:**

- Sintomas: [O que acontece]
- Gatilho: [Como reproduzir]
- Arquivos: [Onde o bug reside]
- Solução temporária: [Mitigação temporária, se houver]
- Causa raiz: [Se conhecida]
- Bloqueado por: [Se estiver aguardando algo]

## Considerações de Segurança

**[Área que exige cuidados de segurança]:**

- Risco: [O que pode dar errado]
- Arquivos: [Onde o risco reside]
- Mitigação atual: [O que está implementado agora]
- Recomendações: [O que deve ser adicionado]

## Gargalos de Desempenho

**[Operação/endpoint lento]:**

- Problema: [O que está lento]
- Arquivos: [Onde o gargalo reside]
- Medição: [Números reais: "500ms p95", "Tempo de carregamento de 2s"]
- Causa: [Por que está lento]
- Caminho de melhoria: [Como acelerar]

## Áreas Frágeis

**[Componente/Módulo]:**

- Arquivos: [Onde a fragilidade reside]
- Por que frágil: [O que faz quebrar facilmente]
- Falhas comuns: [O que normalmente dá errado]
- Modificação segura: [Como alterar sem quebrar]
- Cobertura de testes: [Está testado? Lacunas?]

## Limites de Escala

**[Recurso/Sistema]:**

- Capacidade atual: [Números: "100 req/seg", "10 mil usuários"]
- Limite: [Onde quebra]
- Sintomas no limite: [O que acontece]
- Caminho de escala: [Como aumentar a capacidade]

## Dependências em Risco

**[Pacote/Serviço]:**

- Risco: [ex: "depreciado", "sem manutenção", "mudanças drásticas a caminho"]
- Impacto: [O que quebra em caso de falha]
- Plano de migração: [Alternativa ou caminho de atualização]

## Funcionalidades Críticas Ausentes

**[Lacuna de funcionalidade]:**

- Problema: [O que está faltando]
- Solução temporária atual: [Como os usuários lidam com isso]
- Bloqueios: [O que não pode ser feito sem isso]
- Complexidade da implementação: [Estimativa aproximada de esforço]

## Lacunas de Cobertura de Testes

**[Área não testada]:**

- O que não está testado: [Funcionalidade específica]
- Risco: [O que pode quebrar sem ser percebido]
- Prioridade: [Alta/Média/Baixa]
- Dificuldade para testar: [Por que ainda não está testado]

---

_Auditoria de preocupações: [data]_
_Atualize à medida que os problemas forem corrigidos ou novos forem descobertos_
```

**Inclua apenas seções que tenham descobertas.** Seções vazias devem ser omitidas por completo.

---

## O que Pertence vs. O que Não Pertence

**Incluir:**

- Débitos técnicos com impacto claro e abordagem de correção
- Bugs conhecidos com passos para reprodução
- Lacunas de segurança e recomendações de mitigação
- Gargalos de desempenho com medições reais
- Código frágil que quebra facilmente
- Limites de escala com números
- Dependências que precisam de atenção
- Funcionalidades ausentes que bloqueiam fluxos de trabalho
- Lacunas na cobertura de testes

**Excluir:**

- Opiniões sem evidências ("código está bagunçado")
- Reclamações sem soluções ("autenticação é horrível")
- Ideias de funcionalidades futuras (isso é para o planejamento de produto)
- TODOs normais (estes pertencem aos comentários do código)
- Decisões arquiteturais que funcionam bem
- Problemas menores de estilo de código

---

## Diretrizes de Escrita

- **Sempre inclua caminhos de arquivos** — Preocupações sem localizações não são acionáveis. Use crases: `src/arquivo.ts`
- Seja específico com as medições ("500ms p95", não "lento")
- Inclua passos de reprodução para bugs
- Sugira abordagens de correção, não apenas problemas
- Foque em itens acionáveis
- Priorize por risco/impacto

**Tom:** Profissional, não emocional. Orientado a soluções. Focado em riscos. Baseado em fatos.

- ✅ "Padrão de consulta N+1 em `app/api/courses/route.ts` — 1.2s p95 com mais de 50 cursos"
- ❌ "Consultas terríveis, tudo está lento"
- ✅ "Correção: adicionar índice em `user_id` na tabela `subscriptions`"
- ❌ "Precisa corrigir"

---

## Como o CONCERNS.md é Utilizado

- **Planejamento de funcionalidades:** Verifique o `CONCERNS.md` antes de projetar funcionalidades que tocam áreas sinalizadas
- **Estimativa de risco:** Use as áreas frágeis e os limites de escala para estimar o risco das alterações
- **Integração de novas sessões:** Carregue o `CONCERNS.md` para contextualizar sobre o que prestar atenção
- **Priorização de refatoração:** Use os débitos técnicos e lacunas de teste para planejar sprints de melhoria
- **Fase de implementação:** Consulte o arquivo antes de modificar qualquer componente sinalizado

Esta é uma documentação viva. Atualize à medida que problemas forem resolvidos ou novos forem descobertos durante qualquer fase do fluxo de trabalho.
