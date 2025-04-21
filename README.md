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

## 📂 ADRs por Tema

### 🏛️ Arquitetura Base
- [`adr-039-c4model-diagrams`](adr-039-c4model-diagrams.md) - Padronização de diagramas usando C4Model
- [`adr-011-ddd-hexagonal`](patterns/adr-011-ddd-hexagonal.md) - Arquitetura hexagonal e DDD para design de domínio
- [`adr-019-twelve-factor`](patterns/adr-019-twelve-factor.md) - Princípios 12-factor para aplicações cloud-native

### 💻 Tecnologias e Frameworks
- [`adr-001-typescript-frontend`](technologies/adr-001-typescript-frontend.md) - TypeScript para desenvolvimento frontend
- [`adr-036-typescript-adoption`](technologies/adr-036-typescript-adoption.md) - Adoção geral de TypeScript
- [`adr-017-golang-adoption`](technologies/adr-017-golang-adoption.md) - Go para microsserviços
- [`adr-018-python-adoption`](technologies/adr-018-python-adoption.md) - Python para dados e ML

### 🎨 Frontend
- [`adr-002-react-query`](frontend/adr-002-react-query.md) - Gerenciamento de estado com React Query
- [`adr-021-microfrontends`](frontend/adr-021-microfrontends.md) - Arquitetura de microfrontends

### 🔧 Backend e Dados
- [`adr-003-microservices`](backend/adr-003-microservices.md) - Arquitetura de microsserviços
- [`adr-004-cqrs`](backend/adr-004-cqrs.md) - CQRS para separação de leitura/escrita
- [`adr-006-mongodb-profiles`](backend/adr-006-mongodb-profiles.md) - MongoDB para dados de perfil
- [`adr-007-graphql-api`](backend/adr-007-graphql-api.md) - GraphQL para APIs
- [`adr-023-medallion-architecture`](backend/adr-023-medallion-architecture.md) - Arquitetura Medallion para datalake
- [`adr-024-data-lakehouse`](backend/adr-024-data-lakehouse.md) - Implementação de data lakehouse
- [`adr-012-data-modeling`](patterns/adr-012-data-modeling.md) - Estratégias de modelagem de dados
- [`adr-013-openapi-standard`](patterns/adr-013-openapi-standard.md) - OpenAPI para documentação

### 🔒 Segurança
- [`adr-005-oauth-openid`](security/adr-005-oauth-openid.md) - Autenticação com OAuth 2.0/OpenID
- [`adr-014-sso-implementation`](security/adr-014-sso-implementation.md) - Single Sign-On (SSO)
- [`adr-034-owasp`](security/adr-034-owasp.md) - Práticas OWASP

### 🚀 DevOps
- [`adr-008-cd-canary`](devops/adr-008-cd-canary.md) - Canary releases
- [`adr-009-git-flow`](devops/adr-009-git-flow.md) - Estratégia de branches
- [`adr-010-cloud-aws`](devops/adr-010-cloud-aws.md) - AWS como cloud provider
- [`adr-025-infrastructure-as-code`](devops/adr-025-infrastructure-as-code.md) - IaC
- [`adr-028-kubernetes`](devops/adr-028-kubernetes.md) - Orquestração Kubernetes
- [`adr-056-application-lifecycle`](devops/adr-056-application-lifecycle.md) - Gestão de ciclo de vida

### 🔄 Comunicação e Eventos
- [`adr-016-messaging-patterns`](communication/adr-016-messaging-patterns.md) - Padrões com RabbitMQ
- [`adr-020-websocket`](communication/adr-020-websocket.md) - WebSocket para real-time
- [`adr-022-event-driven`](communication/adr-022-event-driven.md) - Arquitetura event-driven

### 📊 Qualidade e Observabilidade
- [`adr-015-test-patterns`](quality/adr-015-test-patterns.md) - Padrões de teste
- [`adr-033-quality-gates-cicd`](quality/adr-033-quality-gates-cicd.md) - Quality gates
- [`adr-035-observability`](operations/adr-035-observability.md) - Estratégia de observabilidade
- [`adr-055-cache-strategy`](performance/adr-055-cache-strategy.md) - Cache multi-camada

### 🤖 IA e ML
- [`adr-029-mcp`](ai/adr-029-mcp.md) - Model Context Protocol
- [`adr-030-rag`](ai/adr-030-rag.md) - Retrieval Augmented Generation
- [`adr-031-quality-gates`](ai/adr-031-quality-gates.md) - Quality gates para IA
- [`adr-032-prompt-engineering`](ai/adr-032-prompt-engineering.md) - Engenharia de prompts

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