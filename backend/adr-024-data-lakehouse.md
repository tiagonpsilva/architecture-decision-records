# 🏠 ADR-024: Arquitetura Data Lakehouse

## Status

Proposto

## Contexto

Com a necessidade de combinar as melhores características de Data Lakes e Data Warehouses, mantendo flexibilidade, performance e governança, precisamos de uma arquitetura que permita:

- Suporte a dados estruturados e não estruturados
- Performance de Data Warehouse com flexibilidade de Data Lake
- Garantia de ACID em grandes volumes de dados
- Suporte a múltiplos workloads (BI, ML, Analytics)
- Otimização de custos e recursos

## Decisão

Decidimos adotar uma arquitetura Data Lakehouse utilizando Delta Lake como formato de armazenamento principal, com Apache Spark para processamento e integração com ferramentas modernas de analytics e ML.

```plantuml
@startuml
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

LAYOUT_WITH_LEGEND()

title Arquitetura Data Lakehouse

System_Boundary(c1, "Data Lakehouse") {
    Container(ingestion_layer, "Ingestion Layer", "Apache Kafka/NiFi", "Ingestão de dados")
    
    Container(storage_layer, "Storage Layer", "Delta Lake/S3", "Armazenamento unificado")
    Container(metadata_layer, "Metadata Layer", "Delta Lake/Hive", "Gerenciamento de metadados")
    
    Container(processing_layer, "Processing Layer", "Apache Spark", "Processamento distribuído")
    Container(serving_layer, "Serving Layer", "Presto/Trino", "Serving de dados")
    
    Container(governance_layer, "Governance Layer", "Apache Atlas/Ranger", "Governança e segurança")
    Container(quality_layer, "Quality Layer", "Great Expectations", "Qualidade de dados")
    
    Container(optimization_layer, "Optimization Layer", "Delta Engine", "Otimização de queries")
}

System_Ext(source_systems, "Source Systems", "Sistemas fonte")
System_Ext(bi_tools, "BI Tools", "Ferramentas de BI")
System_Ext(ml_workloads, "ML Workloads", "Cargas de ML")
System_Ext(streaming_apps, "Streaming Apps", "Aplicações streaming")

Rel(source_systems, ingestion_layer, "Dados", "Various Protocols")
Rel(ingestion_layer, storage_layer, "Armazena", "Delta Format")

Rel(storage_layer, metadata_layer, "Registra", "Metadata API")
Rel(metadata_layer, governance_layer, "Governa", "Atlas API")

Rel(storage_layer, processing_layer, "Processa", "Spark SQL")
Rel(processing_layer, serving_layer, "Disponibiliza", "SQL")

Rel(quality_layer, storage_layer, "Valida", "Quality Checks")
Rel(optimization_layer, storage_layer, "Otimiza", "Delta Engine")

Rel(serving_layer, bi_tools, "Consulta", "SQL/JDBC")
Rel(serving_layer, ml_workloads, "Features", "Spark/REST")
Rel(serving_layer, streaming_apps, "Streams", "Structured Streaming")

@enduml
```

### Componentes Principais

1. **Storage Layer**
   - Delta Lake como formato principal
   - Suporte a ACID transactions
   - Time travel e versionamento
   - Schema evolution

2. **Processing Layer**
   - Apache Spark para processamento
   - Suporte a batch e streaming
   - Otimização de queries
   - Resource management

3. **Metadata Layer**
   - Catálogo unificado
   - Schema management
   - Data discovery
   - Lineage tracking

4. **Governance Layer**
   - Controle de acesso
   - Auditoria
   - Compliance
   - Data privacy

## Consequências

### Positivas

- Unificação de data lake e warehouse
- Transações ACID em grande escala
- Melhor performance em queries
- Suporte a múltiplos workloads
- Redução de custos operacionais

### Negativas

- Complexidade de implementação
- Necessidade de expertise específica
- Curva de aprendizado
- Possível vendor lock-in
- Custos iniciais elevados

## Riscos

- Resistência à mudança
- Complexidade operacional
- Dependência de tecnologias específicas
- Performance em casos extremos
- Custos não previstos

### Mitigação

- Treinamento extensivo
- POCs bem definidas
- Arquitetura modular
- Monitoramento robusto
- Planejamento de custos

## Alternativas Consideradas

1. **Arquitetura Lambda**
   - Complexidade maior
   - Duplicação de código
   - Custos mais altos

2. **Data Warehouse + Data Lake**
   - Ambientes separados
   - Sincronização complexa
   - Custos duplicados

3. **Cloud Data Warehouse**
   - Menor flexibilidade
   - Custos mais altos
   - Vendor lock-in

## Referências

- [Lakehouse Architecture](https://databricks.com/blog/2020/01/30/what-is-a-data-lakehouse.html)
- [Delta Lake Documentation](https://docs.delta.io/latest/delta-intro.html)
- [Modern Analytics Architecture](https://www.databricks.com/blog/2019/08/14/productionizing-machine-learning-with-delta-lake.html)
- [Data Mesh Principles](https://martinfowler.com/articles/data-mesh-principles.html)

## Notas

- Implementar gradualmente por domínio
- Estabelecer práticas de DataOps
- Definir métricas de sucesso
- Criar centro de excelência
- Documentar best practices 