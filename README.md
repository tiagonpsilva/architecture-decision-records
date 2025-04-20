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
- [`patterns/adr-011-ddd-hexagonal.md`](patterns/adr-011-ddd-hexagonal.md) - DDD e Arquitetura Hexagonal
- [`patterns/adr-012-data-modeling.md`](patterns/adr-012-data-modeling.md) - Estratégia de Modelagem de Dados
- [`patterns/adr-013-openapi-standard.md`](patterns/adr-013-openapi-standard.md) - Padronização de APIs com OpenAPI
- [`patterns/adr-019-twelve-factor.md`](patterns/adr-019-twelve-factor.md) - Adoção do Padrão 12-Factor App

### 💻 Tecnologias e Linguagens
- [`technologies/adr-001-typescript-frontend.md`](technologies/adr-001-typescript-frontend.md) - Adoção de TypeScript para Frontend
- [`technologies/adr-017-golang-adoption.md`](technologies/adr-017-golang-adoption.md) - Adoção de Go para Microsserviços
- [`technologies/adr-018-python-adoption.md`](technologies/adr-018-python-adoption.md) - Adoção de Python para Serviços de Dados e ML
- [`technologies/adr-036-typescript-adoption.md`](technologies/adr-036-typescript-adoption.md) - Adoção Geral do TypeScript

### 🎨 Frontend e UI
- [`frontend/adr-002-react-query.md`](frontend/adr-002-react-query.md) - Uso do React Query para Gerenciamento de Estado
- [`frontend/adr-021-microfrontends.md`](frontend/adr-021-microfrontends.md) - Adoção de Microfrontends

### 🔧 Backend e Dados
- [`backend/adr-003-microservices.md`](backend/adr-003-microservices.md) - Migração para Arquitetura de Microsserviços
- [`backend/adr-004-cqrs.md`](backend/adr-004-cqrs.md) - Adoção do Padrão CQRS
- [`backend/adr-006-mongodb-profiles.md`](backend/adr-006-mongodb-profiles.md) - Adoção de MongoDB para Dados de Perfil
- [`backend/adr-007-graphql-api.md`](backend/adr-007-graphql-api.md) - Adoção de GraphQL para APIs Públicas
- [`backend/adr-023-medallion-architecture.md`](backend/adr-023-medallion-architecture.md) - Arquitetura Medallion para Data Lake
- [`backend/adr-024-data-lakehouse.md`](backend/adr-024-data-lakehouse.md) - Implementação de Data Lakehouse

### 🔒 Segurança e Autenticação
- [`security/adr-005-oauth-openid.md`](security/adr-005-oauth-openid.md) - Implementação de OAuth 2.0 e OpenID Connect
- [`security/adr-014-sso-implementation.md`](security/adr-014-sso-implementation.md) - Implementação de SSO com OAuth2/OpenID
- [`security/adr-034-owasp.md`](security/adr-034-owasp.md) - Práticas de Segurança OWASP

### 🚀 DevOps e Infraestrutura
- [`devops/adr-008-cd-canary.md`](devops/adr-008-cd-canary.md) - Implantação Contínua com Canary Releases
- [`devops/adr-009-git-flow.md`](devops/adr-009-git-flow.md) - Estratégia Git Flow e Branching
- [`devops/adr-010-cloud-aws.md`](devops/adr-010-cloud-aws.md) - Adoção da AWS como Plataforma Cloud
- [`devops/adr-025-infrastructure-as-code.md`](devops/adr-025-infrastructure-as-code.md) - Adoção de Infraestrutura como Código (IaC)
- [`devops/adr-026-devex.md`](devops/adr-026-devex.md) - Developer Experience (DevEx)
- [`devops/adr-027-docker.md`](devops/adr-027-docker.md) - Containerização com Docker
- [`devops/adr-028-kubernetes.md`](devops/adr-028-kubernetes.md) - Orquestração com Kubernetes
- [`devops/adr-034-dev-environment-ai.md`](devops/adr-034-dev-environment-ai.md) - Ambiente de Desenvolvimento com IA
- [`devops/adr-054-argocd-gitops.md`](devops/adr-054-argocd-gitops.md) - GitOps com ArgoCD

### 🔄 Comunicação e Integração
- [`communication/adr-016-messaging-patterns.md`](communication/adr-016-messaging-patterns.md) - Padrões de Mensageria com RabbitMQ
- [`communication/adr-020-websocket.md`](communication/adr-020-websocket.md) - WebSocket para Comunicação Real-time
- [`communication/adr-022-event-driven.md`](communication/adr-022-event-driven.md) - Arquitetura Event-Driven
- [`communication/adr-044-kafka-events.md`](communication/adr-044-kafka-events.md) - Apache Kafka para Comunicação Baseada em Eventos
- [`communication/adr-045-grpc-services.md`](communication/adr-045-grpc-services.md) - gRPC para Comunicação entre Serviços

### ✅ Qualidade e Testes
- [`quality/adr-015-test-patterns.md`](quality/adr-015-test-patterns.md) - Padrões de Testes
- [`quality/adr-033-quality-gates-cicd.md`](quality/adr-033-quality-gates-cicd.md) - Quality Gates na Esteira de CI/CD

### 🔍 Operações e Monitoramento
- [`operations/adr-035-observability.md`](operations/adr-035-observability.md) - Observabilidade

### 🚀 Performance
- [`performance/adr-055-cache-strategy.md`](performance/adr-055-cache-strategy.md) - Estratégia de Cache Multi-Camada

