# Codebase Modular (Bounded Contexts)

Para projetos escaláveis, a arquitetura deve refletir as fronteiras de negócios (Bounded Contexts) em vez de ser puramente dividida por tecnologia.

## Princípio Fundamental do Design

Na fase de **Design** (ou ao criar novos arquivos na Execução), é **estritamente proibido** criar pastas de topo monolíticas para separar padrões arquiteturais sem encapsulamento de contexto.

❌ **NÃO FAÇA ISSO (Padrão MVC antigo / Fat Layers)**:
```
src/
  controllers/
    UserController
    OrderController
  services/
    UserService
    OrderService
  models/
    User
    Order
```

✅ **FAÇA ASSIM (Domain-Driven / Feature Sliced)**:
```
src/
  domains/ (ou modules/, features/)
    users/
      UserController
      UserService
      UserDTO
    orders/
      OrderController
      OrderService
      OrderDTO
  shared/
    (Apenas código genérico usado por vários domínios)
```

## Como aplicar na Fase de Design

Quando o usuário pedir para `projetar` ou `desenhar` a funcionalidade:
1. Analise quais as entidades de negócios envolvidas (ex: Carrinho, Pagamento, Autenticação).
2. Escreva o `design.md` alocando explicitamente os novos arquivos dentro de seus respectivos *Bounded Contexts* (`src/domains/payment/...`).
3. Se o domínio já existe, estenda-o. Se não existe, crie um novo diretório de domínio e explique sua responsabilidade.
4. Mantenha os acoplamentos baixos. Um módulo não deve importar arquivos diretamente do coração de outro módulo (use interfaces expostas ou a camada "shared" quando absolutamente necessário).
