# Exemplos de Problemas e Diagnósticos Clássicos

Este documento serve como referência rápida para o Passo 1 e Passo 1.5, apresentando o diagnóstico arquitetural e as peças (Building Blocks AWS) adequadas para os problemas mais comuns de System Design.

---

## 🔗 1. Encurtador de URLs (TinyURL / Bit.ly)

### Diagnóstico
- **Read-heavy**: $100\times$ mais leituras que escritas.
- **Armazenamento**: Chave-valor simples (Hash curto $\rightarrow$ URL Longa).
- **Latência**: Altamente crítica no redirecionamento.

### 📋 Requisitos (FR e NFR)
- **FR**: Encurtar URL longa, redirecionar URL curta com HTTP 302/301, expiração opcional.
- **NFR**: Latência de leitura < 50ms, alta disponibilidade, escalabilidade infinita de leitura.

### 🧩 Peças AWS Recomendadas
- **CDN / Cache de Borda**: Amazon CloudFront (faz cache dos redirecionamentos mais frequentes).
- **Compute**: AWS Lambda + API Gateway (Serverless ideal para o tráfego intermitente de escritas).
- **Banco NoSQL**: Amazon DynamoDB (acesso chave-valor de sub-10ms em qualquer escala).
- **Cache Principal**: Amazon ElastiCache para Redis (evita queries no DynamoDB para links populares).

---

## 📸 2. Feed de Notícias do Instagram / Twitter

### Diagnóstico
- **Fan-out Complexo**: O sistema precisa propagar uma postagem para milhões de seguidores.
- **Leitura Intensa**: Usuários atualizam constantemente o feed.
- **Hot Data / Celebridades**: Usuários famosos causam gargalos de escrita no modelo Push (fan-out na escrita) ou gargalos de leitura no modelo Pull (fan-out na leitura).

### 📋 Requisitos (FR e NFR)
- **FR**: Publicar foto/post, curtir, ver feed cronológico de pessoas seguidas.
- **NFR**: Latência na leitura do feed < 200ms, postagens novas aparecem no feed em < 5s para usuários comuns.

### 🧩 Peças AWS Recomendadas
- **Ingestão**: Amazon API Gateway.
- **Mensageria (Event Stream)**: Amazon Kinesis Data Streams (preserva a ordem das postagens e permite múltiplos consumidores/workers processando em paralelo).
- **Processamento de Fan-out**: AWS Lambda ou ECS Fargate (consome eventos do Kinesis e calcula o feed para usuários normais).
- **Cache de Feed**: Amazon ElastiCache (Redis) - guarda os IDs dos posts dos feeds ativos dos usuários.
- **Banco Relacional / Metadados**: Amazon RDS Aurora PostgreSQL (metadados dos posts, dados de amizade/seguidores).
- **Armazenamento de Mídia**: Amazon S3 + CloudFront (imagens e vídeos).

---

## 🔔 3. Sistema de Notificações em Larga Escala (Push, Email, SMS)

### Diagnóstico
- **Write-heavy & Burst-heavy**: Eventos em lote (ex: Black Friday, Gols em tempo real) disparam picos massivos de escrita.
- **Desacoplamento Crítico**: Provedores terceiros (APNs, Firebase Cloud Messaging, Sendgrid) têm limites de rate limit e falham constantemente.

### 📋 Requisitos (FR e NFR)
- **FR**: Enviar notificação transacional ou de marketing via múltiplos canais (Email, Push, SMS).
- **NFR**: Entrega rápida (< 10s para transacional), controle de concorrência e filas dedicadas.

### 🧩 Peças AWS Recomendadas
- **Desacoplamento (Filas)**: Amazon SQS (filas separadas por prioridade e por tipo de canal).
- **Fan-out de Eventos**: Amazon SNS (publica um evento que é roteado para diferentes filas SQS).
- **Workers (Consumidores)**: ECS Fargate com auto-scaling baseado na métrica `ApproximateNumberOfMessagesVisible` do SQS.
- **Banco de Preferências**: Amazon DynamoDB (guarda tokens de aparelhos, e-mails e preferências de notificações de cada usuário).
- **Monitoramento e Dead Letter Queue (DLQ)**: CloudWatch para alarmes + SQS DLQ para mensagens que falharam consecutivamente.

---

## 🕷️ 4. Web Crawler (Rastreador Web)

### Diagnóstico
- **I/O Heavy & Altamente Distribuído**: Muitas conexões simultâneas com servidores externos.
- **Controle de Polidez (Politeness)**: Não podemos derrubar o mesmo site com milhões de requisições simultâneas.
- **Deduplicação**: Identificar URLs e conteúdos já processados em tempo recorde.

### 📋 Requisitos (FR e NFR)
- **FR**: Baixar páginas HTML, extrair links, salvar o conteúdo estruturado.
- **NFR**: Escalável (milhares de páginas/segundo), robusto a loops de links e DNS lentos.

### 🧩 Peças AWS Recomendadas
- **Fila de Priorização**: Amazon SQS com grupos de mensagens (FIFO) para garantir que requisições ao mesmo domínio sejam espaçadas (polidez).
- **Deduplicação de URL**: Amazon ElastiCache (Redis) com filtros de Bloom ou conjuntos de dados indexados rápidos.
- **Storage de Páginas**: Amazon S3 (para guardar o HTML bruto baixado).
- **Compute**: ECS Fargate (instâncias de workers em containers executando requisições HTTP assíncronas).
- **Banco de Índices / Metadados**: Amazon DynamoDB (guarda o estado atual de cada URL crawled: PENDING, CRAWLED, FAILED).