### 🤖 Inteligência Artificial
- [`ai/adr-029-mcp.md`](ai/adr-029-mcp.md) - Model Context Protocol (MCP)
- [`ai/adr-030-rag.md`](ai/adr-030-rag.md) - Retrieval Augmented Generation (RAG)
- [`ai/adr-031-quality-gates.md`](ai/adr-031-quality-gates.md) - Quality Gates para IA
- [`ai/adr-032-prompt-engineering.md`](ai/adr-032-prompt-engineering.md) - Engenharia de Prompts para GenAI
- [`ai/adr-040-mcp-api-agents.md`](ai/adr-040-mcp-api-agents.md) - MCPs para APIs como Agentes
- [`ai/adr-041-ml-projects.md`](ai/adr-041-ml-projects.md) - Estrutura de Projetos de Machine Learning
- [`ai/adr-046-ocr-system.md`](ai/adr-046-ocr-system.md) - Sistema de OCR para Processamento de Documentos
- [`ai/adr-047-web-scraping.md`](ai/adr-047-web-scraping.md) - Sistema de Web Scraping
- [`ai/adr-048-team-agents.md`](ai/adr-048-team-agents.md) - Agentes Especializados para Time de Desenvolvimento

### 🧪 Testes
- [`testing/adr-050-selenium-tests.md`](testing/adr-050-selenium-tests.md) - Testes de Interface com Selenium
- [`testing/adr-051-cypress-tests.md`](testing/adr-051-cypress-tests.md) - Testes E2E com Cypress

### 📊 Monitoramento
- [`monitoring/adr-052-prometheus-monitoring.md`](monitoring/adr-052-prometheus-monitoring.md) - Monitoramento com Prometheus
- [`monitoring/adr-053-datadog-monitoring.md`](monitoring/adr-053-datadog-monitoring.md) - Monitoramento com Datadog

### 🔍 Busca
- [`search/adr-055-elasticsearch.md`](search/adr-055-elasticsearch.md) - Adoção do ElasticSearch

### 💾 Cache
- [`cache/adr-056-redis.md`](cache/adr-056-redis.md) - Estratégia de Cache com Redis

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

## 📁 Estrutura de Pastas

```
architecture-decision-records/
├── README.md
├── template.md
├── generate-plantuml-png.sh
├── diagrams/                          # Diretório central de diagramas
│   ├── adr-001-typescript-frontend.png
│   ├── adr-001-typescript-frontend.wsd
│   ├── adr-002-react-query.png
│   ├── adr-002-react-query.wsd
│   ├── adr-003-microservices.png
│   ├── adr-003-microservices.wsd
│   └── ... (outros diagramas)
├── patterns/
│   ├── adr-011-ddd-hexagonal.md
│   ├── adr-012-data-modeling.md
│   ├── adr-013-openapi-standard.md
│   └── adr-019-twelve-factor.md
├── technologies/
│   ├── adr-001-typescript-frontend.md
│   ├── adr-017-golang-adoption.md
│   ├── adr-018-python-adoption.md
│   └── adr-036-typescript-adoption.md
├── frontend/
│   ├── adr-002-react-query.md
│   └── adr-021-microfrontends.md
├── backend/
│   ├── adr-003-microservices.md
│   ├── adr-004-cqrs.md
│   ├── adr-006-mongodb-profiles.md
│   ├── adr-007-graphql-api.md
│   ├── adr-023-medallion-architecture.md
│   └── adr-024-data-lakehouse.md
├── security/
│   ├── adr-005-oauth-openid.md
│   ├── adr-014-sso-implementation.md
│   └── adr-034-owasp.md
├── devops/
│   ├── adr-008-cd-canary.md
│   ├── adr-009-git-flow.md
│   ├── adr-010-cloud-aws.md
│   ├── adr-025-infrastructure-as-code.md
│   ├── adr-026-devex.md
│   ├── adr-027-docker.md
│   ├── adr-028-kubernetes.md
│   ├── adr-034-dev-environment-ai.md
│   ├── adr-054-argocd-gitops.md
│   └── diagrams/
│       ├── adr-056-application-lifecycle.wsd
│       └── adr-056-application-lifecycle.png
├── communication/
│   ├── adr-016-messaging-patterns.md
│   ├── adr-020-websocket.md
│   └── adr-022-event-driven.md
├── quality/
│   ├── adr-015-test-patterns.md
│   └── adr-033-quality-gates-cicd.md
├── operations/
│   └── adr-035-observability.md
├── performance/
│   ├── adr-055-cache-strategy.md
│   └── diagrams/
│       ├── adr-055-cache-strategy.wsd
│       └── adr-055-cache-strategy.png
├── ai/
│   ├── adr-029-mcp.md
│   ├── adr-030-rag.md
│   ├── adr-031-quality-gates.md
│   └── adr-032-prompt-engineering.md
├── monitoring/
│   ├── adr-052-prometheus-monitoring.md
│   └── diagrams/
│       ├── adr-052-prometheus-monitoring.wsd
│       └── adr-052-prometheus-monitoring.png
└── testing/
    ├── adr-050-selenium-tests.md
    ├── adr-051-cypress-tests.md
    └── diagrams/
        ├── adr-050-selenium-tests.wsd
        ├── adr-050-selenium-tests.png
        ├── adr-051-cypress-tests.wsd
        └── adr-051-cypress-tests.png
```

Esta estrutura organiza os ADRs por categorias, facilitando a navegação e manutenção dos documentos. Cada categoria tem seu próprio diretório e pode conter subdiretórios específicos, como o diretório `diagrams` para armazenar diagramas relacionados aos ADRs.