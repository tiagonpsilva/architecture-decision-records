# 📚 Architecture Decision Records (ADRs)

Este diretório contém os Architecture Decision Records (ADRs) do projeto, que documentam decisões arquiteturais importantes.

## 🤔 O que é uma ADR?

Uma ADR (Architecture Decision Record) é um documento que captura uma decisão arquitetural importante tomada em relação ao projeto, junto com seu contexto e consequências. É uma prática que ajuda a:

- **Documentar Decisões**: Registra não apenas o que foi decidido, mas também por que foi decidido, considerando o contexto temporal e técnico.
- **Facilitar Comunicação**: Permite que toda a equipe e stakeholders entendam as escolhas arquiteturais e suas motivações.
- **Manter Histórico**: Preserva o conhecimento mesmo quando membros da equipe mudam, evitando que decisões sejam questionadas ou revertidas sem compreensão adequada.
- **Guiar Evolução**: Ajuda a entender o impacto de mudanças futuras e mantém a consistência arquitetural.

### 📅 Quando Criar uma ADR?

Uma ADR deve ser criada quando uma decisão:
- Tem impacto significativo na arquitetura do sistema
- Afeta múltiplos componentes ou equipes
- Envolve trade-offs importantes
- Representa um compromisso técnico significativo
- Estabelece padrões ou convenções importantes

### 📝 Componentes de uma ADR

Cada ADR deve conter:
1. **Título**: Identificador único e nome descritivo
2. **Status**: Estado atual da decisão (proposto, aceito, depreciado, etc.)
3. **Contexto**: Situação que levou à necessidade da decisão
4. **Decisão**: A escolha feita e sua justificativa
5. **Consequências**: Impactos positivos e negativos da decisão
6. **Alternativas**: Outras opções consideradas e por que não foram escolhidas
7. **Referências**: Links e recursos relacionados

## 📂 Estrutura do Diretório

### 📋 Template
- [`template.md`](template.md) - Template base para novos ADRs

### 🏛️ Padrões Arquiteturais e Design
- [`adr-011-ddd-hexagonal.md`](adr-011-ddd-hexagonal.md) - DDD e Arquitetura Hexagonal
- [`adr-012-data-modeling.md`](adr-012-data-modeling.md) - Estratégia de Modelagem de Dados
- [`adr-013-openapi-standard.md`](adr-013-openapi-standard.md) - Padronização de APIs com OpenAPI
- [`adr-019-twelve-factor.md`](adr-019-twelve-factor.md) - Adoção do Padrão 12-Factor App

### 💻 Tecnologias e Linguagens
- [`adr-001-typescript-frontend.md`](adr-001-typescript-frontend.md) - Adoção de TypeScript para Frontend
- [`adr-017-golang-adoption.md`](adr-017-golang-adoption.md) - Adoção de Go para Microsserviços
- [`adr-018-python-adoption.md`](adr-018-python-adoption.md) - Adoção de Python para Serviços de Dados e ML

### 🎨 Frontend e UI
- [`adr-002-react-query.md`](adr-002-react-query.md) - Uso do React Query para Gerenciamento de Estado
- [`adr-021-microfrontends.md`](adr-021-microfrontends.md) - Adoção de Microfrontends

### 🔧 Backend e Dados
- [`adr-003-microservices.md`](adr-003-microservices.md) - Migração para Arquitetura de Microsserviços
- [`adr-004-cqrs.md`](adr-004-cqrs.md) - Adoção do Padrão CQRS
- [`adr-006-mongodb-profiles.md`](adr-006-mongodb-profiles.md) - Adoção de MongoDB para Dados de Perfil
- [`adr-007-graphql-api.md`](adr-007-graphql-api.md) - Adoção de GraphQL para APIs Públicas
- [`adr-023-medallion-architecture.md`](adr-023-medallion-architecture.md) - Arquitetura Medallion para Data Lake
- [`adr-024-data-lakehouse.md`](adr-024-data-lakehouse.md) - Implementação de Data Lakehouse

### 🔒 Segurança e Autenticação
- [`adr-005-oauth-openid.md`](adr-005-oauth-openid.md) - Implementação de OAuth 2.0 e OpenID Connect
- [`adr-014-sso-implementation.md`](adr-014-sso-implementation.md) - Implementação de SSO com OAuth2/OpenID

### 🚀 DevOps e Infraestrutura
- [`adr-008-cd-canary.md`](adr-008-cd-canary.md) - Implantação Contínua com Canary Releases
- [`adr-009-git-flow.md`](adr-009-git-flow.md) - Estratégia Git Flow e Branching
- [`adr-010-cloud-aws.md`](adr-010-cloud-aws.md) - Adoção da AWS como Plataforma Cloud
- [`adr-025-infrastructure-as-code.md`](adr-025-infrastructure-as-code.md) - Adoção de Infraestrutura como Código (IaC)

### 🔄 Comunicação e Integração
- [`adr-016-messaging-patterns.md`](adr-016-messaging-patterns.md) - Padrões de Mensageria com RabbitMQ
- [`adr-020-websocket.md`](adr-020-websocket.md) - WebSocket para Comunicação Real-time
- [`adr-022-event-driven.md`](adr-022-event-driven.md) - Arquitetura Orientada a Eventos

### ✅ Qualidade e Testes
- [`adr-015-test-patterns.md`](adr-015-test-patterns.md) - Padrões de Testes

## 📖 Como usar este diretório

1. Para criar um novo ADR:
   - Use o arquivo `template.md` como base
   - Nomeie seguindo o padrão `adr-NNN-titulo-descritivo.md`
   - Preencha todas as seções do template
   - Adicione links para outros ADRs relacionados

2. Ao submeter um ADR:
   - Atualize este README.md adicionando o novo ADR na categoria apropriada
   - Verifique se todos os links estão funcionando
   - Submeta através de um pull request para revisão

3. Ao atualizar um ADR existente:
   - Mantenha o histórico de alterações no próprio documento
   - Atualize o status conforme necessário
   - Documente as razões das mudanças

## 💡 Melhores Práticas

### 📝 Conteúdo
- Mantenha os ADRs concisos e diretos
- Use linguagem clara e evite jargões desnecessários
- Inclua exemplos de código quando relevante
- Documente alternativas consideradas
- Liste consequências positivas e negativas
- Identifique riscos e suas mitigações

### ⚙️ Processo
- Discuta os ADRs em reuniões de arquitetura
- Obtenha feedback da equipe técnica
- Mantenha o status atualizado
- Referencie outros ADRs quando relevante
- Revise periodicamente ADRs antigos

### 📊 Organização
- Mantenha a categorização consistente
- Use links para facilitar a navegação
- Atualize índices e referências
- Mantenha a formatação padronizada

## 🔄 Status dos ADRs

Os ADRs podem ter os seguintes status:
- **Proposto**: Inicial, em discussão
- **Aceito**: Aprovado e válido
- **Depreciado**: Não mais recomendado
- **Substituído**: Substituído por outro ADR
- **Supersedido**: Atualizado por versão mais recente