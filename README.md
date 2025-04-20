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

## 📁 Estrutura de Pastas

```
architecture-decision-records/
├── README.md
├── template.md
├── generate-plantuml-png.sh
├── diagrams/                          # Diretório central de diagramas
│   ├── adr-001-typescript-frontend.png
│   ├── adr-001-typescript-frontend.puml
│   ├── adr-002-react-query.png
│   ├── adr-002-react-query.puml
│   ├── adr-003-microservices.png
│   ├── adr-003-microservices.puml
│   └── ... (outros diagramas)
├── ai/                               # Inteligência Artificial
│   ├── adr-029-mcp.md
│   ├── adr-030-rag.md
│   ├── adr-031-quality-gates.md
│   ├── adr-032-prompt-engineering.md
│   ├── adr-040-mcp-api-agents.md
│   ├── adr-041-ml-projects.md
│   ├── adr-046-ocr-system.md
│   ├── adr-047-web-scraping.md
│   └── adr-048-team-agents.md
├── backend/                          # Backend
│   ├── adr-017-golang-adoption.md
│   ├── adr-018-python-adoption.md
│   └── adr-035-log-standardization.md
├── cache/                            # Cache
│   └── adr-056-redis.md
├── communication/                    # Comunicação e Integração
│   ├── adr-016-messaging-patterns.md
│   ├── adr-020-websocket.md
│   ├── adr-022-event-driven.md
│   ├── adr-044-kafka-events.md
│   └── adr-045-grpc-services.md
├── data/                            # Dados
│   ├── adr-006-mongodb-profiles.md
│   ├── adr-012-data-modeling.md
│   ├── adr-023-medallion-architecture.md
│   ├── adr-024-data-lakehouse.md
│   └── adr-055-elasticsearch.md
├── devops/                          # DevOps e Infraestrutura
│   ├── adr-008-cd-canary.md
│   ├── adr-009-git-flow.md
│   ├── adr-010-cloud-aws.md
│   ├── adr-025-infrastructure-as-code.md
│   ├── adr-026-devex.md
│   ├── adr-027-docker.md
│   ├── adr-028-kubernetes.md
│   ├── adr-034-dev-environment-ai.md
│   └── adr-054-argocd-gitops.md
├── frontend/                        # Frontend
│   ├── adr-002-react-query.md
│   └── adr-021-microfrontends.md
├── monitoring/                      # Monitoramento
│   ├── adr-052-prometheus-monitoring.md
│   └── adr-053-datadog-monitoring.md
├── patterns/                        # Padrões e Arquitetura
│   ├── adr-013-openapi-standard.md
│   └── adr-019-twelve-factor.md
├── security/                        # Segurança
│   ├── adr-005-oauth-openid.md
│   ├── adr-014-sso-implementation.md
│   └── adr-034-owasp.md
├── software-architecture/           # Arquitetura de Software
│   ├── adr-003-microservices.md
│   ├── adr-004-cqrs.md
│   ├── adr-007-graphql-api.md
│   └── adr-011-ddd-hexagonal.md
├── technologies/                    # Tecnologias
│   ├── adr-001-typescript-frontend.md
│   └── adr-036-typescript-adoption.md
└── testing/                        # Testes
    ├── adr-050-selenium-tests.md
    └── adr-051-cypress-tests.md
```

Esta estrutura organiza os ADRs por categorias, facilitando a navegação e manutenção dos documentos. O diretório `diagrams` centraliza todos os diagramas relacionados aos ADRs, enquanto cada categoria tem seu próprio diretório com os respectivos documentos.

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