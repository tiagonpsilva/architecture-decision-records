# Registros de Decisão de Arquitetura (ADRs)

Este repositório contém os Registros de Decisão de Arquitetura (Architecture Decision Records - ADRs) do nosso projeto, documentando as decisões arquiteturais significativas tomadas pela equipe.

## Estrutura do Repositório

```
architecture-decision-records/
├── devops/
│   ├── adr-056-application-lifecycle.md
│   └── diagrams/
│       └── adr-056-application-lifecycle.png
├── performance/
│   ├── adr-055-cache-strategy.md
│   └── diagrams/
│       └── adr-055-cache-strategy.png
└── README.md
```

## ADRs Disponíveis

### Performance
- [ADR-055: Estratégia de Cache](performance/adr-055-cache-strategy.md)
  - Define a estratégia de cache multi-camada
  - Inclui políticas de invalidação e monitoramento
  - Diagrama disponível em: [Cache Strategy Diagram](performance/diagrams/adr-055-cache-strategy.png)

### DevOps
- [ADR-056: Gerenciamento do Ciclo de Vida de Aplicações](devops/adr-056-application-lifecycle.md)
  - Estabelece políticas de versionamento e atualização
  - Define estratégias de migração e monitoramento
  - Diagrama disponível em: [Application Lifecycle Diagram](devops/diagrams/adr-056-application-lifecycle.png)

## Como Visualizar os Diagramas

Os diagramas são gerados usando PlantUML. Para visualizar ou atualizar os diagramas:

1. Certifique-se de ter o PlantUML instalado
2. Execute o comando para gerar os PNGs:
   ```bash
   plantuml **/*.wsd
   ```

## Convenções

### Estrutura dos ADRs
Cada ADR segue o seguinte formato:
- Título e Número
- Status
- Contexto
- Decisão
- Consequências
- Riscos
- Alternativas Consideradas
- Referências
- Notas
- Exemplos de Configuração
- Métricas de Avaliação

### Nomenclatura
- Arquivos ADR: `adr-NNN-titulo-descritivo.md`
- Diagramas: `adr-NNN-titulo-descritivo.wsd` e `.png`
- Numeração: Sequencial começando em 001

## Contribuindo

1. Crie um novo branch para seu ADR
2. Use os templates existentes como referência
3. Inclua diagramas quando relevante
4. Submeta um Pull Request para revisão

## Ferramentas Utilizadas

- PlantUML para diagramação
- Markdown para documentação
- C4 Model para arquitetura
- Git para versionamento