# Checklist de Requisitos e Estimativas

Este guia serve como referência rápida para o Passo 1 e Passo 1.5 do desenho de System Design.

---

## 📋 Checklist de Requisitos

### Requisitos Funcionais (FR)
- Quem é o ator principal do sistema? (Usuário final, sistema parceiro, admin)
- Quais são os 2 a 3 casos de uso essenciais?
  - *Ex: Criar post, ver feed, curtir/comentar.*
- O que está explicitamente **fora do escopo**?
  - *Ex: Não vamos nos preocupar com buscas ou sistema de ads hoje.*

### Requisitos Não-Funcionais (NFR)
- **Escala/Volumetria**: Qual o DAU (Daily Active Users) ou MAU (Monthly Active Users)?
- **Disponibilidade**: Alta disponibilidade (HA) é mais importante que consistência forte? (Teorema CAP)
- **Latência**: Qual a latência aceitável na leitura? (Ex: < 200ms para feeds, tempo real de verdade < 50ms)
- **Durabilidade**: Os dados podem ser perdidos em caso de falha catastrófica? (Ex: transações financeiras = perda zero; logs = tolerável)

---

## 🧮 Fórmulas de Estimativa ("Contas de Padaria")

Sempre utilize aproximações e potências de 10 para facilitar os cálculos de cabeça.

### 1. Conversão de QPS/RPS
Aproximação útil: **1 dia tem ~100.000 segundos** (exatamente 86.400).
- Se o sistema tem 10 milhões de requisições por dia:
  $$\text{RPS} = \frac{10.000.000}{100.000} = 100 \text{ RPS}$$
- RPS de pico costuma ser estimado em $2 \times$ ou $5 \times$ o RPS médio.

### 2. Armazenamento (Storage)
$$\text{Storage Diário} = \text{Escrita por dia} \times \text{Tamanho do Payload}$$
- Exemplo: 10 milhões de posts diários, cada um com 100 KB de dados (metadados + imagem otimizada):
  $$10.000.000 \times 100.000 \text{ bytes} = 1.000.000.000.000 \text{ bytes} = 1 \text{ TB por dia}$$
- Em 1 ano: $365 \text{ TB} \approx 400 \text{ TB}$ (considerando replicação e índices, estime em $1.5 \times$ ou $2 \times \rightarrow \approx 800 \text{ TB}$).

### 3. Memória para Cache (Regra 80/20)
Geralmente, **80% dos acessos focam em 20% dos dados** (dados quentes).
- Se o volume de leitura diária é de 1 TB:
  $$\text{Cache necessário} = 20\% \text{ de } 1 \text{ TB} = 200 \text{ GB de RAM}$$

---

## 💾 Tabela de Unidades e Tamanhos de Referência

| Unidade | Potência | Equivalente aproximado |
|---|---|---|
| **Kilobyte (KB)** | $10^3$ | 1 página de texto simples (~2 KB) |
| **Megabyte (MB)** | $10^6$ | 1 foto de celular de alta qualidade (~2 a 5 MB) |
| **Gigabyte (GB)** | $10^9$ | 1 filme em HD (~1.5 GB) |
| **Terabyte (TB)** | $10^{12}$ | 1 milhão de fotos (~1 MB cada) |
| **Petabyte (PB)** | $10^{15}$ | Upload diário de dados do Facebook (~4 PB) |

---

## 🧩 Building Blocks AWS — Mapeamento de Padrões

| Cenário / Requisito | Serviço AWS Recomendado | Justificativa de Trade-off |
|---|---|---|
| **Baixa Latência Global (Leitura)** | CloudFront (CDN) + ElastiCache (Redis) | Evita queries repetitivas ao banco principal; cache de borda distribui estáticos. |
| **Upload de Arquivos Pesados** | S3 com Presigned URLs | Poupa largura de banda do servidor de aplicação; cliente faz upload direto para o bucket de forma segura. |
| **Mensagens Assíncronas (Fila)** | Amazon SQS | Garantia de entrega (at-least-once), desacoplamento simples e escalabilidade automática sem gerenciar infra. |
| **Processamento em Tempo Real (Event Stream)** | Amazon Kinesis Data Streams | Preserva ordenação por chave de partição; ideal para logs, tracking de clicks e chat. |
| **Bancos de Dados NoSQL Flexíveis** | Amazon DynamoDB | Latência consistente em milissegundos em qualquer escala (chave-valor / documento); sem gerenciar conexões. |
| **Consultas Complexas e Relacionais** | Amazon RDS (Aurora PostgreSQL) | Suporte a ACID, relacionamentos complexos, consistência forte nativa. |
