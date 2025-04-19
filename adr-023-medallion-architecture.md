# 🏅 ADR-023: Arquitetura de Dados Medalhão

## Status

Proposto

## Contexto

Com o crescimento do volume de dados e a necessidade de garantir qualidade, governança e performance no processamento de dados, precisamos de uma arquitetura que permita:

- Organização clara dos dados por níveis de refinamento
- Garantia de qualidade dos dados
- Otimização de custos de armazenamento e processamento
- Rastreabilidade e governança de dados
- Suporte a diferentes casos de uso (analytics, ML, BI)

## Decisão

Decidimos adotar a Arquitetura Medalhão (Bronze, Prata e Ouro) utilizando Delta Lake como principal tecnologia, implementada sobre Apache Spark e armazenamento em cloud.

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

LAYOUT_WITH_LEGEND()

title Arquitetura de Dados Medalhão

System_Boundary(c1, "Data Platform") {
    Container(ingestion, "Data Ingestion", "Apache NiFi/Kafka", "Ingestão de dados")
    
    Container(bronze, "Bronze Layer", "Delta Lake", "Dados brutos")
    Container(silver, "Silver Layer", "Delta Lake", "Dados limpos e padronizados")
    Container(gold, "Gold Layer", "Delta Lake", "Dados agregados e preparados")
    
    Container(data_quality, "Data Quality", "Great Expectations", "Validação de dados")
    Container(data_catalog, "Data Catalog", "Apache Atlas", "Catálogo de metadados")
    
    Container(spark_processing, "Data Processing", "Apache Spark", "Processamento distribuído")
    Container(airflow, "Orchestration", "Apache Airflow", "Orquestração de pipelines")
}

System_Ext(source_systems, "Source Systems", "Sistemas fonte")
System_Ext(bi_tools, "BI Tools", "Ferramentas de BI")
System_Ext(ml_platform, "ML Platform", "Plataforma de ML")

Rel(source_systems, ingestion, "Dados brutos", "Various Protocols")
Rel(ingestion, bronze, "Ingestão", "Parquet/Delta")

Rel(bronze, spark_processing, "Processa", "Spark SQL")
Rel(spark_processing, silver, "Transforma", "Delta")
Rel(silver, spark_processing, "Processa", "Spark SQL")
Rel(spark_processing, gold, "Agrega", "Delta")

Rel(data_quality, bronze, "Valida", "Great Expectations")
Rel(data_quality, silver, "Valida", "Great Expectations")
Rel(data_quality, gold, "Valida", "Great Expectations")

Rel(data_catalog, bronze, "Cataloga", "Atlas API")
Rel(data_catalog, silver, "Cataloga", "Atlas API")
Rel(data_catalog, gold, "Cataloga", "Atlas API")

Rel(airflow, spark_processing, "Orquestra", "Airflow API")

Rel(gold, bi_tools, "Consumo", "SQL/REST")
Rel(gold, ml_platform, "Features", "Spark/REST")

@enduml
```

### Camadas da Arquitetura

1. **Bronze (Raw)**
   - Dados brutos sem transformação
   - Formato Delta Lake para versionamento
   - Retenção configurável por fonte
   - Schema inference e evolution

2. **Silver (Cleaned)**
   - Dados limpos e padronizados
   - Validações de qualidade
   - Deduplicação e correções
   - Schema enforcement

3. **Gold (Business)**
   - Dados agregados por domínio
   - Modelos dimensionais
   - Feature stores
   - Otimização para consulta

4. **Componentes de Suporte**
   - Data Quality Framework
   - Data Catalog
   - Monitoring & Alerting
   - Data Lineage

## Consequências

### Positivas

- Melhor organização dos dados
- Garantia de qualidade por camada
- Otimização de custos
- Facilidade de governança
- Suporte a múltiplos casos de uso

### Negativas

- Maior latência end-to-end
- Custos de armazenamento
- Complexidade de manutenção
- Necessidade de orquestração robusta
- Overhead de processamento

## Riscos

- Duplicação excessiva de dados
- Custos operacionais elevados
- Complexidade de debugging
- Performance em casos específicos
- Dependência de skills específicos

### Mitigação

- Políticas de retenção por camada
- Monitoramento de custos
- Ferramentas de observabilidade
- Otimização de queries
- Treinamento das equipes

## Alternativas Consideradas

1. **Data Warehouse Tradicional**
   - Mais simples de implementar
   - Menor flexibilidade
   - Custos mais altos

2. **Data Lake Puro**
   - Maior flexibilidade
   - Desafios de governança
   - Complexidade de manutenção

3. **Kappa Architecture**
   - Processamento em tempo real
   - Maior complexidade
   - Custos mais altos

## Referências

- [Delta Lake Documentation](https://docs.delta.io/latest/delta-intro.html)
- [Medallion Architecture](https://databricks.com/glossary/medallion-architecture)
- [Modern Data Platform](https://www.thoughtworks.com/insights/blog/data-mesh-modern-data-platform)
- [Data Quality Best Practices](https://greatexpectations.io/blog)

## Notas

- Implementar gradualmente por domínio
- Estabelecer padrões de nomenclatura
- Definir SLAs por camada
- Documentar processos de validação
- Criar runbooks operacionais 